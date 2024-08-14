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
	public List<Map<String, Object>> MonthCasualties(Death inVO) throws SQLException; 
	public List<Map<String, Object>> MonthSeriously(Death inVO) throws SQLException;
	
	public List<Map<String, Object>> WeekDead(Death inVO) throws SQLException; 
	public List<Map<String, Object>> WeekCasualties(Death inVO) throws SQLException; 
	public List<Map<String, Object>> WeekSeriously(Death inVO) throws SQLException; 
	
	public List<Map<String, Object>> HourDead(Death inVO) throws SQLException; 
	public List<Map<String, Object>> HourCasualties(Death inVO) throws SQLException; 
	public List<Map<String, Object>> HourSeriously(Death inVO) throws SQLException; 
	
	public List<Map<String, Object>> NightDead(Death inVO) throws SQLException; 
	public List<Map<String, Object>> NightCasualties(Death inVO) throws SQLException; 
	public List<Map<String, Object>> NightSeriously(Death inVO) throws SQLException; 
	
	public List<Map<String, Object>> MajorDead(Death inVO) throws SQLException; 
	public List<Map<String, Object>> MajorCasualties(Death inVO) throws SQLException; 
	public List<Map<String, Object>> MajorSeriously(Death inVO) throws SQLException; 
	
	public List<Map<String, Object>> MediumDead(Death inVO) throws SQLException; 
	public List<Map<String, Object>> MediumCasualties(Death inVO) throws SQLException; 
	public List<Map<String, Object>> MediumSeriously(Death inVO) throws SQLException; 
	 
	public List<Map<String, Object>> GnameDead(Death inVO) throws SQLException; 
	public List<Map<String, Object>> GnameCasualties(Death inVO) throws SQLException; 
	public List<Map<String, Object>> GnameSeriously(Death inVO) throws SQLException; 
	
	
}
