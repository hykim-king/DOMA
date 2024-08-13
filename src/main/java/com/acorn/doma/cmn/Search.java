package com.acorn.doma.cmn;

/**
 * 검색 조건
 * 
 * @author Jinseo
 *
 */
public class Search extends DTO {

	private String searchDiv;// 검색구분
	private String searchWord;// 검색어
	private String div; //공지사항, 자유게시판
	private String searchGu; //구이름
	private int seq;
	
	public Search() {

	}

	public String getSearchDiv() {
		return searchDiv;
	}

	public void setSearchDiv(String searchDiv) {
		this.searchDiv = searchDiv;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getDiv() {
		return div;
	}

	public void setDiv(String div) {
		this.div = div;
	}

	public String getSearchGu() {
		return searchGu;
	}

	public void setSearchGu(String searchGu) {
		this.searchGu = searchGu;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}


	@Override
	public String toString() {
		return "Search [searchDiv=" + searchDiv + ", searchWord=" + searchWord + ", div=" + div + ", searchGu="
				+ searchGu + ", seq=" + seq + ", toString()=" + super.toString() + "]";
	}

	
}