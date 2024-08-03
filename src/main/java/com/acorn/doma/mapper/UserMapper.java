package com.acorn.doma.mapper;

import java.sql.SQLException;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Death;
import com.acorn.doma.domain.User;

@Mapper
public interface UserMapper extends WorkDiv<User> {

	/**
	 * id중복 체크 
	 * @param inVO
	 * @return 1(사용불가)/0(사용가능)
	 * @throws SQLException
	 */
	int idDuplicateCheck(User inVO) throws SQLException;
	
	
	/**
	 * 다건 입력
	 * @return int
	 * @throws SQLException
	 */
	int multipleSave() throws SQLException;


	/**
	 * 전체 회원 조회
	 * @return List<User>
	 */
	List<User> getAll();


	/**
	 * 테스트용 전체 회원 수
	 * @return int
	 * @throws SQLException
	 */
	int getCount() throws SQLException;


	/**
	 * 테스트용 전체 데이터 삭제
	 * @return
	 * @throws SQLException
	 * 
	 * 
	 */
	int mpGradeUp(User inVO) throws SQLException;
	
	int deleteAmpGrageUpll() throws SQLException;
	
	int mpUpdate(User user) throws SQLException;
	
	String getUserId(String userId) throws SQLException;
	
	User login(User user) throws SQLException;
	 
	User mpSelectOne(User inVO) throws SQLException, NullPointerException;
	
	
	
}
