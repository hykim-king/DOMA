package com.acorn.doma.cmn;

public class DTO {

	public static final int BOTTOM_COUNT = 10; //바닥글
	
	private int no;// 글번호
	private int totalCnt;// 총 글수

	private int pageSize;// 페이지 사이즈
	private int pageNo;// 페이지 번호

	public DTO() {		
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

