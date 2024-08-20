package com.acorn.doma.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Accident;


public interface AccInfoService extends WorkDiv<Accident>{
	
//	String fetchDataFromApi() throws IOException;
//	
//    List<Accident> parseXmlData(String xmlData);
//    
//    void insertAccidentData();
    
    List<Accident> fullTableScan() throws SQLException;
    List<Accident> A01Retrieve() throws SQLException;
	List<Accident> A02Retrieve() throws SQLException;
	List<Accident> A03Retrieve() throws SQLException;
	List<Accident> A04Retrieve() throws SQLException;
	List<Accident> A05Retrieve() throws SQLException;
	List<Accident> A06Retrieve() throws SQLException;
	List<Accident> A07Retrieve() throws SQLException;
	List<Accident> A08Retrieve() throws SQLException;
	List<Accident> A09Retrieve() throws SQLException;
	List<Accident> A10Retrieve() throws SQLException;
	List<Accident> A11Retrieve() throws SQLException;
	List<Accident> A12Retrieve() throws SQLException;	
    
}
