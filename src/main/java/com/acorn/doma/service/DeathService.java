package com.acorn.doma.service;

import java.io.IOException;

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
	
}
