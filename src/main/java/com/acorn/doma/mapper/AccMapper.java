package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Accident;

@Mapper
public interface AccMapper extends WorkDiv<Accident>{
	
	int dataInsert(Accident inVO) throws SQLException;
	
	int doDeleteAll() throws SQLException;
	
	int countAll() throws SQLException;
	
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
