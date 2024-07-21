package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.code.domain.Code;

@Mapper
public interface CodeMapper extends WorkDiv<Code> {
	/**
	 * 코드 목록 조회 with In
	 * 
	 * @param search
	 * @return
	 * @throws SQLException
	 */
	List<Code> doRetrieveIn(List search) throws SQLException;

}