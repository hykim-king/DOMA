package com.acorn.doma.domain;

import com.acorn.doma.cmn.DTO;

public class Board extends DTO {
	
	private int seq;
	private String div;
	private String gname;
	private String title;
	private String userId; 
	private String modId;
	private String content;
	private String imgLink;
	private String regDt;
	private String modDt;
	private int views;
	
	public Board() { }

	public Board(int seq, String div, String title, String userId, String modId, String content, String imgLink,
			String regDt, String modDt, int views) {
		super();
		this.seq = seq;
		this.div = div;
		this.title = title;
		this.userId = userId;
		this.modId = modId;
		this.content = content;
		this.imgLink = imgLink;
		this.regDt = regDt;
		this.modDt = modDt;
		this.views = views;
	}

	public Board(int seq, String div, String gname, String title, String userId, String modId, String content,
			String imgLink, String regDt, String modDt, int views) {
		super();
		this.seq = seq;
		this.div = div;
		this.gname = gname;
		this.title = title;
		this.userId = userId;
		this.modId = modId;
		this.content = content;
		this.imgLink = imgLink;
		this.regDt = regDt;
		this.modDt = modDt;
		this.views = views;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getDiv() {
		return div;
	}

	public void setDiv(String div) {
		this.div = div;
	}

	public String getGname() {
		return gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImgLink() {
		return imgLink;
	}

	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getModDt() {
		return modDt;
	}

	public void setModDt(String modDt) {
		this.modDt = modDt;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	@Override
	public String toString() {
		return "Board [seq=" + seq + ", div=" + div + ", gname=" + gname + ", title=" + title + ", userId=" + userId
				+ ", modId=" + modId + ", content=" + content + ", imgLink=" + imgLink + ", regDt=" + regDt + ", modDt="
				+ modDt + ", views=" + views + ", toString()=" + super.toString() + "]";
	}

	
	 

	
}