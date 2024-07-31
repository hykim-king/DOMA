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

public class FreezingDataApi {

    public static String fetchDataFromApi(String year, String guGunCode) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/frequentzoneFreezing/getRestFrequentzoneFreezing");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=%2Be0w%2FsKfgHqqLeOOGupdVrnGmCfE81u0jINpS51GPDFeppol8RaYe1id0%2BbpEO%2BSq%2BYzOmi%2F%2By77yKtIgPSlqQ%3D%3D");
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

    private static JsonArray parseJsonData(String jsonData) {
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

    public static void main(String[] args) throws IOException {
        String[] years = {"2017", "2018", "2019", "2020", "2021", "2022"};
        String[] districts = {
            "110", "140", "170", "200", "215", "230", "260", "290", "305", "320",
            "350", "380", "410", "440", "470", "500", "530", "545", "560", "590",
            "620", "650", "680", "710", "740"
        };

        for (String year : years) {
            for (String guGunCode : districts) {
                System.out.println("Fetching data for year: " + year + ", district code: " + guGunCode);
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
            String sql = "INSERT INTO D_FREEZING (freezing_id, sido_code, year, accident, casualties, dead, seriously, ordinary, report, longitude, latitude, polygon, acc_point) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (JsonElement item : items) {
                    JsonObject data = item.getAsJsonObject();

                    // Extract year from afos_id
                    String afosId = getJsonElementAsString(data, "afos_id");
                    String year = afosId != null && afosId.length() >= 4 ? afosId.substring(0, 4) : null;

                    stmt.setString(1, getJsonElementAsString(data, "afos_fid"));
                    stmt.setString(2, getJsonElementAsString(data, "bjd_cd"));
                    stmt.setString(3, year);
                    stmt.setString(4, getJsonElementAsString(data, "occrrnc_cnt"));
                    stmt.setString(5, getJsonElementAsString(data, "caslt_cnt"));
                    stmt.setString(6, getJsonElementAsString(data, "dth_dnv_cnt"));
                    stmt.setString(7, getJsonElementAsString(data, "se_dnv_cnt"));
                    stmt.setString(8, getJsonElementAsString(data, "sl_dnv_cnt"));
                    stmt.setString(9, getJsonElementAsString(data, "wnd_dnv_cnt"));
                    stmt.setString(10, getJsonElementAsString(data, "lo_crd"));
                    stmt.setString(11, getJsonElementAsString(data, "la_crd"));
                    stmt.setString(12, getJsonElementAsString(data, "geom_json"));
                    stmt.setString(13, getJsonElementAsString(data, "spot_nm"));

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
}
