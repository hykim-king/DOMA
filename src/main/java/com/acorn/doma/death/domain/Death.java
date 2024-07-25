package com.acorn.doma.death.domain;

public class Death {
	private String year;
	private String month;
	private String day;
	private String hour;
	private String dayNight;
	private String dayWeek;
	private String casualties;
	private int dead;
	private int seriously;
	private int ordinary;
	private int report;
	private String gname;
	private String accMajor;
	private String accMedium;
	private String accType;
	private String vioLaw;
	private String roadMajor;
	private String roadType;
	private String mTypeO;
	private String mTypeT;
	double longitude;
	double latitude;
	public Death() {}
	
	public Death(String year, String month, String day, String hour, String dayNight, String dayWeek, String casualties,
			int dead, int seriously, int ordinary, int report, String gname, String accMajor, String accMedium,
			String accType, String vioLaw, String roadMajor, String roadType, String mTypeO, String mTypeT,
			double longitude, double latitude) {
		super();
		this.year = year;
		this.month = month;
		this.day = day;
		this.hour = hour;
		this.dayNight = dayNight;
		this.dayWeek = dayWeek;
		this.casualties = casualties;
		this.dead = dead;
		this.seriously = seriously;
		this.ordinary = ordinary;
		this.report = report;
		this.gname = gname;
		this.accMajor = accMajor;
		this.accMedium = accMedium;
		this.accType = accType;
		this.vioLaw = vioLaw;
		this.roadMajor = roadMajor;
		this.roadType = roadType;
		this.mTypeO = mTypeO;
		this.mTypeT = mTypeT;
		this.longitude = longitude;
		this.latitude = latitude;
	}

	public String getYear() {
		return year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getHour() {
		return hour;
	}
	public void setHour(String hour) {
		this.hour = hour;
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
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
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
	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	public String getVioLaw() {
		return vioLaw;
	}
	public void setVioLaw(String vioLaw) {
		this.vioLaw = vioLaw;
	}
	public String getRoadMajor() {
		return roadMajor;
	}
	public void setRoadMajor(String roadMajor) {
		this.roadMajor = roadMajor;
	}
	public String getRoadType() {
		return roadType;
	}
	public void setRoadType(String roadType) {
		this.roadType = roadType;
	}
	public String getmTypeO() {
		return mTypeO;
	}
	public void setmTypeO(String mTypeO) {
		this.mTypeO = mTypeO;
	}
	public String getmTypeT() {
		return mTypeT;
	}
	public void setmTypeT(String mTypeT) {
		this.mTypeT = mTypeT;
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
	public void setYear(String year) {
		this.year = year;
	}
	@Override
	public String toString() {
		return "Death [year=" + year + ", month=" + month + ", day=" + day + ", hour=" + hour + ", dayNight=" + dayNight
				+ ", dayWeek=" + dayWeek + ", casualties=" + casualties + ", dead=" + dead + ", seriously=" + seriously
				+ ", ordinary=" + ordinary + ", report=" + report + ", gname=" + gname + ", accMajor=" + accMajor
				+ ", accMedium=" + accMedium + ", accType=" + accType + ", vioLaw=" + vioLaw + ", roadMajor="
				+ roadMajor + ", roadType=" + roadType + ", mTypeO=" + mTypeO + ", mTypeT=" + mTypeT + ", longitude="
				+ longitude + ", latitude=" + latitude + "]";
	}
	
}