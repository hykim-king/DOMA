package com.acorn.doma.domain;

import oracle.sql.DATE;

public class Accident {
	private String accId;
	private String occrDate;
	private String occrTime;
	private String endDate;
	private String endTime;
	private String accType;
	private String accDtype;
	private String info;
	private double longitude;
	private double latitude;
	
	public Accident() {}
	
	public Accident(String accId, String occrDate, String occrTime, String endDate, String endTime, String accType,
			String accDtype, String info, double longitude, double latitude) {
		super();
		this.accId = accId;
		this.occrDate = occrDate;
		this.occrTime = occrTime;
		this.endDate = endDate;
		this.endTime = endTime;
		this.accType = accType;
		this.accDtype = accDtype;
		this.info = info;
		this.longitude = longitude;
		this.latitude = latitude;
	}
	
	public String getAccId() {
		return accId;
	}
	public void setAccId(String accId) {
		this.accId = accId;
	}
	public String getOccrDate() {
		return occrDate;
	}
	public void setOccrDate(String occrDate) {
		this.occrDate = occrDate;
	}
	public String getOccrTime() {
		return occrTime;
	}
	public void setOccrTime(String occrTime) {
		this.occrTime = occrTime;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
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
	public String getAccDtype() {
		return accDtype;
	}
	public void setAccDtype(String accDtype) {
		this.accDtype = accDtype;
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
				+ ", endTime=" + endTime + ", accType=" + accType + ", accDtype=" + accDtype + ", info=" + info
				+ ", longitude=" + longitude + ", latitude=" + latitude + "]";
	}
	
	
}