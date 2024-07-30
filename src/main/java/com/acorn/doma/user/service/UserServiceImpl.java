package com.acorn.doma.user.service;

import java.sql.SQLException;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService, PLog{

	@Autowired
	UserMapper userMapper;
	
	public UserServiceImpl() {};
	
	@Override
	public List<User> doRetrieve(DTO search) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doUpdate(User inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(User inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doSave(User inVO) throws SQLException {
		int flag = 0;
		
		flag = userMapper.doSave(inVO);
		log.debug("flag : " + flag);		
		
		return flag;
	}

	@Override
	public User doSelectOne(User inVO) throws SQLException, NullPointerException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String doRegister() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getUserId(String userId) throws Exception {
		
		log.debug("1. param : " + userId);	
		String outVO = this.userMapper.getUserId(userId);
		log.debug("2. outVO : " + outVO);
		
		return outVO;
		
	}

	
}
