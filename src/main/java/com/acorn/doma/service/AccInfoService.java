package com.acorn.doma.service;

import java.io.IOException;
import java.util.List;

import com.acorn.doma.domain.Accident;


public interface AccInfoService {
	String fetchDataFromApi() throws IOException;
    List<Accident> parseXmlData(String xmlData);
    void insertAccidentData();
}
