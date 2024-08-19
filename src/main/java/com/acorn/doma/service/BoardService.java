package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Board;

public interface BoardService extends WorkDiv<Board> {
	
	int anUpdate(Board inVO) throws SQLException;
	
	Board anMoveUpdate(Board inVO) throws SQLException, NullPointerException;
	
	Board moveUpdate(Board inVO) throws SQLException, NullPointerException;
	
	Board anSelectOne(Board inVO) throws SQLException, NullPointerException;
	
	int anSave(Board inVO) throws SQLException;
     
	List<Board> doRetrieveAn(DTO search) throws SQLException;
	
	List<Board> mpSelect(String userId) throws SQLException;
	
	public int mpBoardUp(Board inVO) throws SQLException; 
	
	public Board mpBoardSelectOne(Board inVO) throws SQLException, NullPointerException; 
	
	
	/* 안전정보페이지 */
	public int save(Board inVO) throws SQLException;
	
	public List<Board> retrieve(Search search) throws SQLException;
	
	public Board selectOne(Board inVO) throws SQLException;
	
	int update(Board inVO) throws SQLException;
	
}
