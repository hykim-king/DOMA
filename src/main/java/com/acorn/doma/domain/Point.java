package com.acorn.doma.domain;

public class Point {
	private int pid;
	private String accPoint;
	private int year;
	private int accdient;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report;
	private String pointType;
	private String gname;
	private double longitude;
	private double latitude;
	public Point() {}
	public Point(int pid, String accPoint, int year, int accdient, int dead, int seriously, int ordinary, int report,
			String pointType, String gname, double longitude, double latitude) {
		super();
		this.pid = pid;
		this.accPoint = accPoint;
		this.year = year;
		this.accdient = accdient;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.pointType = pointType;
		this.gname = gname;
		this.longitude = longitude;
		this.latitude = latitude;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getAccPoint() {
		return accPoint;
	}
	public void setAccPoint(String accPoint) {
		this.accPoint = accPoint;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
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