package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Code;

public interface CodeService extends WorkDiv<Code> {
	
		/**
		 * doRetrieveIn
		 * @param codeList(COM_PAGE_SIZE, MEMBER_SEARCH)
		 * @return List<Code>
		 * @throws SQLException
		 */
		public List<Code> doRetrieveIn(List<String> codeList) throws SQLException;
		
		List<Code> doRetrieveAn(DTO search) throws SQLException;
	
}
