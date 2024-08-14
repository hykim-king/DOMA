package com.acorn.doma.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.acorn.doma.domain.Death;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public interface DeathService {
	String mapOccrrncDayCd(String code);
	String getJsonElementAsString(JsonObject jsonObject, String key);
	String mapDghtCd(String code);
	String fetchDataFromApi(String year, String guGunCode) throws IOException;
	JsonArray parseJsonData(String jsonData);
	void insertDeathData() throws IOException;
	void saveDataToDatabase(JsonArray items);
	
	

	/* 시각화페이지 */
	public List<Map<String, Object>> MonthDead(Death inVO) throws SQLException;
	
	
	
	
	
}
