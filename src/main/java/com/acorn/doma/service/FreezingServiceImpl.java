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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Freezing;
import com.acorn.doma.mapper.AccMapper;
import com.acorn.doma.mapper.FreezingMapper;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;

@Service
public class FreezingServiceImpl implements FreezingService, PLog {
	private final String serviceKey;
	private final FreezingMapper freezingMapper;
	private static final String[] YEARS = { "2017", "2018", "2019", "2020", "2021", "2022" };
	private static final String[] DISTRICTS = { "110", "140", "170", "200", "215", "230", "260", "290", "305", "320",
			"350", "380", "410", "440", "470", "500", "530", "545", "560", "590", "620", "650", "680", "710", "740" };

	public FreezingServiceImpl(FreezingMapper freezingMapper, @Qualifier("freezingServiceKey") String serviceKey) {
		this.serviceKey = serviceKey;
		this.freezingMapper = freezingMapper;
	}

	@Override
	public String fetchDataFromApi(String year, String guGunCode) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://apis.data.go.kr/B552061/frequentzoneFreezing/getRestFrequentzoneFreezing");
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey);
		urlBuilder.append("&" + URLEncoder.encode("searchYearCd", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("siDo", "UTF-8") + "=" + URLEncoder.encode("11", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("guGun", "UTF-8") + "=" + URLEncoder.encode(guGunCode, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("5000", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
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
		String response = sb.toString();
		System.out.println("API Response: " + response); // Log the response
		return sb.toString();
	}

	@Override
	public JsonArray parseJsonData(String jsonData) {
		JsonReader reader = new JsonReader(new StringReader(jsonData));
		reader.setLenient(true); // Lenient 모드 활성화
		JsonElement jsonElement = JsonParser.parseReader(reader); // JSON 문자열을 JsonElement로 파싱합니다.
		JsonObject jsonObject = jsonElement.getAsJsonObject();

		if (jsonObject.has("resultCode") && "00".equals(jsonObject.get("resultCode").getAsString())) {
			JsonObject itemsObject = jsonObject.getAsJsonObject("items");
			return itemsObject.has("item") ? itemsObject.getAsJsonArray("item") : new JsonArray();
		} else {
			System.err.println("Error: " + jsonObject.get("resultMsg").getAsString());
			return new JsonArray(); // 빈 JsonArray 반환
		}
	}

	@Override
	public String getJsonElementAsString(JsonObject jsonObject, String key) {
		return jsonObject.has(key) && !jsonObject.get(key).isJsonNull() ? jsonObject.get(key).getAsString() : null;
	}

	@Override
	public void insertFreezingData() throws IOException {
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
			for (JsonElement item : items) {
				JsonObject data = item.getAsJsonObject();

				Freezing freezing = new Freezing();
				freezing.setFid(getJsonElementAsString(data, "afos_fid"));
				freezing.setSidoCode(getJsonElementAsString(data, "bjd_cd"));
				freezing.setYear(getJsonElementAsString(data, "afos_id") != null
						&& getJsonElementAsString(data, "afos_id").length() >= 4
								? getJsonElementAsString(data, "afos_id").substring(0, 4)
								: null);
				freezing.setAccident(Integer.parseInt(getJsonElementAsString(data, "occrrnc_cnt")));
				freezing.setCasualties(Integer.parseInt(getJsonElementAsString(data, "caslt_cnt")));
				freezing.setDead(Integer.parseInt(getJsonElementAsString(data, "dth_dnv_cnt")));
				freezing.setSeriously(Integer.parseInt(getJsonElementAsString(data, "se_dnv_cnt")));
				freezing.setOrdinary(Integer.parseInt(getJsonElementAsString(data, "sl_dnv_cnt")));
				freezing.setReport(Integer.parseInt(getJsonElementAsString(data, "wnd_dnv_cnt")));
				freezing.setLongitude(Double.parseDouble(getJsonElementAsString(data, "lo_crd")));
				freezing.setLatitude(Double.parseDouble(getJsonElementAsString(data, "la_crd")));
				freezing.setPolygon(getJsonElementAsString(data, "geom_json"));
				freezing.setAccPoint(getJsonElementAsString(data, "spot_nm"));

				freezingMapper.dataInsert(freezing);
			}
		} catch (SQLException e) {
			log.error("Error saving data to database: " + e.getMessage(), e);
		}
	}

	@Override
	public List<Map<String, Object>> selectFreezingData(List<Integer> years) throws IOException, SQLException {
		List<Map<String, Object>> result = freezingMapper.selectFreezingData(years);
        return result;
	}
}