package com.pcwk.ehr.cmn;

/**
 * 검색 조건
 * 
 * @author Jinseo
 *
 */
public class Search extends DTO {

	private String searchDiv;// 검색구분
	private String searchWord;// 검색어

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

	@Override
	public String toString() {
		return "Search [searchDiv=" + searchDiv + ", searchWord=" + searchWord + ", toString()=" + super.toString()
				+ "]";
	}

}