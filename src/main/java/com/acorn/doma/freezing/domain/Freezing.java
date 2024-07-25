package com.acorn.doma.freezing.domain;

public class Freezing {
	private int seq;
	private int year;
	private int accident;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report; 
	private double longitude;
	private double latitude;
	private String polygon;
	private String gname;
	private String dname;
	private String accPoint;
	public Freezing() {}
	public Freezing(int seq, int year, int accident, int dead, int seriously, int ordinary, int report,
			double longitude, double latitude, String polygon, String gname, String dname, String accPoint) {
		super();
		this.seq = seq;
		this.year = year;
		this.accident = accident;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.longitude = longitude;
		this.latitude = latitude;
		this.polygon = polygon;
		this.gname = gname;
		this.dname = dname;
		this.accPoint = accPoint;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
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
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getAccPoint() {
		return accPoint;
	}
	public void setAccPoint(String accPoint) {
		this.accPoint = accPoint;
	}
	@Override
	public String toString() {
		return "Freezing [seq=" + seq + ", year=" + year + ", accident=" + accident + ", dead=" + dead + ", seriously="
				+ seriously + ", ordinary=" + ordinary + ", report=" + report + ", longitude=" + longitude
				+ ", latitude=" + latitude + ", polygon=" + polygon + ", gname=" + gname + ", dname=" + dname
				+ ", accPoint=" + accPoint + "]";
	}
	
}
