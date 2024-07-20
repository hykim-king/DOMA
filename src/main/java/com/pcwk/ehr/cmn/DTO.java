package com.pcwk.ehr.cmn;

/**
 * 모든 Value Object는 DTO를 상속 받아야 한다.
 */

public class DTO {

	private int no;// 글번호
	private int totalCnt;// 총 글수

	private int pageSize;// 페이지 사이즈
	private int pageNo;// 페이지 번호

	public DTO() {
		pageSize = 10;
		pageNo = 1;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	@Override
	public String toString() {
		return "DTO [no=" + no + ", totalCnt=" + totalCnt + ", pageSize=" + pageSize + ", pageNo=" + pageNo + "]";
	}

}