package com.acorn.doma.domain;

import oracle.sql.DATE;

public class Accident {
	private String accId;
	private String accType;
	private String accName;
	private String accDtype;
	private String accDName;
	private String info;
	private String occrDate;
	private String occrTime;
	private String endDate;
	private String endTime;
	private double longitude;
	private double latitude;
	
	public Accident() {}

	public Accident(String accId, String accType, String accDtype, String info, String occrDate, String occrTime,
			String endDate, String endTime, double longitude, double latitude) {
		super();
		this.accId = accId;
		this.accType = accType;
		this.accDtype = accDtype;
		this.info = info;
		this.occrDate = occrDate;
		this.occrTime = occrTime;
		this.endDate = endDate;
		this.endTime = endTime;
		this.longitude = longitude;
		this.latitude = latitude;
	}

	public Accident(String accId, String accType, String accName, String accDtype, String accDName, String info,
			String occrDate, String occrTime, String endDate, String endTime, double longitude, double latitude) {
		super();
		this.accId = accId;
		this.accType = accType;
		this.accName = accName;
		this.accDtype = accDtype;
		this.accDName = accDName;
		this.info = info;
		this.occrDate = occrDate;
		this.occrTime = occrTime;
		this.endDate = endDate;
		this.endTime = endTime;
		this.longitude = longitude;
		this.latitude = latitude;
	}


	public String getAccId() {
		return accId;
	}

	public void setAccId(String accId) {
		this.accId = accId;
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

	public String getAccDtype() {
		return accDtype;
	}

	public void setAccDtype(String accDtype) {
		this.accDtype = accDtype;
	}

	public String getAccDName() {
		return accDName;
	}

	public void setAccDName(String accDName) {
		this.accDName = accDName;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
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
		return "Accident [accId=" + accId + ", accType=" + accType + ", accName=" + accName + ", accDtype=" + accDtype
				+ ", accDName=" + accDName + ", info=" + info + ", occrDate=" + occrDate + ", occrTime=" + occrTime
				+ ", endDate=" + endDate + ", endTime=" + endTime + ", longitude=" + longitude + ", latitude="
				+ latitude + ", toString()=" + super.toString() + "]";
	}
	
	
	
	
}