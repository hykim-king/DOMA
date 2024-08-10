package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.User;

public interface BoardService extends WorkDiv<Board> {
     
	List<Board> mpSelect(String userId) throws SQLException;
	
	public int mpBoardUp(Board inVO) throws SQLException; 
	
	public Board mpBoardSelectOne(Board inVO) throws SQLException, NullPointerException; 
	
}
