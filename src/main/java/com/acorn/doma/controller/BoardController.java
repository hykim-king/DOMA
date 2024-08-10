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
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.acorn.doma.service.MarkdownService;
import com.google.gson.GsonBuilder;
import com.acorn.doma.cmn.Message;
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
	
	@Autowired
	MarkdownService markdownService;
	
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
	
	/**
	 * 다건 조회
	 * @param model
	 * @param req
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doRetrieve.do
	 */
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
		
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 상세페이지 이동
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/moveToReg.do
	 */
	@RequestMapping(value = "/moveToReg.do"
			   , method = RequestMethod.GET)
	public String moveToReg(Board inVO, Model model) throws SQLException {
		String viewName = "board/board_reg";
		
		log.debug("1.param inVO:" + inVO);
		model.addAttribute("board", inVO);
		
		Search search = new Search();
		
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
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	
	/**
	 * 업데이트
	 * @param inVO
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doUpdate.do
	 */
	@RequestMapping(value = "/doUpdate.do"
			   , method = RequestMethod.POST            //textarea post로
			   , produces = "text/plain;charset=UTF-8") //json encoding 
	@ResponseBody //json으로 리턴하기 위한
	public String doUpdate(Board inVO) throws SQLException {
		
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		int flag = boardService.doUpdate(inVO);
		log.debug("2.flag:" + flag);
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 수정 되었습니다.";
		}else {
			message = inVO.getUserId() + "수정 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	/**
	 * 단건 삭제
	 * @param inVO
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doDelete.do
	 */
	@RequestMapping(value = "/doDelete.do"
	    	, method = RequestMethod.GET
	        , produces = "text/plain;charset=UTF-8"
	        ) //produces : 화면으로 전송 encoding)
	@ResponseBody
	public String doDelete(Board inVO) throws SQLException {
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		int flag = boardService.doDelete(inVO);
		
		log.debug("1.flag:" + flag);
		String message = "";
		
		if(1 == flag) {
			message =  "삭제 되었습니다.";
		}else {
			message =   "실패 되었습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	/**
	 * 단건 조회
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doSelectOne.do
	 */
	@RequestMapping(value = "/doSelectOne.do"
			, method = RequestMethod.GET
			, produces = "text/plain;charset=UTF-8") 
	public String doSelectOne(Board inVO, Model model) throws SQLException {
		String viewName = "board/board_mng";
		String jsonString = "";
		log.debug("1.param inVO :" + inVO);
		
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		Board outVO = boardService.doSelectOne(inVO);
		
		//markdown으로 contents변경
		String markdownContents = this.markdownService.convertMarkdownToHtml(outVO.getContent());
		
		log.debug("2.outVO :" + outVO);
		
		String message = "";
		int flag = 0;
		if(null != outVO) {
			message = outVO.getTitle() + "이 조회 되었습니다.";
			flag = 1;
		}else {
			message = outVO.getTitle() + "조회 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		model.addAttribute("markdownContents", markdownContents);
		model.addAttribute("board", outVO);
		model.addAttribute("message", message);
		
		Search search = new Search();
		
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
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 단건 등록
	 * @param user
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/doSave.do
	 */
	@RequestMapping(value = "/doSave.do"
				   , method = RequestMethod.POST
				   , produces = "text/plain;charset=UTF-8"
				   ) //produces : 화면으로 전송 encoding
	@ResponseBody
	public String doSave(Board inVO) throws SQLException {
		String jsonString = "";
		log.debug("1.param inVO:" + inVO);
		
		int flag = boardService.doSave(inVO);
		log.debug("2.flag:" + flag);
		
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 등록 되었습니다.";
		}else {
			message = inVO.getUserId() + "님 등록 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		//json 출력을 가지런하게!
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
	}
	
}
