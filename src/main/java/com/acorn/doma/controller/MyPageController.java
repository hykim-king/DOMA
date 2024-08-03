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

	 
	
	@RequestMapping(value = "/mpSelectOne.do", 
			method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doSelectOne(User inVO) throws Exception {
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ doSelectOne()                            │");
		log.debug("└──────────────────────────────────────────┘");
		String jsonString = "";

		log.debug("1. param: " + inVO);
		User outVO = userService.mpSelectOne(inVO);

		String message = "";
		int flag = 0;
		if (null != outVO) {
			message = inVO.getUserId() + "님이 조회 되었습니다.";
			flag = 1;
		} else {
			message = inVO.getUserId() + " 조회 실패!";
		}

		//message
		jsonString = new Gson().toJson(new Message(flag, message));
		
		//user
		String jsonUser =  new Gson().toJson(outVO);
		String allMessage = "{\"user\":"+jsonUser+",\"message\":"+jsonString+"}";
		
		log.debug("3.allMessage:" + allMessage);

		return allMessage;
	}
	
}
