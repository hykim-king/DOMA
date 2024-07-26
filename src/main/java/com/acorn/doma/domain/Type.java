package com.acorn.doma.domain;

public class Type {
	private String accType;
	private String accName;
	public Type() {}
	
	public Type(String accType, String accName) {
		super();
		this.accType = accType;
		this.accName = accName;
	}

	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	public String getAccName() {
		return accName;
	}
	public void setAccName(String accName) {
		this.accName = accName;
	}

	@Override
	public String toString() {
		return "Type [accType=" + accType + ", accName=" + accName + "]";
	}
	
}
