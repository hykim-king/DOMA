package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Comments;

@Service
public class CommentsServiceImpl implements CommentsService, PLog{

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

}
