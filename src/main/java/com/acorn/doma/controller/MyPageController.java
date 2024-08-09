package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Comments;
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.BoardMapper;
import com.acorn.doma.mapper.CommentsMapper;
import com.acorn.doma.mapper.UserMapper;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CommentsService;
import com.acorn.doma.service.UserService;
import com.google.gson.Gson;
import com.acorn.doma.cmn.Message; 

@Controller
@RequestMapping("mypage")
public class MyPageController implements PLog {
	
	//─────────────────────────────────서비스
	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;
	
	@Qualifier("boardServiceImpl")
	BoardService boardService;
	
	@Qualifier("commentServiceImpl")
	CommentsService commentService;
	
	
	//─────────────────────────────────매퍼
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	CommentsMapper commentMapper;
	
	
	
	 
	
	
	
	
	public MyPageController() { 
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ MyPageController()                       │");
		log.debug("└──────────────────────────────────────────┘");	
	}

	@GetMapping("myPage.do")
	public String MyPage(Model model)throws Exception {
		String viewName = "/mypage/MyPage";
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ mypage()                                 │");
		log.debug("└──────────────────────────────────────────┘");
		///WEB-INF/views/+viewName+.jsp
		return viewName;
	}
	
	
	
	
	
	@RequestMapping(value = "/mpSelect.do", method = RequestMethod.GET)
	public String moveToBoard(HttpSession session, Model model,Board inVO) throws SQLException {
	    String viewName = "mypage/MyPageBoard";
	    
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        log.debug("User from session: " + user);
	        model.addAttribute("board", user); // Use user instead of inVO
	        
	        List<Board> list = boardMapper.mpSelect(inVO); 
	        log.debug(list);
		    model.addAttribute("list", list); 
		    
	    } else {
	        log.debug("No user in session"); 
	    }
	    
	    return viewName;
	}
	
	
	
	@RequestMapping(value = "/mpCommentSelect.do", method = RequestMethod.GET)
	public String moveToComment(HttpSession session, Model model,Comments inVO) throws SQLException {
	    String viewName = "mypage/MyPageComment";
	    
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        log.debug("User from session: " + user);
	        model.addAttribute("comment", user); // Use user instead of inVO
	        
	        List<Comments> list = commentMapper.mpCommentSelect(inVO); 
	        log.debug(list);
		    model.addAttribute("list", list); 
		    
	    } else {
	        log.debug("No user in session"); 
	    }
	    
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
	
	@RequestMapping(value = "/mpGradeUp.do", 
			method = RequestMethod.POST, 
			produces = "text/plain;charset=UTF-8") // produces	 																									// encoding
	@ResponseBody
	public String mpGradeUp(User inVO, HttpSession httpSession) throws SQLException {
		log.debug("┌───────────────────────────┐");
		log.debug("│ mpGradeUp()                │");
		log.debug("└───────────────────────────┘");

		String jsonString = "";

		// 1.
		log.debug("1.param:" + inVO);

		int flag = userMapper.mpGradeUp(inVO);

		// 2.
		log.debug("2.flag:" + flag);
		String message = "";
		if (1 == flag) {
			message = inVO.getUserId() + "님이 탈퇴 되었습니다.";
			httpSession.setAttribute("user", inVO);
			
			flag = 1;
		} else {
			message = inVO.getUserId() + "탈퇴 실패 했습니다.";
		}

		Message messageObj = new Message(flag, message);

		Gson gson = new Gson();
		jsonString = gson.toJson(messageObj);

		// 3.
		log.debug("3.jsonString:" + jsonString);

		return jsonString;
	} 
	
	 @RequestMapping(value = "/mpSelect.do", 
			 method = RequestMethod.POST, 
			 produces = "application/json;charset=UTF-8")
	  
	 @ResponseBody 
	 public List<Board> mpSelect(Board inVO,Model model) throws SQLException { 
		 log.debug("1.param:" + inVO); 
	    List<Board> list = boardMapper.mpSelect(inVO); log.debug(list);
	    model.addAttribute("list", list); 
	    return list; 
	    
	 }
	 
	 
		
}
	
	
	
	
	 
