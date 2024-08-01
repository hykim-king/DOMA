package com.acorn.doma.mapper;

import java.sql.SQLException;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.User;

@Mapper
public interface UserMapper extends WorkDiv<User> {

	int getCount() throws SQLException;
	
	String getUserId(String userId) throws SQLException;
	
	User login(User user) throws SQLException;
}
