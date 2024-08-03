package com.acorn.doma.domain;

public class Freezing {
	private int fid;
	private String sidoCode;
	private String year;
	private int accident;
	private int casualties;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report; 
	private double longitude;
	private double latitude;
	private String polygon;
	private String accPoint;
	public Freezing() {}
	public Freezing(int fid, String sidoCode, String year, int accident, int casualties, int dead, int seriously,
			int ordinary, int report, double longitude, double latitude, String polygon, String accPoint) {
		super();
		this.fid = fid;
		this.sidoCode = sidoCode;
		this.year = year;
		this.accident = accident;
		this.casualties = casualties;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.longitude = longitude;
		this.latitude = latitude;
		this.polygon = polygon;
		this.accPoint = accPoint;
	}
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getSidoCode() {
		return sidoCode;
	}
	public void setSidoCode(String sidoCode) {
		this.sidoCode = sidoCode;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public int getAccident() {
		return accident;
	}
	public void setAccident(int accident) {
		this.accident = accident;
	}
	public int getCasualties() {
		return casualties;
	}
	public void setCasualties(int casualties) {
		this.casualties = casualties;
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
	public String getPolygon() {
		return polygon;
	}
	public void setPolygon(String polygon) {
		this.polygon = polygon;
	}
	public String getAccPoint() {
		return accPoint;
	}
	public void setAccPoint(String accPoint) {
		this.accPoint = accPoint;
	}
	@Override
	public String toString() {
		return "Freezing [fid=" + fid + ", sidoCode=" + sidoCode + ", year=" + year + ", accident=" + accident
				+ ", casualties=" + casualties + ", dead=" + dead + ", seriously=" + seriously + ", ordinary="
				+ ordinary + ", report=" + report + ", longitude=" + longitude + ", latitude=" + latitude + ", polygon="
				+ polygon + ", accPoint=" + accPoint + "]";
	}
	
}