package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Board;
import com.acorn.doma.mapper.BoardMapper;

@Service("boardServiceImpl")
public class BoardServiceImpl implements BoardService, PLog {

	@Autowired
	BoardMapper boardMapper;
	
	public BoardServiceImpl() { }

	@Override
	public List<Board> doRetrieve(DTO search) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doUpdate(Board inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(Board inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doSave(Board inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Board doSelectOne(Board inVO) throws SQLException, NullPointerException {
		// TODO Auto-generated method stub
		return null;
	}

}
