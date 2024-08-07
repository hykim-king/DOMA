package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.User;

public interface BoardService extends WorkDiv<Board> {
  
	List<Board> mpSelect(Board inVO) throws SQLException;
}
