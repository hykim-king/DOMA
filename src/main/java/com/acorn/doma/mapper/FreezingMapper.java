package com.acorn.doma.mapper;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Freezing;

@Mapper
public interface FreezingMapper extends WorkDiv<Freezing> {
	int dataInsert(Freezing inVO) throws SQLException;
	int doDeleteAll() throws SQLException;
	int countAll() throws SQLException;
	List<Map<String, Object>> selectFreezingData(@Param("years") List<Integer> years) throws IOException, SQLException;
	List<Map<String, Object>> selectAllFreezingData() throws SQLException;
    Freezing selectFreezingDataById(String fid) throws SQLException;
	
}
