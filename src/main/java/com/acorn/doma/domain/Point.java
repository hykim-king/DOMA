package com.acorn.doma.domain;

public class Point {
	private int seq;
	private int year;
	private String accPoint;
	private String polygon;
	private int accdient;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report;
	private int sigVio;
	private int speeding;
	private int distance;
	private int protection;
	private int central;
	private int uTern;
	private String accGrade;
	private String gname;
	double longitude;
	double latitude;
	public Point() {}
	public Point(int seq, int year, String accPoint, String polygon, int accdient, int dead, int seriously,
			int ordinary, int report, int sigVio, int speeding, int distance, int protection, int central, int uTern,
			String accGrade, String gname, double longitude, double latitude) {
		super();
		this.seq = seq;
		this.year = year;
		this.accPoint = accPoint;
		this.polygon = polygon;
		this.accdient = accdient;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.sigVio = sigVio;
		this.speeding = speeding;
		this.distance = distance;
		this.protection = protection;
		this.central = central;
		this.uTern = uTern;
		this.accGrade = accGrade;
		this.gname = gname;
		this.longitude = longitude;
		this.latitude = latitude;
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
	public String getAccPoint() {
		return accPoint;
	}
	public void setAccPoint(String accPoint) {
		this.accPoint = accPoint;
	}
	public String getPolygon() {
		return polygon;
	}
	public void setPolygon(String polygon) {
		this.polygon = polygon;
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
	public int getSigVio() {
		return sigVio;
	}
	public void setSigVio(int sigVio) {
		this.sigVio = sigVio;
	}
	public int getSpeeding() {
		return speeding;
	}
	public void setSpeeding(int speeding) {
		this.speeding = speeding;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	public int getProtection() {
		return protection;
	}
	public void setProtection(int protection) {
		this.protection = protection;
	}
	public int getCentral() {
		return central;
	}
	public void setCentral(int central) {
		this.central = central;
	}
	public int getuTern() {
		return uTern;
	}
	public void setuTern(int uTern) {
		this.uTern = uTern;
	}
	public String getAccGrade() {
		return accGrade;
	}
	public void setAccGrade(String accGrade) {
		this.accGrade = accGrade;
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
		return "Point [seq=" + seq + ", year=" + year + ", accPoint=" + accPoint + ", polygon=" + polygon
				+ ", accdient=" + accdient + ", dead=" + dead + ", seriously=" + seriously + ", ordinary=" + ordinary
				+ ", report=" + report + ", sigVio=" + sigVio + ", speeding=" + speeding + ", distance=" + distance
				+ ", protection=" + protection + ", central=" + central + ", uTern=" + uTern + ", accGrade=" + accGrade
				+ ", gname=" + gname + ", longitude=" + longitude + ", latitude=" + latitude + "]";
	}
	
}
