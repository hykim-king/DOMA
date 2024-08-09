package com.acorn.doma.service;

import java.io.IOException;
import java.util.List;

import com.acorn.doma.domain.Point;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public interface PointService {
	
	String fetchDataFromApi(String year, String guGunCode) throws IOException;
	
	JsonArray parseJsonData(String jsonData);
	
	String getJsonElementAsString(JsonObject jsonObject, String key);
	
	void insertPointData() throws IOException;
	 
	void saveDataToDatabase(JsonArray items);
	
	List<Point> fullTableScan() throws Exception;
	
	List<Point> detailInfoLoad(Point inVO) throws Exception;
	
	List<String> guLoad(String year) throws Exception;
}
