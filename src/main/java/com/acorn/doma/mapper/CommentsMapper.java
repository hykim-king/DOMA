package com.acorn.doma.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Comments;

@Mapper
public interface CommentsMapper extends WorkDiv<Comments> {

	/**
	 * 최신 sequence 조회
	 * @return
	 * @throws SQLException
	 */
	int getSequence() throws SQLException;
	
	/**
	 * 테스트용 데이터 전체 삭제
	 * @return
	 * @throws SQLException
	 */
	int deleteAll() throws SQLException;
	
	
}
