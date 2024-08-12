package com.acorn.doma.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
			   , method = RequestMethod.GET)
	public String save() throws SQLException {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : save()              	  │");
		log.debug("└──────────────────────────────────────────┘");	
		
		String viewName = "/safe/safe_save_page";
		
		return viewName;
	}
	
	@RequestMapping(value = "/safePage.do"
					,method = RequestMethod.GET
					,produces = "text/plain;charset=UTF-8")
	public String safePage() {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController : safePage()              │");
		log.debug("└──────────────────────────────────────────┘");	
		String viewName = "/safe/safe_info";
			
		
		return viewName;
	}
	
	
}
