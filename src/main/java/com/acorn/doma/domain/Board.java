package com.acorn.doma.domain;

public class Board {
	private int seq;
	private String div;
	private String title;
	private String regId;
	private String modId;
	private String content;
	private String imgLink;
	private String regDt;
	private String modDt;
	public Board() {}
	public Board(int seq, String div, String title, String regId, String modId, String content, String imgLink,
			String regDt, String modDt) {
		super();
		this.seq = seq;
		this.div = div;
		this.title = title;
		this.regId = regId;
		this.modId = modId;
		this.content = content;
		this.imgLink = imgLink;
		this.regDt = regDt;
		this.modDt = modDt;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getregId() {
		return regId;
	}
	public void setregId(String regId) {
		this.regId = regId;
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
	@Override
	public String toString() {
		return "Board [seq=" + seq + ", div=" + div + ", title=" + title + ", regId=" + regId + ", modId=" + modId
				+ ", content=" + content + ", imgLink=" + imgLink + ", regDt=" + regDt + ", modDt=" + modDt + "]";
	}
	
}