package com.acorn.doma.mymapper.dao;

import java.sql.SQLException;

import com.acorn.doma.mymapper.domain.MyMapper;

public interface MyMapperDao {
	
	MyMapper doSelectOne(MyMapper inVO) throws SQLException;
}