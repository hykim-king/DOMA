package com.acorn.doma.domain;

public class Point {
	private String pid;
	private String accPoint;
	private int accident;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report;
	private String pointType;
	private double longitude;
	private double latitude;
	private String year;
	private String gname;
	private int accFrequency;
	public Point() {}
	public Point(String pid, String accPoint, int accident, int dead, int seriously, int ordinary, int report,
			String pointType, double longitude, double latitude, String year, String gname, int accFrequency) {
		super();
		this.pid = pid;
		this.accPoint = accPoint;
		this.accident = accident;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.pointType = pointType;
		this.longitude = longitude;
		this.latitude = latitude;
		this.year = year;
		this.gname = gname;
		this.accFrequency = accFrequency;
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
	public int getAccident() {
		return accident;
	}
	public void setAccident(int accident) {
		this.accident = accident;
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
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public int getAccFrequency() {
		return accFrequency;
	}
	public void setAccFrequency(int accFrequency) {
		this.accFrequency = accFrequency;
	}
	@Override
	public String toString() {
		return "Point [pid=" + pid + ", accPoint=" + accPoint + ", accident=" + accident + ", dead=" + dead
				+ ", seriously=" + seriously + ", ordinary=" + ordinary + ", report=" + report + ", pointType="
				+ pointType + ", longitude=" + longitude + ", latitude=" + latitude + ", year=" + year + ", gname="
				+ gname + ", accFrequency=" + accFrequency + "]";
	}
	
	
	
	
	
}