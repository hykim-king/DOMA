package com.acorn.doma.domain;

public class Point {
	private String pid;
	private String accPoint;
	private int accdient;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report;
	private String pointType;
	private double longitude;
	private double latitude;
	private String year;
	private String gname;
	public Point() {}
	public Point(String pid, String accPoint, int accdient, int dead, int seriously, int ordinary, int report,
			String pointType, double longitude, double latitude, String year, String gname) {
		super();
		this.pid = pid;
		this.accPoint = accPoint;
		this.accdient = accdient;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.pointType = pointType;
		this.longitude = longitude;
		this.latitude = latitude;
		this.year = year;
		this.gname = gname;
	}

	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getAccPoint() {
		return accPoint;
	}
	public void setAccPoint(String accPoint) {
		this.accPoint = accPoint;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public int getAccdient() {
		return accdient;
	}
	public void setAccdient(int accdient) {
		this.accdient = accdient;
	}
	public int getDead() {
		return dead;
	}
	public void setDead(int dead) {
		this.dead = dead;
	}
	public int getSeriously() {
		return seriously;
	}
	public void setSeriously(int seriously) {
		this.seriously = seriously;
	}
	public int getOrdinary() {
		return ordinary;
	}
	public void setOrdinary(int ordinary) {
		this.ordinary = ordinary;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
	public String getPointType() {
		return pointType;
	}
	public void setPointType(String pointType) {
		this.pointType = pointType;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
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
		return "Point [pid=" + pid + ", accPoint=" + accPoint + ", year=" + year + ", accdient=" + accdient + ", dead="
				+ dead + ", seriously=" + seriously + ", ordinary=" + ordinary + ", report=" + report + ", pointType="
				+ pointType + ", gname=" + gname + ", longitude=" + longitude + ", latitude=" + latitude + "]";
	}
	
}