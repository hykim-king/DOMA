package com.acorn.doma.service;

import java.util.Map;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.User;

public interface UserService extends WorkDiv<User> {

	public String doRegister() throws Exception;
	
	public String getUserId(String userId) throws Exception;
	
	public User login(User user) throws Exception;
	
	public User mpSelectOne(User user) throws Exception;
	
	public int mpGrageUp(User user) throws Exception; 
}
