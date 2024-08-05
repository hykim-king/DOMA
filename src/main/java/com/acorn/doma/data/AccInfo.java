package com.acorn.doma.data;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class AccInfo {

	public static void main(String[] args) throws IOException {
		/*
		 * StringBuilder urlBuilder = new
		 * StringBuilder("http://openapi.seoul.go.kr:8088"); URL urlBuilder.append("/" +
		 * URLEncoder.encode("5146697052736b6f3438696a4d6574","UTF-8") ); 인증키
		 * (sample사용시에는 호출시 제한됩니다.) urlBuilder.append("/" +
		 * URLEncoder.encode("xml","UTF-8") ); 요청파일타입 (xml,xmlf,xls,json)
		 * urlBuilder.append("/" + URLEncoder.encode("AccInfo","UTF-8")); 서비스명 (대소문자 구분
		 * 필수입니다.) urlBuilder.append("/" + URLEncoder.encode("1","UTF-8")); 요청시작위치
		 * (sample인증키 사용시 5이내 숫자) urlBuilder.append("/" +
		 * URLEncoder.encode("50","UTF-8")); 요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨) // 상위
		 * 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.
		 * 
		 * 
		 * URL url = new URL(urlBuilder.toString()); HttpURLConnection conn =
		 * (HttpURLConnection) url.openConnection(); conn.setRequestMethod("GET");
		 * conn.setRequestProperty("Content-type", "application/xml");
		 * System.out.println("Response code: " + conn.getResponseCode()); 연결 자체에 대한 확인이
		 * 필요하므로 추가합니다. BufferedReader rd;
		 * 
		 * // 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다. if(conn.getResponseCode() >= 200 &&
		 * conn.getResponseCode() <= 300) { rd = new BufferedReader(new
		 * InputStreamReader(conn.getInputStream())); } else { rd = new
		 * BufferedReader(new InputStreamReader(conn.getErrorStream())); } StringBuilder
		 * sb = new StringBuilder(); String line; while ((line = rd.readLine()) != null)
		 * { sb.append(line); } rd.close(); conn.disconnect(); String xmlData =
		 * sb.toString(); System.out.println(xmlData);
		 */
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/AccidentDeath/getRestTrafficAccidentDeath");
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=u2Ynztum9D6SLnGMa307uaZWiGslePrz8ir8Z4R99wk7Ab3Zl6itMwNf1P6xRwUpr3gC%2BgjruGIz7qpIMirUng%3D%3D");
        urlBuilder.append("&" + URLEncoder.encode("searchYear", "UTF-8") + "=" + URLEncoder.encode("2022", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("siDo", "UTF-8") + "=" + URLEncoder.encode("1100", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("guGun", "UTF-8") + "=" + URLEncoder.encode("1101", "UTF-8"));
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

	}

}
