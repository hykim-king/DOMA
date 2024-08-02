package com.acorn.doma.user.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
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
	
	
	@RequestMapping(value = "/RegisterPage.do"
			   , method = RequestMethod.GET
			   , produces = "text/plain;charset=UTF-8"
			   ) //produces : 화면으로 전송 encoding 
	public String RegisterPage(Model model) throws SQLException{
		// /WEB-INF/views+ viewName + ".jsp
		// /WEB-INF/views/user/user_list.jsp		
		log.debug("┌───────────────────────────┐");
		log.debug("│ RegisterPage()            │");
		log.debug("└───────────────────────────┘");
		String viewName = "join/register";
		
		return viewName;
	}
	
	@RequestMapping(value = "/loginPage.do"
			   , method = RequestMethod.GET
			   , produces = "text/plain;charset=UTF-8"
			   ) //produces : 화면으로 전송 encoding 
	public String loginPage(Model model) throws SQLException{
		// /WEB-INF/views+ viewName + ".jsp
		// /WEB-INF/views/user/user_list.jsp		
		log.debug("┌───────────────────────────┐");
		log.debug("│ loginPage()               │");
		log.debug("└───────────────────────────┘");
		String viewName = "join/login";
		
		return viewName;
	}
	
	@RequestMapping(value = "/idCheck.do"
			   , method = RequestMethod.GET
			   , produces = "text/plain;charset=UTF-8"
			   ) //produces : 화면으로 전송 encoding 
	@ResponseBody
	public String idCheck(@RequestParam("userId") String inVO) throws Exception{
		// /WEB-INF/views+ viewName + ".jsp
		// /WEB-INF/views/user/user_list.jsp		
		log.debug("┌───────────────────────────┐");
		log.debug("│ idCheck()                 │");
		log.debug("└───────────────────────────┘");
		String jsonString = "";
		
		log.debug("1.param:" + inVO);
		String outVO = userService.getUserId(inVO);
		
		log.debug("2. outVO : " + outVO);
		String message = "";
		int flag = 0;
		if(null == outVO) {
			message = "\"" +  inVO + "\"" + "를 사용할 수 있습니다.";
			flag = 1;
		}else {
			message = "\"" +  inVO + "\"" + "는 이미 존재하는 아이디입니다.";
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
	
	@RequestMapping(value = "/Login.do"
					, method = RequestMethod.POST
					, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String Login(User user, HttpSession httpSession) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ Login()            	   │");
		log.debug("└───────────────────────────┘");
		
		String jsonString = "";
		
		log.debug("┌ 1.user:" + user);
		log.debug("│ 2.userId:" + user.getUserId());
		log.debug("│ 3.userPw:" + user.getUserPw());
		
		User outVO = userService.login(user);
		log.debug("│ 4.outVO:" + outVO);
		
		String message = "";
		int flag = 0;
		if(null != outVO) {
			message = "\"" + outVO.getUserName() + "\"" + "님이 로그인 하셨습니다.";
			httpSession.setAttribute("user", outVO);
			flag = 1;
		}else {
			message = "아이디 혹은 비밀번호가 일치하지 않습니다.";
		}
		
		jsonString = new Gson().toJson(new Message(flag, message));
		log.debug("└ 4.jsonString:" + jsonString);
		
		return jsonString;
	}
	
	@RequestMapping(value = "/moveToPage.do"
					, method = RequestMethod.POST
					, produces = "text/plain;charset=UTF-8")
		@ResponseBody
		public String moveToPage(HttpSession httpSession) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ moveToPage()            	   │");
		log.debug("└───────────────────────────┘");
		
		String viewName = "join/login_confirm_page";
		
		return viewName;
		}
}
