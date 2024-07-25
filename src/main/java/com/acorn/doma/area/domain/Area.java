package com.acorn.doma.area.domain;

public class Area {
	private String year;
	private String accident;
	private String casualties;
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
	public Area() {}
	
	public Area(String year, String accident, String casualties, int dead, int seriously, int ordinary, int report,
			double longitude, double latitude, String polygon, String gname, String dname, String accPoint) {
		super();
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
		this.gname = gname;
		this.dname = dname;
		this.accPoint = accPoint;
	}

	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getAccident() {
		return accident;
	}
	public void setAccident(String accident) {
		this.accident = accident;
	}
	public String getCasualties() {
		return casualties;
	}
	public void setCasualties(String casualties) {
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
		return "Area [year=" + year + ", accident=" + accident + ", casualties=" + casualties + ", dead=" + dead
				+ ", seriously=" + seriously + ", ordinary=" + ordinary + ", report=" + report + ", longitude="
				+ longitude + ", latitude=" + latitude + ", polygon=" + polygon + ", gname=" + gname + ", dname="
				+ dname + ", accPoint=" + accPoint + "]";
	}
	
}