package com.acorn.doma.domain;

import com.acorn.doma.cmn.DTO;

public class User extends DTO {

	private String userId;  //사용자id
	private String name;     //이름
	private String password; //비밀번호
	private String birthday; //생년월일
	private String phone;    //전화번호
	private String location; //주소
	private String email;    //이메일
	
	public User() {
		super();
	}
	public User(String userId, String name, String password, String birthday, String phone, String location,
			String email) {
		super();
		this.userId = userId;
		this.name = name;
		this.password = password;
		this.birthday = birthday;
		this.phone = phone;
		this.location = location;
		this.email = email;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", name=" + name + ", password=" + password + ", birthday=" + birthday
				+ ", phone=" + phone + ", location=" + location + ", email=" + email + ", toString()="
				+ super.toString() + "]";
	}
	
}
