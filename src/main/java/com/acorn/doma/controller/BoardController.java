package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.acorn.doma.domain.Board;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Code;

@Controller
@RequestMapping("board")
public class BoardController implements PLog {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CodeService codeService;
	
	public BoardController() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ BoardController()         │");
		log.debug("└───────────────────────────┘");
	}
	
	//http://localhost:8080/doma/board/board.do
	@GetMapping("/board.do")
	public String boardList(Model model) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ boardList()               │");
		log.debug("└───────────────────────────┘");
		String viewName = "/board/board_list";
		
		return viewName;
	}
	
	//http://localhost:8080/doma/board/doRetrieve.do
	@RequestMapping(value = "/doRetrieve.do"
			   , method = RequestMethod.GET)
	public String doRetrieve(Model model, HttpServletRequest req) throws SQLException{
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ doRetrieve()                                 │");
		log.debug("└──────────────────────────────────────────────┘");
		
		String viewName = "board/board_list";
		
		Search search = new Search();
		
		String div = StringUtil.nvl(req.getParameter("div"), "");
		search.setDiv(div);
		
		//검색구분
		//검색 null 처리 : null -> ""
		String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"), "");
		String searchWord = StringUtil.nvl(req.getParameter("searchWord"), "");
		
		search.setSearchDiv(searchDiv);
		search.setSearchWord(searchWord);
		
		//브라우저에서 숫자 : 문자로 들어 온다.
		String pagsSize = StringUtil.nvl(req.getParameter("pageSize"), "10");
		String pageNo = StringUtil.nvl(req.getParameter("pageNo"), "1");
		
		search.setPageSize(Integer.parseInt(pagsSize));
		search.setPageNo(Integer.parseInt(pageNo));
		
		log.debug("1. search:" + search);
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		
		//MEMBER_SEARCH : 회원 검색 조건
		code.setMstCode("BOARD_SEARCH");
		List<Code> memberSearch = this.codeService.doRetrieve(code);
		model.addAttribute("BOARD_SEARCH", memberSearch); //검색조건
		
		//COM_PAGE_SIZE : 페이지 사이즈
		code.setMstCode("COM_PAGE_SIZE");
		List<Code> pageSizeSearch = this.codeService.doRetrieve(code);
		model.addAttribute("COM_PAGE_SIZE", pageSizeSearch); //페이지 사이즈
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	
}
