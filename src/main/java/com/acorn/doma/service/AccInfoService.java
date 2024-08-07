package com.acorn.doma.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Accident;


public interface AccInfoService extends WorkDiv<Accident>{
	
	String fetchDataFromApi() throws IOException;
	
    List<Accident> parseXmlData(String xmlData);
    
    void insertAccidentData();
    
    List<Accident> fullTableScan() throws SQLException;
    
    
}
