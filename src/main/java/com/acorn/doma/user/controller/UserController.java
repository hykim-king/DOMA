package com.acorn.doma.user.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.User;
import com.acorn.doma.user.service.UserService;
import com.google.gson.Gson;

@Controller
@RequestMapping("user")
public class UserController implements PLog {

	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;

	public UserController() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ UserController()          │");
		log.debug("└───────────────────────────┘");
	}
	
	@RequestMapping(value = "/doRegister.do"
			   , method = RequestMethod.GET
			   , produces = "text/plain;charset=UTF-8"
			   ) //produces : 화면으로 전송 encoding 
	public String doRegister(Model model, User inVO) throws SQLException{
		// /WEB-INF/views+ viewName + ".jsp
		// /WEB-INF/views/user/user_list.jsp		
		log.debug("┌───────────────────────────┐");
		log.debug("│ doRegister()              │");
		log.debug("└───────────────────────────┘");
		String viewName = "join/register";
		
		return viewName;
	}
	
	@RequestMapping(value = "/idCheck.do"
			   , method = RequestMethod.GET
			   , produces = "text/plain;charset=UTF-8"
			   ) //produces : 화면으로 전송 encoding 
	@ResponseBody
	public String idCheck(User inVO) throws SQLException{
		// /WEB-INF/views+ viewName + ".jsp
		// /WEB-INF/views/user/user_list.jsp		
		log.debug("┌───────────────────────────┐");
		log.debug("│ idCheck()                 │");
		log.debug("└───────────────────────────┘");
		String jsonString = "";
		
		log.debug("1.param:" + inVO);
		User outVO = userService.doSelectOne(inVO);
		
		log.debug("2. outVO : " + outVO);
		String message = "";
		int flag = 0;
		if(null == outVO) {
			message = inVO.getUserId() + "를 사용할 수 있습니다.";
			flag = 1;
		}else {
			message = inVO.getUserId() + "는 이미 존재하는 아이디입니다.";
		}
		
		jsonString = new Gson().toJson(new Message(flag, message));	
		log.debug("2.jsonString:" + jsonString);
		
		return jsonString;
	}
	

	@RequestMapping(value = "/doSave.do"
			   , method = RequestMethod.POST
			   , produces = "text/plain;charset=UTF-8"
			   ) //produces : 화면으로 전송 encoding 
	@ResponseBody
	public String doSave(User user) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doSave()                  │");
		log.debug("└───────────────────────────┘");
		
		String jsonString = "";
		
		//1.
		log.debug("1.param user:" + user);
		
		int flag = userService.doSave(user);
		
		//2. 
		log.debug("2.flag:" + flag);
		
		String message = "";
		
		if(1 == flag) {
			message = user.getUserId() + "님이 등록 되었습니다.";
		}else {
			message = user.getUserId() + "님 등록 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		Gson gson = new Gson();
		jsonString = gson.toJson(messageObj);
		
		//3.
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
	}

	
	@RequestMapping(value = "/doUpdate.do"
				   , method = RequestMethod.POST
				   , produces = "text/plain;charset=UTF-8"
				   ) //produces : 화면으로 전송 encoding 
	@ResponseBody
	public String doUpdate(User inVO) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doUpdate()                │");
		log.debug("└───────────────────────────┘");
		
		String jsonString = "";
		
		//1.
		log.debug("1.param:" + inVO);
		
		int flag = userService.doUpdate(inVO);
		
		//2. 
		log.debug("2.flag:" + flag);
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 수정 되었습니다.";
			flag = 1;
		}else {
			message = inVO.getUserId() + "수정 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		Gson gson = new Gson();
		jsonString = gson.toJson(messageObj);
		
		//3.
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value = "/doDelete.do"
			    	, method = RequestMethod.GET
			        , produces = "text/plain;charset=UTF-8"
			        ) //produces : 화면으로 전송 encoding)
	@ResponseBody
	public String doDelete(User inVO) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doDelete()                │");
		log.debug("└───────────────────────────┘");
		
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		int flag = userService.doDelete(inVO);
		
		String message = "";
		
		if(1 == flag) {
			message = inVO.getUserId() + "님이 삭제 되었습니다.";
			flag = 1;
		}else {
			message = inVO.getUserId() + "삭제 실패 되었습니다.";
		}
		
		jsonString = new Gson().toJson(new Message(flag, message));
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value = "/doSelectOne.do"
					, method = RequestMethod.GET
					, produces = "text/plain;charset=UTF-8"
					) //produces : 화면으로 전송 encoding
	@ResponseBody
	public String doSelectOne(User inVO) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doSelectOne()             │");
		log.debug("└───────────────────────────┘");
		
		String jsonString = "";
		
		log.debug("1.param:" + inVO);
		User outVO = userService.doSelectOne(inVO);
		
		String message = "";
		int flag = 0;
		if(null != outVO) {
			message = inVO.getUserId() + "님이 조회 되었습니다.";
			flag = 1;
		}else {
			message = inVO.getUserId() + "조회 실패 되었습니다.";
		}
		
		jsonString = new Gson().toJson(new Message(flag, message));
		log.debug("2.jsonString:" + jsonString);
		
		return jsonString;
	}
	
}
