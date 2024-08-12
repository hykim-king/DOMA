package com.acorn.doma.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.locationtech.proj4j.ProjCoordinate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Point;
import com.acorn.doma.mapper.PointMapper;
import com.acorn.doma.proj4j.CoordinateConverter;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
@Service
public class PointServiceImpl implements PointService, PLog{
	
	private final String serviceKey;
	
	@Autowired
	PointMapper pointMapper;
	
	private static final String[] YEARS = {"2017", "2018", "2019", "2020", "2021", "2022"};
    private static final String[] DISTRICTS = {
        "110", "140", "170", "200", "215", "230", "260", "290", "305", "320",
        "350", "380", "410", "440", "470", "500", "530", "545", "560", "590",
        "620", "650", "680", "710", "740"
    };
	public PointServiceImpl(PointMapper pointMapper,@Qualifier("pointdeathServiceKey") String serviceKey){ 
		this.serviceKey = serviceKey;
		this.pointMapper = pointMapper;
	}
	
	@Override
	public String fetchDataFromApi(String year, String guGunCode) throws IOException {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/accidentRiskArea/getRestAccidentRiskArea"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="+serviceKey);
        urlBuilder.append("&" + URLEncoder.encode("searchYearCd", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("siDo","UTF-8") + "=" + URLEncoder.encode("11", "UTF-8")); /*법정동 시도 코드*/
        urlBuilder.append("&" + URLEncoder.encode("guGun", "UTF-8") + "=" + URLEncoder.encode(guGunCode, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*결과형식(xml/json)*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("5000", "UTF-8")); /*검색건수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        String jsonData = sb.toString();
		
        return jsonData;
	}

	@Override
	public JsonArray parseJsonData(String jsonData) {
		JsonElement jsonElement = JsonParser.parseString(jsonData); // JSON 문자열을 JsonElement로 파싱합니다.
	    JsonObject jsonObject = jsonElement.getAsJsonObject();

	    // JSON 응답 구조에 맞게 데이터 추출
	    JsonArray items = jsonObject.has("items") && jsonObject.getAsJsonObject("items").has("item")
	            ? jsonObject.getAsJsonObject("items").getAsJsonArray("item")
	            : new JsonArray(); // 빈 JsonArray 반환

	    return items;
	}

	@Override
	public String getJsonElementAsString(JsonObject jsonObject, String key) {
		JsonElement element = jsonObject.get(key);
        if (element == null || element.isJsonNull()) {
            return null;
        }
        if (element.isJsonArray()) {
            JsonArray array = element.getAsJsonArray();
            return array.size() > 0 ? String.join(", ", array.getAsJsonArray().toString()) : null;
        }
        return element.getAsString();
	}

	@Override
	public void insertPointData() throws IOException {
		for (String year : YEARS) {
            for (String guGunCode : DISTRICTS) {
                log.debug("Fetching data for year: " + year + ", district code: " + guGunCode);
                String jsonData = fetchDataFromApi(year, guGunCode);
                JsonArray items = parseJsonData(jsonData);
                saveDataToDatabase(items);
            }
        }
		
	}

	@Override
	public void saveDataToDatabase(JsonArray items) {
		try {
			for(JsonElement item:items) {
				JsonObject data = item.getAsJsonObject();
				Point point = new Point();
				String accPoint = getJsonElementAsString(data, "acc_risk_area_nm");
	            
	            // Extract year and gname from acc_point
	            Map<String, String> extractedData = extractYearAndGname(accPoint);
	            String year = extractedData.get("year");
	            String gname = extractedData.get("gname");
				point.setPid(getJsonElementAsString(data, "acc_risk_area_id"));
				point.setAccPoint( getJsonElementAsString(data, "acc_risk_area_nm"));
				point.setAccident(Integer.parseInt(getJsonElementAsString(data, "tot_acc_cnt")));
				point.setDead(Integer.parseInt(getJsonElementAsString(data, "tot_dth_dnv_cnt")));
				point.setSeriously(Integer.parseInt(getJsonElementAsString(data, "tot_se_dnv_cnt")));
				point.setOrdinary(Integer.parseInt(getJsonElementAsString(data, "tot_sl_dnv_cnt")));
				point.setReport(Integer.parseInt(getJsonElementAsString(data, "tot_wnd_dnv_cnt")));
				point.setPointType(getJsonElementAsString(data, "cause_anals_ty_nm"));
				 // Convert coordinates from GRS80 / TM to WGS84
	            double epsg5179Longitude = Double.parseDouble(getJsonElementAsString(data, "cntpnt_utmk_x_crd"));
	            double epsg5179Latitude = Double.parseDouble(getJsonElementAsString(data, "cntpnt_utmk_y_crd"));
	            ProjCoordinate convertedCoord = CoordinateConverter.convert79(epsg5179Longitude, epsg5179Latitude);

	            // Set converted coordinates
	            point.setLongitude(convertedCoord.x);
	            point.setLatitude(convertedCoord.y);

	            point.setYear(year);
	            point.setGname(gname);

	            pointMapper.dataInsert(point);
	        }
	    } catch (SQLException e) {
	        log.error("Error saving data to database: " + e.getMessage(), e);
	    }
	}
	private Map<String, String> extractYearAndGname(String accPoint) {
	    Map<String, String> result = new HashMap<>();

	    // Extract year (assuming year is a 4-digit number followed by "년도")
	    String year = accPoint.replaceAll(".*(\\d{4})년도.*", "$1");

	    // Extract gname (assuming gname is between "서울특별시" and "내에서")
	    String gname = accPoint.replaceAll(".*서울특별시\\s*(.*?)\\s*내에서.*", "$1");

	    result.put("year", year);
	    result.put("gname", gname);

	    return result;
	}
	
	public List<Point> fullTableScan() throws Exception{
		log.debug("┌────────────────────────────────────────┐");
		log.debug("│ PointServiceImpl() : fullTableScan     │");
		log.debug("└────────────────────────────────────────┘");
		List<Point> listPoint = pointMapper.fullTableScan();
		
		log.debug("┌ list ┐");
		for(Point point : listPoint) {
			log.debug("│ point : " + point);
		}
		log.debug("└");
		
		return listPoint;
	}

	@Override
	public List<Point> detailInfoLoad(Point inVO) throws Exception {
		log.debug("┌────────────────────────────────────────┐");
		log.debug("│ PointServiceImpl() : detailInfoLoad    │");
		log.debug("└────────────────────────────────────────┘");
		List<Point> pointList = pointMapper.detailInfoLoad(inVO);
		log.debug("1. pointVO02 : " + inVO);
		log.debug("┌ list ┐");
		for(Point point : pointList) {
			log.debug("│ Point : " + point);
		}
		log.debug("└─────────────────────────────────────────────");
		
		return pointList;
	}

	@Override
	public List<String> guLoad(String year) throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ PointServiceImpl() : guLoad  │");
		log.debug("└──────────────────────────────┘");
		List<String> guList = pointMapper.guLoad(year);
		log.debug("1. year : " + year);
		log.debug("┌ list ┐");
		for(String gu : guList) {
			log.debug("│ gu : " + gu);
		}
		log.debug("└─────────────────────────────────────────────");
		
		return guList;
	}

	@Override
	public List<Point> databyYearAndGu(int year, List<String> guList) {
		List<Point> result = pointMapper.databyYearAndGu(year, guList);
		return result;
	}

}