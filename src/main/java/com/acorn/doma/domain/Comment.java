package com.acorn.doma.domain;

public class Comment {
	private int comSeq;
	private int seq;
	private String userId;
	private String comment;
	private String regDt;
	private String modDt;
	public Comment() {}
	public Comment(int comSeq, int seq, String userId, String comment, String regDt, String modDt) {
		super();
		this.comSeq = comSeq;
		this.seq = seq;
		this.userId = userId;
		this.comment = comment;
		this.regDt = regDt;
		this.modDt = modDt;
	}	
	public int getComSeq() {
		return comSeq;
	}
	public void setComSeq(int comSeq) {
		this.comSeq = comSeq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
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
		return "Comment [comSeq=" + comSeq + ", seq=" + seq + ", userId=" + userId + ", comment=" + comment + ", regDt="
				+ regDt + ", modDt=" + modDt + "]";
	}
	
}
