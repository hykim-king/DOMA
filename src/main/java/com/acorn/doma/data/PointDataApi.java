package com.acorn.doma.data;

import java.io.InputStreamReader;
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

import java.io.BufferedReader;
import java.io.IOException;

public class PointDataApi {

    private static String fetchDataFromApi(String year, String guGunCode) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/accidentRiskArea/getRestAccidentRiskArea"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=%2Be0w%2FsKfgHqqLeOOGupdVrnGmCfE81u0jINpS51GPDFeppol8RaYe1id0%2BbpEO%2BSq%2BYzOmi%2F%2By77yKtIgPSlqQ%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("searchYearCd", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("siDo", "UTF-8") + "=" + URLEncoder.encode("11", "UTF-8")); /*법정동 시도 코드*/
        urlBuilder.append("&" + URLEncoder.encode("guGun", "UTF-8") + "=" + URLEncoder.encode(guGunCode, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*결과형식(xml/json)*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("5000", "UTF-8")); /*검색건수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
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
        System.out.println(sb.toString());
        return sb.toString(); // API로부터 가져온 JSON 데이터 반환
    }

    private static JsonArray parseJsonData(String jsonData) {
        JsonElement jsonElement = JsonParser.parseString(jsonData); // JSON 문자열을 JsonElement로 파싱합니다.
        JsonObject jsonObject = jsonElement.getAsJsonObject();

        // JSON 응답 구조에 맞게 데이터 추출
        JsonArray items = jsonObject.has("items") && jsonObject.getAsJsonObject("items").has("item")
                ? jsonObject.getAsJsonObject("items").getAsJsonArray("item")
                : new JsonArray(); // 빈 JsonArray 반환

        return items;
    }

    public static void main(String[] args) throws IOException {
        String[] years = {"2017", "2018", "2019", "2020", "2021", "2022"};
        String[] districts = {
            "110", "140", "170", "200", "215", "230", "260", "290", "305", "320",
            "350", "380", "410", "440", "470", "500", "530", "545", "560", "590",
            "620", "650", "680", "710", "740"
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
            String sql = "INSERT INTO D_POINT (point_id,acc_point, accident, dead, seriously, ordinary, report, point_type, longitude, latitude, polygon) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (JsonElement item : items) {
                    JsonObject data = item.getAsJsonObject();
                    stmt.setString(1, getJsonElementAsString(data, "acc_risk_area_id")); // acc_point
                    stmt.setString(2, getJsonElementAsString(data, "acc_risk_area_nm")); // acc_point
                    stmt.setString(3, getJsonElementAsString(data, "tot_acc_cnt")); // accident
                    stmt.setString(4, getJsonElementAsString(data, "tot_dth_dnv_cnt")); // dead
                    stmt.setString(5, getJsonElementAsString(data, "tot_se_dnv_cnt")); // seriously
                    stmt.setString(6, getJsonElementAsString(data, "tot_sl_dnv_cnt")); // ordinary
                    stmt.setString(7, getJsonElementAsString(data, "tot_wnd_dnv_cnt")); // report
                    stmt.setString(8, getJsonElementAsString(data, "cause_anals_ty_nm")); // point_type
                    stmt.setString(9, getJsonElementAsString(data, "cntpnt_utmk_x_crd")); // longitude
                    stmt.setString(10, getJsonElementAsString(data, "cntpnt_utmk_y_crd")); // latitude
                    stmt.setString(11, getJsonElementAsString(data, "geom_wkt")); // polygon

                    stmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error saving data to database: " + e.getMessage());
        }
    }

    private static String getJsonElementAsString(JsonObject jsonObject, String key) {
        JsonElement element = jsonObject.get(key);
        if (element == null || element.isJsonNull()) {
            return null;
        }
        // 배열일 경우, 적절한 단일 값을 추출하거나 에러 처리
        if (element.isJsonArray()) {
            // 예를 들어 첫 번째 요소만 필요할 경우
            JsonArray array = element.getAsJsonArray();
            return array.size() > 0 ? array.get(0).getAsString() : null;
        }
        return element.getAsString();
    }
}
