package com.acorn.doma.user.service;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.User;

public interface UserService extends WorkDiv<User> {

	public String doRegister() throws Exception;
	
	public String getUserId(String userId) throws Exception;
}
