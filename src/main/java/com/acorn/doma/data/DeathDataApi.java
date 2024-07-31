package com.acorn.doma.data;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;

public class DeathDataApi {
    private static String fetchDataFromApi(String year, String guGunCode) throws IOException {
        // API URL 설정
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/AccidentDeath/getRestTrafficAccidentDeath");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=u2Ynztum9D6SLnGMa307uaZWiGslePrz8ir8Z4R99wk7Ab3Zl6itMwNf1P6xRwUpr3gC%2BgjruGIz7qpIMirUng%3D%3D");
        urlBuilder.append("&" + URLEncoder.encode("searchYearCd", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("siDo", "UTF-8") + "=" + URLEncoder.encode("1100", "UTF-8"));
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
        System.out.println("Fetched JSON Data: " + jsonData); // JSON 데이터 로그 출력
        return jsonData;
    }

    private static JsonArray parseJsonData(String jsonData) {
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

    public static void main(String[] args) throws IOException {
        String[] years = {"2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023"};
        String[] districts = {
            "1116", "1117", "1124", "1111", "1115", 
            "1123", "1112", "1125", "1122", "1107", 
            "1105", "1114", "1110", "1109", "1119", 
            "1104", "1106", "1118", "1120", "1113", 
            "1103", "1108", "1101", "1102", "1121"
        };

        for (String year : years) {
            for (String guGunCode : districts) {           
                String jsonData = fetchDataFromApi(year, guGunCode);
                JsonArray items = parseJsonData(jsonData);
                saveDataToDatabase(items);
            }
        }
    }

    private static void saveDataToDatabase(JsonArray items) {
        String url = "jdbc:oracle:thin:@192.168.0.50:1521:xe";
        String user = "scott";
        String password = "pcwk";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String sql = "INSERT INTO D_death (gcode, acc_major, acc_medium, year, occr_date, day_night, day_week, dead, casualties, seriously, ordinary, report, longitude, latitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (JsonElement item : items) {
                    JsonObject data = item.getAsJsonObject();
                    stmt.setString(1, getJsonElementAsString(data, "occrrnc_lc_sgg_cd"));
                    stmt.setString(2, getJsonElementAsString(data, "acc_ty_lclas_cd"));
                    stmt.setString(3, getJsonElementAsString(data, "acc_ty_mlsfc_cd"));
                    stmt.setString(4, getJsonElementAsString(data, "acc_year"));
                    stmt.setString(5, getJsonElementAsString(data, "occrrnc_dt"));
                    stmt.setString(6, mapDghtCd(getJsonElementAsString(data, "dght_cd")));
                    stmt.setString(7, mapOccrrncDayCd(getJsonElementAsString(data, "occrrnc_day_cd")));
                    stmt.setString(8, getJsonElementAsString(data, "dth_dnv_cnt"));
                    stmt.setString(9, getJsonElementAsString(data, "injpsn_cnt"));
                    stmt.setString(10, getJsonElementAsString(data, "se_dnv_cnt"));
                    stmt.setString(11, getJsonElementAsString(data, "sl_dnv_cnt"));
                    stmt.setString(12, getJsonElementAsString(data, "wnd_dnv_cnt"));
                    stmt.setString(13, getJsonElementAsString(data, "lo_crd"));
                    stmt.setString(14, getJsonElementAsString(data, "la_crd"));
                    stmt.executeUpdate();
                }
            }

        } catch (SQLException e) {
            System.err.println("Error saving data to database: " + e.getMessage());
        }
    }

    private static String getJsonElementAsString(JsonObject jsonObject, String key) {
        return jsonObject.has(key) && !jsonObject.get(key).isJsonNull() ? jsonObject.get(key).getAsString() : null;
    }

    private static String mapOccrrncDayCd(String code) {
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

    private static String mapDghtCd(String code) {
        switch (code) {
            case "1": return "주간";
            case "2": return "야간";
            default: return "알수없음";
        }
    }
}