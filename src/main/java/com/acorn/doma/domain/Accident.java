package com.acorn.doma.domain;

import oracle.sql.DATE;

public class Accident {
	String accId;
	DATE occrDate;
	String occrTime;
	DATE endDate;
	String endTime;
	String accType;	
	String info;
	double longitude;
	double latitude;
	public Accident() {}
	public String getAccId() {
		return accId;
	}
	public void setAccId(String accId) {
		this.accId = accId;
	}
	public DATE getOccrDate() {
		return occrDate;
	}
	public void setOccrDate(DATE occrDate) {
		this.occrDate = occrDate;
	}
	public String getOccrTime() {
		return occrTime;
	}
	public void setOccrTime(String occrTime) {
		this.occrTime = occrTime;
	}
	public DATE getEndDate() {
		return endDate;
	}
	public void setEndDate(DATE endDate) {
		this.endDate = endDate;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	@Override
	public String toString() {
		return "Accident [accId=" + accId + ", occrDate=" + occrDate + ", occrTime=" + occrTime + ", endDate=" + endDate
				+ ", endTime=" + endTime + ", accType=" + accType + ", info=" + info + ", longitude=" + longitude
				+ ", latitude=" + latitude + "]";
	}
	
}
