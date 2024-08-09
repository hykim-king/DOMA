package com.acorn.doma.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.acorn.doma.domain.Freezing;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public interface FreezingService {
	String fetchDataFromApi(String year, String guGunCode) throws IOException;
	JsonArray parseJsonData(String jsonData);
	String getJsonElementAsString(JsonObject jsonObject, String key);
	 void insertFreezingData() throws IOException;
	 void saveDataToDatabase(JsonArray items);
	 List<Freezing> selectAllData() throws SQLException;
	 Freezing selectFreezingDataById(String fid) throws SQLException;
}
