package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Board;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("safe")
public class SafeController implements PLog {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CodeService codeService;
	
	public void safeController() {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController()                         │");
		log.debug("└──────────────────────────────────────────┘");	
	};
	
	@RequestMapping(value = "/doUpdate.do"
			   , method = RequestMethod.POST
			   , produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doUpdate(Board inVO) throws SQLException {
		
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		int flag = boardService.doUpdate(inVO);
		log.debug("2.flag:" + flag);
		String message = "";
		if(1 == flag) {
			message = inVO.getTitle() + "이 수정 되었습니다.";
		}else {
			message = "게시물 수정에 실패했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	@RequestMapping(value = "/doDelete.do"
	    	, method = RequestMethod.GET
	        , produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDelete(Board inVO) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : doDelete()              │");
		log.debug("└──────────────────────────────────────────┘");
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		int flag = boardService.doDelete(inVO);
		
		log.debug("1.flag:" + flag);
		String message = "";
		
		if(1 == flag) {
			message = inVO.getTitle() + "이 삭제 되었습니다.";
		}else {
			message = "게시글 삭제에 실패했습니다.";
		}
		
		jsonString = new Gson().toJson(new Message(flag, message));	
		log.debug("2. jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	@RequestMapping(value = "/save.do"
			   , method = RequestMethod.POST
			   ,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doSave(Board inVO) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : doSave()                │");
		log.debug("└──────────────────────────────────────────┘");
		
		log.debug("1. inVO : " + inVO);
		
		String jsonString = "";
		String message = "";
		
		int flag = boardService.save(inVO);
		if(flag == 1) {
			message = inVO.getTitle() + "이 저장되었습니다.";
		}else {
			message = "게시물 저장에 실패했습니다.";
		}
		
		jsonString = new Gson().toJson(new Message(flag, message));	
		log.debug("2. jsonString:" + jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value = "/selectOne.do"
			   , method = RequestMethod.GET)
	public String selectOne(Model model, Board inVO) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : selectOne()             │");
		log.debug("└──────────────────────────────────────────┘");
		
		log.debug("1. inVO : " + inVO);
		
		String viewName = "/safe/safe_selectOne_page";
		
		Board outVO = boardService.selectOne(inVO);
		log.debug("2. outVO : " + outVO);
		
		model.addAttribute("info", outVO);
		return viewName;
	}
	
	@RequestMapping(value = "/savePage.do"
			   , method = RequestMethod.GET
			   ,produces = "text/plain;charset=UTF-8")
	public String savePage() throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : savePage()              │");
		log.debug("└──────────────────────────────────────────┘");
		String viewName = "/safe/safe_save_page";
		
		return viewName;
	}
	
	@RequestMapping(value = "/safePage.do"
					,method = RequestMethod.GET
					,produces = "text/plain;charset=UTF-8")
	public String safePage(Model model) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : safePage()              │");
		log.debug("└──────────────────────────────────────────┘");	
		String viewName = "/safe/safe_info";
		
		Search search = new Search();
		search.setDiv("30");
		search.setPageNo(1);
		search.setPageSize(6);
		log.debug("1. search:" + search);
		
		List<Board> list30 = this.boardService.retrieve(search);
		log.debug("list:" + list30);
		model.addAttribute("list30", list30);
		
		search.setDiv("40");
		search.setPageNo(1);
		search.setPageSize(6);
		log.debug("1. search:" + search);
		
		List<Board> list40 = this.boardService.retrieve(search);
		log.debug("list40:" + list40);
		model.addAttribute("list40", list40);
		
		return viewName;
	}
	
	
}
