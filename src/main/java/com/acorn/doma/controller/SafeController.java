package com.acorn.doma.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.acorn.doma.cmn.PLog;

@Controller
@RequestMapping("safe")
public class SafeController implements PLog {
	
	public void safeController() {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ safeController()                         │");
		log.debug("└──────────────────────────────────────────┘");	
	};
	
	
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
