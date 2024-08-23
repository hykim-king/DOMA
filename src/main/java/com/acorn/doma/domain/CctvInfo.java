package com.acorn.doma.domain;

public class CctvInfo {
	private String coordtype;
	private int datacount;
	private String filecreatetime;
	private String cctvtype;
	private String cctvurl;
	private String coordx;
	private String coordy;
	private String cctvformat;
	private String cctvname;
	public CctvInfo() {}
	
	public String getCoordtype() {
		return coordtype;
	}
	public void setCoordtype(String coordtype) {
		this.coordtype = coordtype;
	}
	public int getDatacount() {
		return datacount;
	}
	public void setDatacount(int datacount) {
		this.datacount = datacount;
	}
	public String getFilecreatetime() {
		return filecreatetime;
	}
	public void setFilecreatetime(String filecreatetime) {
		this.filecreatetime = filecreatetime;
	}
	public String getCctvtype() {
		return cctvtype;
	}
	public void setCctvtype(String cctvtype) {
		this.cctvtype = cctvtype;
	}
	public String getCctvurl() {
		return cctvurl;
	}
	public void setCctvurl(String cctvurl) {
		this.cctvurl = cctvurl;
	}
	public String getCoordx() {
		return coordx;
	}
	public void setCoordx(String coordx) {
		this.coordx = coordx;
	}
	public String getCoordy() {
		return coordy;
	}
	public void setCoordy(String coordy) {
		this.coordy = coordy;
	}
	public String getCctvformat() {
		return cctvformat;
	}
	public void setCctvformat(String cctvformat) {
		this.cctvformat = cctvformat;
	}
	public String getCctvname() {
		return cctvname;
	}
	public void setCctvname(String cctvname) {
		this.cctvname = cctvname;
	}

	@Override
	public String toString() {
		return "CctvInfo [coordtype=" + coordtype + ", datacount=" + datacount + ", filecreatetime=" + filecreatetime
				+ ", cctvtype=" + cctvtype + ", cctvurl=" + cctvurl + ", coordx=" + coordx + ", coordy=" + coordy
				+ ", cctvformat=" + cctvformat + ", cctvname=" + cctvname + "]";
	}
	
	
}
