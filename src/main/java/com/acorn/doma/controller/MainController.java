package com.acorn.doma.controller;

import java.io.IOException;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Code;
import com.acorn.doma.domain.Point;
import com.acorn.doma.service.AccInfoService;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.acorn.doma.service.FreezingService;
import com.acorn.doma.service.MarkdownService;
import com.acorn.doma.service.PointService;

@Controller
@RequestMapping("main")
public class MainController implements PLog {

	@Autowired
	AccInfoService accInfoService;
	
	@Autowired
	BoardService boardService;

	@Autowired
	MarkdownService markdownService;

	@Autowired
	CodeService codeService;
	
	public MainController() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ MainController()             │");
		log.debug("└──────────────────────────────┘");
	}
	
	//http://localhost:8080/doma/main/emergency.do
	@RequestMapping(value="/main.do"
					,method=RequestMethod.GET
					,produces = "text/plain;charset=UTF-8")
	public String emergency(Model model) throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ main()                       │");
		log.debug("└──────────────────────────────┘");
		
		String viewName = "main/main_emergency_info";

		List<Accident> accList = accInfoService.fullTableScan();
		
		model.addAttribute("accList", accList);
		
		List<Accident> A01List = accInfoService.A01Retrieve();
		model.addAttribute("A01List", A01List);
		List<Accident> A02List = accInfoService.A02Retrieve();
		model.addAttribute("A02List", A02List);
		List<Accident> A04List = accInfoService.A04Retrieve();
		model.addAttribute("A04List", A04List);
		List<Accident> A10List = accInfoService.A10Retrieve();
		model.addAttribute("A10List", A10List);
		List<Accident> A11List = accInfoService.A11Retrieve();
		model.addAttribute("A11List", A11List);
		return viewName;
	}
	@RequestMapping(value = "/IdSelect.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String accIdSelect(@RequestParam("accId") String accId, Model model) throws SQLException {
		String viewName = "main/main_emergency_info";
	    Accident accident = new Accident();
	    accident.setAccId(accId);
	    Accident accIdSelect = accInfoService.doSelectOne(accident);
	    log.debug("accIdSelect: "+accIdSelect);
	    model.addAttribute("accIdSelect", accIdSelect);
	    return viewName;
	}
	
	@RequestMapping(value = "/boardInfo.do"
			, method = RequestMethod.GET
			, produces = "text/plain;charset=UTF-8")  
	public String MyPage(HttpSession session,Model model,Board inVO)throws Exception {
		String viewName = "/board/board_main";
		String jsonString = "";
		log.debug("1.param inVO :" + inVO);
		
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), "admin"));
		
		Board outVO = boardService.doSelectOne(inVO);
		
		//markdown으로 contents변경
		String markdownContents = this.markdownService.convertMarkdownToHtml(outVO.getContent());
		
		log.debug("2.outVO :" + outVO);
		
		String message = "";
		int flag = 0;
		if(null != outVO) {
			message = outVO.getTitle() + "이 조회 되었습니다.";
			flag = 1;
		}else {
			message = outVO.getTitle() + "조회 실패 했습니다.";
		}
		
		Message messageObj = new Message(flag, message);
		
		model.addAttribute("markdownContents", markdownContents);
		model.addAttribute("board", outVO);
		model.addAttribute("message", message);
		
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	
	/**
	 * 수정페이지 이동
	 * @param inVO
	 * @param model
	 * @return
	 * @throws SQLException
	 * http://localhost:8080/doma/board/moveToReg.do
	 */
	@RequestMapping(value = "/moveToUp.do"
			   , method = RequestMethod.GET)
	public String moveToUp(HttpSession session,Model model,Board inVO) throws SQLException {
		String viewName = "board/board_mng";
		
		//TODO : SESSION처리
		inVO.setUserId(StringUtil.nvl(inVO.getUserId(), ""));
		
		Board outVO = boardService.doSelectOne(inVO);
		
		log.debug("1.param inVO:" + inVO);
		model.addAttribute("board", inVO);
		
		//reg 구선택--------------------------------------------------------
		Search search = new Search();
		
		List<Board> list = this.boardService.doRetrieve(search);
		
		//2.화면 전송 데이터
		//조회 데이터
		model.addAttribute("list", list);
		
		//검색 조건
		model.addAttribute("search", search);
		
		//페이징 : totalCnt
		int totalCnt = 0;
		if(null != list && list.size() > 0) {
			Board firstVO = list.get(0);
			totalCnt = firstVO.getTotalCnt();
		}
		//검색 조건
		model.addAttribute("totalCnt", totalCnt);
		
		//----------------------------------------------------------------------
		Code code = new Code();
		//GNAME : 구이름
		code.setMstCode("GNAME");
		List<Code> gname = this.codeService.doRetrieve(code);
		model.addAttribute("GNAME", gname); //구이름
		//----------------------------------------------------------------------
		
		return viewName;
	}
	

}
