package com.acorn.doma.cmn;

/**
 * 모든 Value Object는 DTO를 상속 받아야 한다.
 * @author acorn
 *
 */
public class DTO {
	
	private int totalCnt; //총 글수
	
	private int no;       //글 번호
	
	private int pageSize;//페이지 사이즈
	private int pageNo;//페이지 번호
	
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

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	@Override
	public String toString() {
		return "DTO [totalCnt=" + totalCnt + ", no=" + no + ", pageSize=" + pageSize + ", pageNo=" + pageNo + "]";
	}

	
	
}
