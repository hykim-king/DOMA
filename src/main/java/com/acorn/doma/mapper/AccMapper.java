package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Accident;

public interface AccMapper extends WorkDiv<Accident>{
	int dataInsert(Accident inVO) throws SQLException;
	int doDeleteAll() throws SQLException;
	int countAll() throws SQLException;
	List<Accident> fullTableScan() throws SQLException;
	
}
