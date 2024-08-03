package com.acorn.doma.service;

import java.io.IOException;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public interface FreezingService {
	String fetchDataFromApi(String year, String guGunCode) throws IOException;
	JsonArray parseJsonData(String jsonData);
	String getJsonElementAsString(JsonObject jsonObject, String key);
}
