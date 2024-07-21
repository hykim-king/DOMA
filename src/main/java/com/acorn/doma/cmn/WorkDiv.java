package com.acorn.doma.cmn;

import java.sql.SQLException;
import java.util.List;

public interface WorkDiv<T> {

	/**
	 * 목록 조회
	 */
	List<T> doRetrieve(DTO search) throws SQLException;

	/**
	 * 회원 수정
	 * 
	 * @param user
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doUpdate(T inVO) throws SQLException;

	/**
	 * 단건 삭제
	 * 
	 * @param user
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doDelete(T inVO) throws SQLException;

	/**
	 * 단건 등록
	 * 
	 * @param user
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doSave(T inVO) throws SQLException;

	/**
	 * 회원 정보 단건 조회
	 * 
	 * @param User
	 * @return User
	 * @throws SQLException
	 * @throws NullPointerException
	 */
	T doSelectOne(T inVO) throws SQLException, NullPointerException;
}
