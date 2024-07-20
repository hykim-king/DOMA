package com.pcwk.ehr.mymapper.domain;

import com.pcwk.ehr.cmn.DTO;

public class MyMapper extends DTO {
	private String userId;// 사용자 id
	private String password;// 비밀번호

	public MyMapper() {

	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "MyMapper [userId=" + userId + ", password=" + password + ", toString()=" + super.toString() + "]";
	}

}