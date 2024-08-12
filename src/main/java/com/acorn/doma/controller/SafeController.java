package com.acorn.doma.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Board;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.google.gson.Gson;

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
	
	@RequestMapping(value = "/savePage.do"
			   , method = RequestMethod.GET)
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
	public String safePage(Model model, HttpServletRequest req) throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : safePage()              │");
		log.debug("└──────────────────────────────────────────┘");	
		String viewName = "/safe/safe_info";
		
		
		return viewName;
	}
	
	
}
