package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Comments;
import com.acorn.doma.mapper.CommentsMapper;

@Service
public class CommentsServiceImpl implements CommentsService, PLog{
	
	@Autowired
	CommentsMapper commentMapper;

	@Override
	public List<Comments> doRetrieve(DTO search) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doUpdate(Comments inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(Comments inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doSave(Comments inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Comments doSelectOne(Comments inVO) throws SQLException, NullPointerException {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	//mypage comment
	@Override
	public List<Comments> mpCommentSelect(Comments inVO) throws SQLException {
		 log.debug("1. param :"+inVO); 
		 return this.commentMapper.mpCommentSelect(inVO); 
	}
	
	@Override
	public List<Comments> mpCommentSelect(String userId) throws SQLException {
		return commentMapper.mpCommentSelect(userId);
		 
	}

	@Override
	public int mpCommentUp(Comments inVO) throws Exception {
		log.debug("1. param :"+inVO);
		return commentMapper.doUpdate(inVO);
	}

	@Override
	public Comments mpCommentSelectOne(Comments inVO) throws Exception {
		log.debug("┌─┐");
		log.debug("│ mpCommentSelectOne()");
		log.debug("└─┘");
		
		log.debug("┌ 1. param : " + inVO);
		
		Comments outVO = commentMapper.mpCommentSelectOne(inVO);
		log.debug("└ 2. outVO : " + outVO);
		
		return outVO;
	}

	 

}
