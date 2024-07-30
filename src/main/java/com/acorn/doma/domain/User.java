package com.acorn.doma.domain;

import com.acorn.doma.cmn.DTO;


public class User extends DTO {

	private String userId        ;
	private String userName      ;
	private String userPw        ;
	private String userEmail     ;
	private String birth          ;
	private int grade          	; //0 : 관리자 1 : 사용자
	private String address        ;
	private String detailAddress ;
	private String regDt         ;
	
	public User() {
		super();
	}

	public User(String userId, String userName, String userPw, String userEmail, String birth, int grade,
			String address, String detailAddress, String regDt) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPw = userPw;
		this.userEmail = userEmail;
		this.birth = birth;
		this.grade = grade;
		this.address = address;
		this.detailAddress = detailAddress;
		this.regDt = regDt;
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", userPw=" + userPw + ", userEmail=" + userEmail
				+ ", birth=" + birth + ", grade=" + grade + ", address=" + address + ", detailAddress=" + detailAddress
				+ ", regDt=" + regDt + ", toString()=" + super.toString() + "]";
	}
	
	
	
}
