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
import com.google.gson.GsonBuilder;

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
		List<Accident> A03List = accInfoService.A03Retrieve();
		model.addAttribute("A03List", A03List);
		List<Accident> A04List = accInfoService.A04Retrieve();
		model.addAttribute("A04List", A04List);
		List<Accident> A05List = accInfoService.A05Retrieve();
		model.addAttribute("A05List", A05List);
		List<Accident> A06List = accInfoService.A06Retrieve();
		model.addAttribute("A06List", A06List);
		List<Accident> A07List = accInfoService.A07Retrieve();
		model.addAttribute("A07List", A07List);
		List<Accident> A08List = accInfoService.A08Retrieve();
		model.addAttribute("A08List", A08List);
		List<Accident> A09List = accInfoService.A09Retrieve();
		model.addAttribute("A09List", A09List);
		List<Accident> A10List = accInfoService.A10Retrieve();
		model.addAttribute("A10List", A10List);
		List<Accident> A11List = accInfoService.A11Retrieve();
		model.addAttribute("A11List", A11List);
		List<Accident> A12List = accInfoService.A12Retrieve();
		model.addAttribute("A12List", A12List);
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
	@GetMapping("/guide.do")
	public String guidePage() {
		String viewName = "/guide/guide"; // JSP 페이지 경로
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ viewName: " + viewName);
		log.debug("└──────────────────────────────────────────┘");
		return viewName;
	}
	

}
