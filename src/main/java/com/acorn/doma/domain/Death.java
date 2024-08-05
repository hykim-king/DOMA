package com.acorn.doma.domain;

public class Death {
	private String gcode;
	private String accMajor;
	private String accMedium;
	private String year;
	private String occrDate;
	private String dayNight;
	private String dayWeek;
	private int dead;
	private int casualties;
	private int seriously;
	private int ordinary;
	private int report;
	private double longitude;
	private double latitude;
	public Death() {}
	public Death(String gcode, String accMajor, String accMedium, String year, String occrDate, String dayNight,
			String dayWeek, int dead, int casualties, int seriously, int ordinary, int report, double longitude,
			double latitude) {
		super();
		this.gcode = gcode;
		this.accMajor = accMajor;
		this.accMedium = accMedium;
		this.year = year;
		this.occrDate = occrDate;
		this.dayNight = dayNight;
		this.dayWeek = dayWeek;
		this.dead = dead;
		this.casualties = casualties;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.longitude = longitude;
		this.latitude = latitude;
	}
	public String getGcode() {
		return gcode;
	}
	public void setGcode(String gcode) {
		this.gcode = gcode;
	}
	public String getAccMajor() {
		return accMajor;
	}
	public void setAccMajor(String accMajor) {
		this.accMajor = accMajor;
	}
	public String getAccMedium() {
		return accMedium;
	}
	public void setAccMedium(String accMedium) {
		this.accMedium = accMedium;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getOccrDate() {
		return occrDate;
	}
	public void setOccrDate(String occrDate) {
		this.occrDate = occrDate;
	}
	public String getDayNight() {
		return dayNight;
	}
	public void setDayNight(String dayNight) {
		this.dayNight = dayNight;
	}
	public String getDayWeek() {
		return dayWeek;
	}
	public void setDayWeek(String dayWeek) {
		this.dayWeek = dayWeek;
	}
	public int getDead() {
		return dead;
	}
	public void setDead(int dead) {
		this.dead = dead;
	}
	public int getCasualties() {
		return casualties;
	}
	public void setCasualties(int casualties) {
		this.casualties = casualties;
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
	@Override
	public String toString() {
		return "Death [gcode=" + gcode + ", accMajor=" + accMajor + ", accMedium=" + accMedium + ", year=" + year
				+ ", occrDate=" + occrDate + ", dayNight=" + dayNight + ", dayWeek=" + dayWeek + ", dead=" + dead
				+ ", casualties=" + casualties + ", seriously=" + seriously + ", ordinary=" + ordinary + ", report="
				+ report + ", longitude=" + longitude + ", latitude=" + latitude + "]";
	}
	
}