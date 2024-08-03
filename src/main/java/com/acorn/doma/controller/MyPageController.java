package com.acorn.doma.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.User;
import com.acorn.doma.service.UserService;
import com.google.gson.Gson;
import com.acorn.doma.cmn.Message; 

@Controller
@RequestMapping("mypage")
public class MyPageController implements PLog {

	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;
	
	public MyPageController() { 
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ MyPageController()                       │");
		log.debug("└──────────────────────────────────────────┘");	
	}

	@GetMapping("myPage.do")
	public String main() {
		String viewName = "/mypage/MyPage";
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ mypage()                                 │");
		log.debug("└──────────────────────────────────────────┘");
		///WEB-INF/views/+viewName+.jsp
		return viewName;
	}
	
}
