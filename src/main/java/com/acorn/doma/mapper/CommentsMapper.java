package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.WorkDiv; 
import com.acorn.doma.domain.Comments;

@Mapper
public interface CommentsMapper extends WorkDiv<Comments> {

	int commentsDelete(Comments inVO) throws SQLException;
	
	/**
	 * 최신 sequence 조회
	 * @return
	 * @throws SQLException
	 */
	List<Comments> commentsList(int seq) throws SQLException;
	int getSequence() throws SQLException;
	
	/**
	 * 테스트용 데이터 전체 삭제
	 * @return
	 * @throws SQLException
	 */
	int deleteAll() throws SQLException;
	
	List<Comments> mpCommentSelect(Comments inVO) throws SQLException; 
	
	List<Comments> mpCommentSelect(String userId); 
	
	Comments mpCommentSelectOne(Comments inVO) throws SQLException;
	
	int mpCommentUp(Comments inVO) throws SQLException;
	
}
