package com.pcwk.ehr.mymapper.dao;

import java.sql.SQLException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PLog;
import com.pcwk.ehr.mymapper.domain.MyMapper;

@Repository
public class MyMapperJdbc implements MyMapperDao, PLog {

	final String NAMESPACE = "com.pcwk.ehr.mymapper";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;// DB 연결

	public MyMapperJdbc() {

	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	@Override
	public MyMapper doSelectOne(MyMapper inVO) throws SQLException {
		MyMapper outVO = null;

		String statement = NAMESPACE + DOT + "doSelectOne";

		log.debug("1. param : " + inVO);
		log.debug("2. statement : " + statement);
		outVO = sqlSessionTemplate.selectOne(statement, inVO);
		log.debug("3. outVO : " + outVO);
		return outVO;
	}

}