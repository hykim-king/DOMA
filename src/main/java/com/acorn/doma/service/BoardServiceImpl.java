package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.User;
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
	
	@Override
	public Board viewsSelectOne(Board inVO, HttpSession session) throws SQLException {
	    // 단건 조회
	    log.debug("1. param :" + inVO);
	    Board outVO = boardMapper.doSelectOne(inVO);
	    log.debug("2. outVO :" + outVO);

	    // userId가 null이거나 비어있다면 조회수 증가를 하지 않음
	    if (inVO.getUserId() == null || inVO.getUserId().isEmpty()) {
	        log.debug("3. userId가 없습니다. 조회수를 증가시키지 않습니다.");
	        return outVO;
	    }

	    if (outVO != null) {
	        String readCheckKey = "read_check_" + inVO.getSeq();
	        if (session.getAttribute(readCheckKey) == null) {
	            // 조회수 증가
	            int flag = boardMapper.readCntUpdate(inVO);
	            log.debug("4. 조회 count 증가 :" + flag);

	            if (flag == 1) {
	                outVO.setViews(outVO.getViews() + 1);
	                session.setAttribute(readCheckKey, true);
	            }
	        } else {
	            log.debug("5. 이미 조회한 게시물입니다.");
	        }
	    }

	    return outVO;
	}
	
	
	/*
	 * @Override 
	 * public List<Board> mpSelect(Board inVO) throws SQLException {
	 * log.debug("1. param :"+inVO); 
	 * return this.boardMapper.mpSelect(inVO); 
	 * }
	 */
 

	@Override
	public List<Board> mpSelect(String userId) throws SQLException {
		// TODO Auto-generated method stub
		return boardMapper.mpSelect(userId);
		
	}

	@Override
	public int mpBoardUp(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return boardMapper.doUpdate(inVO);
	}

	@Override
	public Board mpBoardSelectOne(Board inVO) throws SQLException {
		//단건 조회
		log.debug("1. param :"+inVO);
		Board outVO = boardMapper.mpBoardSelectOne(inVO);
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
	 
	/* 안전정보페이지 메서드 */
	@Override
	public int save(Board inVO) throws SQLException {
		log.debug("1. inVO : " + inVO);
		
		int flag = boardMapper.save(inVO);
		log.debug("2. flag : " + flag);
		
		return flag;
	}

	@Override
	public List<Board> retrieve(Search search) throws SQLException {
		
		List<Board> list = boardMapper.retrieve(search);
		
		return list;
	}

	@Override
	public Board selectOne(Board inVO) throws SQLException {
		
		Board outVO = boardMapper.selectOne(inVO);
		
		return outVO;
	}

	@Override
	public Board moveUpdate(Board inVO) throws SQLException, NullPointerException {
		Board outVO01 = boardMapper.moveUpdate(inVO);
		return outVO01;
	}

	@Override
	public int update(Board inVO) throws SQLException {
		
		int flag = boardMapper.update(inVO);
		log.debug("1. flag : " + flag);
		
		return flag;
	}

	@Override
	public List<Board> doRetrieveAn(DTO search) throws SQLException {
		log.debug("1. param :"+search);
		return this.boardMapper.doRetrieveAn(search);
	}

	@Override
	public int anSave(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return boardMapper.anSave(inVO);
	}

	@Override
	public Board anSelectOne(Board inVO) throws SQLException, NullPointerException {
		//단건 조회
		log.debug("1. param :"+inVO);
		Board outVO = boardMapper.anSelectOne(inVO);
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

	@Override
	public Board anMoveUpdate(Board inVO) throws SQLException, NullPointerException {
		Board outVO01 = boardMapper.anMoveUpdate(inVO);
		return outVO01;
	}

	@Override
	public int anUpdate(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return boardMapper.anUpdate(inVO);
	}

	@Override
	public List<Board> notice(DTO search) throws Exception {
		return boardMapper.notice(search);
	}

	@Override
	public int fileSave(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return boardMapper.fileSave(inVO);
	}

	@Override
	public int fileUpdate(Board inVO) throws SQLException {
		int flag = boardMapper.fileUpdate(inVO);
		log.debug("1. flag : " + flag);
		
		return flag;
	}

	@Override
	public int fileDelete(Board inVO) throws SQLException {
		int flag = boardMapper.fileDelete(inVO);
		log.debug("1. flag : " + flag);
		
		return flag;
	}

	@Override
	public int noFileSave(Board inVO) throws SQLException {
		log.debug("1. param :"+inVO);
		return boardMapper.noFileSave(inVO);
	}

		 

}
