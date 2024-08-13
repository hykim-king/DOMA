package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Code;
import com.acorn.doma.domain.Comments;
import com.acorn.doma.service.CodeService;
import com.acorn.doma.service.CommentsService;
import com.acorn.doma.service.MarkdownService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("comments")
public class CommentsController implements PLog {
	
	@Autowired
	CommentsService commentsService;
	
	@Autowired
	CodeService codeService;
	
	@Autowired
	MarkdownService markdownService;
	
	public CommentsController() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ CommentsController()      │");
		log.debug("└───────────────────────────┘");
		
	}
	
	//http://localhost:8080/doma/comments/board_main.do
	@GetMapping("/board_main.do")
	public String boardList(Model model) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ boardList()               │");
		log.debug("└───────────────────────────┘");
		String viewName = "/board/board_main";
		
		return viewName;
	}
	
	/**
	 * 다건 조회
	 * @param model
	 * @param req
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/comments/doRetrieve.do
	 */
	@RequestMapping(value = "/doRetrieve.do"
			   , method = RequestMethod.GET
			   ,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doRetrieve(int seq) throws SQLException{
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ doRetrieve()                                 │");
		log.debug("└──────────────────────────────────────────────┘");
		
	
		
		List<Comments> list = this.commentsService.commentsList(seq);
		ObjectMapper objectMapper = new ObjectMapper();
	    String jsonString = "";
	    try {
	        jsonString = objectMapper.writeValueAsString(list);
	    } catch (JsonProcessingException e) {
	        log.error("Error converting to JSON", e);
	    }
		return jsonString;
	}
	
	/**
	 * 업데이트
	 * @param inVO
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/comments/doUpdate.do
	 */
	@RequestMapping(value = "/doUpdate.do"
			   , method = RequestMethod.POST            //textarea post로
			   , produces = "text/plain;charset=UTF-8") //json encoding 
	@ResponseBody //json으로 리턴하기 위한
	public String doUpdate(Comments inVO) throws SQLException {
		
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		int flag = commentsService.doUpdate(inVO);
		log.debug("2.flag:" + flag);
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 수정 되었습니다.";
		}else {
			message = inVO.getUserId() + "수정 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	/**
	 * 단건 삭제
	 * @param inVO
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/comments/doDelete.do
	 */
	@RequestMapping(value = "/doDelete.do"
	    	, method = RequestMethod.GET
	        , produces = "text/plain;charset=UTF-8"
	        ) //produces : 화면으로 전송 encoding)
	@ResponseBody
	public String doDelete(Comments inVO) throws SQLException {
		String jsonString = "";
		log.debug("1.param:" + inVO);
		
		int flag = commentsService.doDelete(inVO);
		
		log.debug("1.flag:" + flag);
		String message = "";
		
		if(1 == flag) {
			message = inVO.getSeq() + "이 삭제 되었습니다.";
		}else {
			message = inVO.getSeq() + "삭제 실패 되었습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
		
	}
	
	/**
	 * 단건 조회
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/comments/doSelectOne.do
	 */
	@RequestMapping(value = "/doSelectOne.do"
			, method = RequestMethod.GET
			, produces = "text/plain;charset=UTF-8") 
	public String doSelectOne(Comments inVO, Model model) throws SQLException {
		String viewName = "board/board_main";
		String jsonString = "";
		log.debug("1.param inVO :" + inVO);
		
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		Comments outVO = commentsService.doSelectOne(inVO);
		
		log.debug("2.outVO :" + outVO);
		
		String message = "";
		int flag = 0;
		if(null != outVO) {
			message = outVO.getUserId() + "이 조회 되었습니다.";
			flag = 1;
		}else {
			message = outVO.getUserId() + "조회 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		
		model.addAttribute("board", outVO);
		model.addAttribute("message", message);
		
		return viewName;
	}
	
	/**
	 * 단건 등록
	 * @param user
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/comments/doSave.do
	 */
	@RequestMapping(value = "/doSave.do"
				   , method = RequestMethod.POST
				   , produces = "text/plain;charset=UTF-8"
				   ) //produces : 화면으로 전송 encoding
	@ResponseBody
	public String doSave(Comments inVO) throws SQLException {
		String jsonString = "";
		log.debug("1.param inVO:" + inVO);
		
		int flag = commentsService.doSave(inVO);
		log.debug("2.flag:" + flag);
		
		String message = "";
		if(1 == flag) {
			message = inVO.getUserId() + "님이 등록 되었습니다.";
		}else {
			message = inVO.getUserId() + "님 등록 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		//json 출력을 가지런하게!
		jsonString = new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
		
		log.debug("3.jsonString:" + jsonString);
		
		return jsonString;
	}
	

}
