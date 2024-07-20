package com.pcwk.ehr.mymapper.dao;

import java.sql.SQLException;

import com.pcwk.ehr.mymapper.domain.MyMapper;

public interface MyMapperDao {
	
	MyMapper doSelectOne(MyMapper inVO) throws SQLException;
}