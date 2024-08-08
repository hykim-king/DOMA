package com.acorn.doma.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.domain.Point;
import com.acorn.doma.service.AccInfoService;
import com.acorn.doma.service.FreezingService;
import com.acorn.doma.service.PointService;

@Controller
@RequestMapping("main")
public class MainController implements PLog {

	@Autowired
	AccInfoService accInfoService;
	
	
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
		List<Accident> A11List = accInfoService.A11Retrieve();
		model.addAttribute("A11List", A11List);
		return viewName;
	}
	@RequestMapping(value = "/accIdSelect.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String accIdSelect(@RequestParam("accId") String accId, Model model) throws SQLException {
	    Accident accident = new Accident();
	    accident.setAccId(accId);
	    Accident accIdSelect = accInfoService.doSelectOne(accident);
	    model.addAttribute("accIdSelect", accIdSelect);
	    return "main/main_emergency_info_detail";  // Thymeleaf fragment 방식으로 특정 영역만 업데이트
	}
	

}
