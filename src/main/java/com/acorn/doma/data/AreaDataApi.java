package com.acorn.doma.data;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.IOException;
public class AreaDataApi {
	private static String fetchDataFromApi() throws IOException {
	        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/frequentzoneLg/getRestFrequentzoneLg"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=u2Ynztum9D6SLnGMa307uaZWiGslePrz8ir8Z4R99wk7Ab3Zl6itMwNf1P6xRwUpr3gC%2BgjruGIz7qpIMirUng%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("searchYearCd","UTF-8") + "=" + URLEncoder.encode("2017", "UTF-8")); /*검색을 원하는 연도*/
	        urlBuilder.append("&" + URLEncoder.encode("siDo","UTF-8") + "=" + URLEncoder.encode("11", "UTF-8")); /*법정동 시도 코드*/
	        urlBuilder.append("&" + URLEncoder.encode("guGun","UTF-8") + "=" + URLEncoder.encode("200", "UTF-8")); /*법정동 시군구 코드*/
	        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*결과형식(xml/json)*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*검색건수*/
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
	        System.out.println(sb.toString());
	        String jsonData = sb.toString();
	        return jsonData;
	    }
		private static JsonArray parseJsonData(String jsonData) {
			// JSON 데이터 파싱하여 필요한 정보 추출하는 코드
	        JsonElement jsonElement = JsonParser.parseString(jsonData); // JSON 문자열을 JsonElement로 파싱합니다.
	        JsonObject jsonObject = jsonElement.getAsJsonObject();

	        // API 응답의 구조에 맞게 데이터 파싱
	        JsonArray items = jsonObject.has("items") && jsonObject.getAsJsonObject("items").has("item")
	                ? jsonObject.getAsJsonObject("items").getAsJsonArray("item")
	                : new JsonArray(); // 빈 JsonArray 반환

	        return items;
	    }
		public static void main(String[] args) throws IOException {
			//API로부터 데이터 가져오기
			String jsonData = fetchDataFromApi();
			
			//JSON 데이터 파싱하여 필요한 정보 추출
	        JsonArray items = parseJsonData(jsonData);
	        
	        
	        System.out.println(items);
	    }
		
		
}
