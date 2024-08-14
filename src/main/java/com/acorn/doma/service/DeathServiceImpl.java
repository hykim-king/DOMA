package com.acorn.doma.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Death;
import com.acorn.doma.mapper.DeathMapper;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;
@Service
public class DeathServiceImpl implements DeathService, PLog{
	private final String serviceKey;
	private final DeathMapper deathMapper;
	private static final String[] YEARS = {"2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023"};
    private static final String[] DISTRICTS = {
    		 "1116", "1117", "1124", "1111", "1115", 
             "1123", "1112", "1125", "1122", "1107", 
             "1105", "1114", "1110", "1109", "1119", 
             "1104", "1106", "1118", "1120", "1113", 
             "1103", "1108", "1101", "1102", "1121"
    };
	public DeathServiceImpl(DeathMapper deathMapper,@Qualifier("pointdeathServiceKey") String serviceKey) {
		this.serviceKey = serviceKey;
		this.deathMapper = deathMapper;
		}


	@Override
	public String fetchDataFromApi(String year, String guGunCode) throws IOException {
		// API URL 설정
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/AccidentDeath/getRestTrafficAccidentDeath");
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "="+serviceKey);
        urlBuilder.append("&" + URLEncoder.encode("searchYear", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("siDo", "UTF-8") + "=" + URLEncoder.encode("1100", "UTF-8")); //seoul 1100
        urlBuilder.append("&" + URLEncoder.encode("guGun", "UTF-8") + "=" + URLEncoder.encode(guGunCode, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("5000", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
        
        // API 호출
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());

        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
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
        System.out.println(jsonData);
        return jsonData;
	}

	@Override
	public JsonArray parseJsonData(String jsonData) {
		 JsonParser parser = new JsonParser();
        JsonReader reader = new JsonReader(new StringReader(jsonData));
        reader.setLenient(true); // lenient 모드 활성화
        JsonElement jsonElement = parser.parse(reader); // JSON 문자열을 JsonElement로 파싱합니다.
        JsonObject jsonObject = jsonElement.getAsJsonObject();

        // JSON 응답 구조에 맞게 데이터 추출
        return jsonObject.has("items") && jsonObject.getAsJsonObject("items").has("item")
                ? jsonObject.getAsJsonObject("items").getAsJsonArray("item")
                : new JsonArray();
	}

	@Override
	public void insertDeathData() throws IOException {
		for (String year : YEARS) {
            for (String guGunCode : DISTRICTS) {           
                String jsonData = fetchDataFromApi(year, guGunCode);
                JsonArray items = parseJsonData(jsonData);
                saveDataToDatabase(items);
            }
        }
	
	}

	@Override
	public void saveDataToDatabase(JsonArray items) {
		try{
			for(JsonElement item : items) {
			JsonObject data = item.getAsJsonObject();
			Death death = new Death();
			death.setGcode(getJsonElementAsString(data, "occrrnc_lc_sgg_cd"));
			death.setAccMajor(getJsonElementAsString(data, "acc_ty_lclas_cd"));
			death.setAccMedium(getJsonElementAsString(data, "acc_ty_mlsfc_cd"));
			death.setYear(getJsonElementAsString(data, "acc_year"));
			death.setOccrDate(getJsonElementAsString(data, "occrrnc_dt"));
			death.setDayNight(mapDghtCd(getJsonElementAsString(data, "dght_cd")));
			death.setDayWeek(mapOccrrncDayCd(getJsonElementAsString(data, "occrrnc_day_cd")));
			death.setDead(Integer.parseInt(getJsonElementAsString(data, "dth_dnv_cnt")));
			death.setCasualties(Integer.parseInt(getJsonElementAsString(data, "injpsn_cnt")));
			death.setSeriously(Integer.parseInt(getJsonElementAsString(data, "se_dnv_cnt")));
			death.setOrdinary(Integer.parseInt(getJsonElementAsString(data, "sl_dnv_cnt")));
			death.setReport(Integer.parseInt(getJsonElementAsString(data, "wnd_dnv_cnt")));
			death.setLongitude(Double.parseDouble(getJsonElementAsString(data, "lo_crd")));
			death.setLatitude(Double.parseDouble(getJsonElementAsString(data, "la_crd")));
			deathMapper.dataInsert(death);
			}			
		}catch(SQLException e) {
            log.error("Error saving data to database: " + e.getMessage(), e);
		}
		
	}
	@Override
	public String getJsonElementAsString(JsonObject jsonObject, String key) {
		return jsonObject.has(key) && !jsonObject.get(key).isJsonNull() ? jsonObject.get(key).getAsString() : null;
	}
	@Override
	public String mapOccrrncDayCd(String code) {
		switch (code) {
        case "1": return "일";
        case "2": return "월";
        case "3": return "화";
        case "4": return "수";
        case "5": return "목";
        case "6": return "금";
        case "7": return "토";
        default: return "알수없음";
    }
	}
	@Override
	public String mapDghtCd(String code) {
		switch (code) {
        case "1": return "주간";
        case "2": return "야간";
        default: return "알수없음";
    }
	}

	/* 시각화페이지 */
	@Override
	public List<Map<String, Object>> MonthDead(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MonthDead(inVO); 
		return list;
		 
	}
 
	@Override
	public List<Map<String, Object>> MonthCasualties(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MonthCasualties(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> MonthSeriously(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MonthSeriously(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> WeekDead(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.WeekDead(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> WeekCasualties(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.WeekCasualties(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> WeekSeriously(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.WeekSeriously(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> HourDead(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.HourDead(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> HourCasualties(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.HourCasualties(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> HourSeriously(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.HourSeriously(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> NightDead(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.NightDead(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> NightCasualties(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.NightCasualties(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> NightSeriously(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.NightSeriously(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> MajorDead(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MajorDead(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> MajorCasualties(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MajorCasualties(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> MajorSeriously(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MajorSeriously(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> MediumDead(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MediumDead(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> MediumCasualties(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MediumCasualties(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> MediumSeriously(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.MediumSeriously(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> GnameDead(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.GnameDead(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> GnameCasualties(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.GnameCasualties(inVO); 
		return list;
	}


	@Override
	public List<Map<String, Object>> GnameSeriously(Death inVO) throws SQLException {
		List<Map<String, Object>> list = deathMapper.GnameSeriously(inVO); 
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
