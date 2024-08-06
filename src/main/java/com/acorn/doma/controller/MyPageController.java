package com.acorn.doma.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.UserMapper;
import com.acorn.doma.service.UserService;
import com.google.gson.Gson;
import com.acorn.doma.cmn.Message; 

@Controller
@RequestMapping("mypage")
public class MyPageController implements PLog {

	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;
	
	@Autowired
	UserMapper userMapper;
	
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
	
	@RequestMapping(value = "/doUpdate.do", 
			method = RequestMethod.POST, 
			produces = "text/plain;charset=UTF-8") // produces	 																									// encoding
	@ResponseBody
	public String doUpdate(User inVO, HttpSession httpSession) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doUpdate()                │");
		log.debug("└───────────────────────────┘");

		String jsonString = "";

		// 1.
		log.debug("1.param:" + inVO);

		int flag = userMapper.doUpdate(inVO);

		// 2.
		log.debug("2.flag:" + flag);
		String message = "";
		if (1 == flag) {
			message = inVO.getUserId() + "님이 수정 되었습니다.";
			httpSession.setAttribute("user", inVO);
			
			flag = 1;
		} else {
			message = inVO.getUserId() + "수정 실패 했습니다.";
		}

		Message messageObj = new Message(flag, message);

		Gson gson = new Gson();
		jsonString = gson.toJson(messageObj);

		// 3.
		log.debug("3.jsonString:" + jsonString);

		return jsonString;
	}
	
}
