package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.WorkDiv; 
import com.acorn.doma.domain.Comments;

public interface CommentsService extends WorkDiv<Comments>{

	List<Comments> mpCommentSelect(Comments inVO) throws SQLException;
	
	List<Comments> mpCommentSelect(String userId) throws SQLException;
	
	public int mpCommentUp(Comments inVO) throws Exception; 
	
	public Comments mpCommentSelectOne(Comments inVO) throws Exception; 
	List<Comments> commentsList(int seq) throws SQLException;
}
