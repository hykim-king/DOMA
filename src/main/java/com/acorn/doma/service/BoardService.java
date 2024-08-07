package com.acorn.doma.service;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.User;

public interface BoardService extends WorkDiv<Board> {

	public Board mpbSelectOne(Board board) throws Exception;
	
}
