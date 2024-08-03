package com.acorn.doma.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.acorn.doma.cmn.PLog;

@Controller
@RequestMapping("main")
public class MainController implements PLog {

	public MainController() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ MainController()             │");
		log.debug("└──────────────────────────────┘");
	}
	
	//http://localhost:8080/doma/main/main.do
	@GetMapping("/main.do")
	public String main() {
		String viewName = "main/main_emergency_info";
		log.debug("┌──────────────────────────────┐");
		log.debug("│ main()                       │");
		log.debug("└──────────────────────────────┘");
		
		return viewName;
	}
	
}
