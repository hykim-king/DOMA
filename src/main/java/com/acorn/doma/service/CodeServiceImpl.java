package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.DTO;
import com.acorn.doma.domain.Code;
import com.acorn.doma.mapper.CodeMapper;

@Service
public class CodeServiceImpl implements CodeService, PLog {
	
	@Autowired
	CodeMapper codeMapper;
	
	public CodeServiceImpl() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ CodeServiceImpl()         │");
		log.debug("└───────────────────────────┘");
	}

	@Override
	public List<Code> doRetrieve(DTO search) throws SQLException {
		Code inVO = (Code) search;
		
		log.debug("1.param" + inVO);
		List<Code> list = codeMapper.doRetrieve(inVO);
		for(Code vo :list) {
			log.debug(vo);
		}
		return list;
	}
	
	@Override
	public List<Code> doRetrieveAn(DTO search) throws SQLException {
		Code inVO = (Code) search;
		
		log.debug("1.param" + inVO);
		List<Code> list = codeMapper.doRetrieveAn(inVO);
		for(Code vo :list) {
			log.debug(vo);
		}
		return list;
	}

	@Override
	public int doUpdate(Code inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(Code inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doSave(Code inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Code doSelectOne(Code inVO) throws SQLException {
		
		return null;
	}
	
	@Override
	public List<Code> doRetrieveIn(List<String> codeList) throws SQLException {
		log.debug("1.param" + codeList);
		
		List<Code> list = codeMapper.doRetrieveIn(codeList);
		for(Code vo :list) {
			log.debug(vo);
		}
		return list;
	}
	

}
