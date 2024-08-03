package com.acorn.doma.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Freezing;

@Mapper
public interface FreezingMapper extends WorkDiv<Freezing> {
	int dataInsert(Freezing inVO) throws SQLException;
	int doDeleteAll() throws SQLException;

}
