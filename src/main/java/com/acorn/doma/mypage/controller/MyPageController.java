package com.acorn.doma.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.acorn.doma.cmn.PLog;

@Controller
public class MyPageController implements PLog {

	public MyPageController() { 
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ MyPageController()                       │");
		log.debug("└──────────────────────────────────────────┘");	
	}

	@GetMapping("/mypage/myPage_list.do")//@RequestMapping의 method = RequestMethod.GET의 축약형
	public String asyncIndex() {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ asyncIndex()                             │");
		log.debug("└──────────────────────────────────────────┘");			
			
		String viewName = "mypage/myPage_list";
		
		log.debug("viewName:"+viewName); 

		return viewName;		
	}
	
}
