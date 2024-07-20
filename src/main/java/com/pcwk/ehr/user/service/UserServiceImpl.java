package com.pcwk.ehr.user.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.PLog;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.User;

@Service("UserServiceImpl")
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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public User doSelectOne(User inVO) throws SQLException, NullPointerException {
		// TODO Auto-generated method stub
		return null;
	}

}
