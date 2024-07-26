package com.acorn.doma.domain;

public class Weather {
	private int seq;
	private int year;
	private String gname;
	private String condition;
	private String dead;
	private String injury;
	public Weather() {}
	public Weather(int seq, int year, String gname, String condition, String dead, String injury) {
		super();
		this.seq = seq;
		this.year = year;
		this.gname = gname;
		this.condition = condition;
		this.dead = dead;
		this.injury = injury;
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
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getDead() {
		return dead;
	}
	public void setDead(String dead) {
		this.dead = dead;
	}
	public String getInjury() {
		return injury;
	}
	public void setInjury(String injury) {
		this.injury = injury;
	}
	@Override
	public String toString() {
		return "Weather [seq=" + seq + ", year=" + year + ", gname=" + gname + ", condition=" + condition + ", dead="
				+ dead + ", injury=" + injury + "]";
	}
	
}
