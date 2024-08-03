package com.acorn.doma.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.mapper.AccMapper;
import com.acorn.doma.mapper.FreezingMapper;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;
@Service
public class FreezingServiceImpl implements FreezingService,PLog{
	public FreezingServiceImpl() {	
	}
	@Override
	public String fetchDataFromApi(String year, String guGunCode) throws IOException {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/frequentzoneFreezing/getRestFrequentzoneFreezing");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=serviceKey");
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

}
