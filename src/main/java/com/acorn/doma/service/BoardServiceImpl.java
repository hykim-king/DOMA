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
	
	public BoardServiceImpl() {}
	
	@Override
	public int doDelete(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return this.boardMapper.doDelete(inVO);
	}

	@Override
	public List<Board> doRetrieve(DTO search) throws SQLException {
		log.debug("1. param :"+search);
		return this.boardMapper.doRetrieve(search);
	}

	@Override
	public int doUpdate(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return boardMapper.doUpdate(inVO);
	}

	@Override
	public int doSave(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return boardMapper.doSave(inVO);
	}
    
	
	//조회 count증가
	@Override
	public Board doSelectOne(Board inVO) throws SQLException {
		//단건 조회
		log.debug("1. param :"+inVO);
		Board outVO = boardMapper.doSelectOne(inVO);
		log.debug("2. outVO :"+outVO);
		
		int flag = 0;
		//조회 count증가
		if(null != outVO) {
			flag = boardMapper.readCntUpdate(inVO);
			log.debug("3. 조회 count증가 :"+flag);
			
			if(1==flag) {
				outVO.setViews(outVO.getViews()+1);
			}
		}
		
		
		return outVO;
	}
	/*
	 * @Override public List<Board> mpSelect(Board inVO) throws SQLException {
	 * log.debug("1. param :"+inVO); return this.boardMapper.mpSelect(inVO); }
	 */
 

	@Override
	public List<Board> mpSelect(String userId) throws SQLException {
		// TODO Auto-generated method stub
		return boardMapper.mpSelect(userId);
		
	}

	@Override
	public int mpBoardUp(Board inVO) throws Exception {
		log.debug("1. param :"+inVO);
		return boardMapper.doUpdate(inVO);
	}

	@Override
	public Board mpBoardSelectOne(Board board) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ mpBoardSelectOne() : login      │");
		log.debug("└───────────────────────────┘");
		
		log.debug("┌ 1. param : " + board);
		
		Board outVO = boardMapper.mpBoardSelectOne(board);
		log.debug("└ 2. outVO : " + outVO);
		
		return outVO;
	} 
	 

 
	 

 
		 

}
