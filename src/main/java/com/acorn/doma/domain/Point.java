package com.acorn.doma.domain;

public class Point {
	private int pid;
	private String gcode;
	private int year;
	private String accPoint;
	private String polygon;
	private int accdient;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report;
	private String pointType;
	private double longitude;
	private double latitude;
	public Point() {}
	public Point(int pid, String gcode, int year, String accPoint, String polygon, int accdient, int dead,
			int seriously, int ordinary, int report, String pointType, double longitude, double latitude) {
		super();
		this.pid = pid;
		this.gcode = gcode;
		this.year = year;
		this.accPoint = accPoint;
		this.polygon = polygon;
		this.accdient = accdient;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.pointType = pointType;
		this.longitude = longitude;
		this.latitude = latitude;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getGcode() {
		return gcode;
	}
	public void setGcode(String gcode) {
		this.gcode = gcode;
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
	@Override
	public String toString() {
		return "Point [pid=" + pid + ", gcode=" + gcode + ", year=" + year + ", accPoint=" + accPoint + ", polygon="
				+ polygon + ", accdient=" + accdient + ", dead=" + dead + ", seriously=" + seriously + ", ordinary="
				+ ordinary + ", report=" + report + ", pointType=" + pointType + ", longitude=" + longitude
				+ ", latitude=" + latitude + "]";
	}
	
	
}