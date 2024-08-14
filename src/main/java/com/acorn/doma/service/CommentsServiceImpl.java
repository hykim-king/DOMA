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
		log.debug("1. param :"+search);
		return this.commentMapper.doRetrieve(search);
	}

	@Override
	public int doUpdate(Comments inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return commentMapper.doUpdate(inVO);
	}

	@Override
	public int doDelete(Comments inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return this.commentMapper.doDelete(inVO);
	}

	@Override
	public int doSave(Comments inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return commentMapper.doSave(inVO);
	}

	@Override
	public Comments doSelectOne(Comments inVO) throws SQLException, NullPointerException {
		Comments outVO = commentMapper.doSelectOne(inVO);
		
		return outVO;
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

	@Override
	public List<Comments> commentsList(int seq) throws SQLException {
		List<Comments> outVO = 	commentMapper.commentsList(seq);
		return outVO;
	}

	@Override
	public int commentsDelete(Comments inVO) throws SQLException {
		int flag = commentMapper.commentsDelete(inVO);
		return flag;
	}

	 

}
