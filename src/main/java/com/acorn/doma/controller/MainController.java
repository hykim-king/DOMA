package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.service.AccInfoService;

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
	
	//http://localhost:8080/doma/main/main.do
	@RequestMapping(value="/main.do"
					,method=RequestMethod.GET
					,produces = "text/plain;charset=UTF-8")
	public String main(Model model) throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ main()                       │");
		log.debug("└──────────────────────────────┘");
		
		String viewName = "main/main_emergency_info";

		List<Accident> accList = accInfoService.fullTableScan();
		model.addAttribute("accList", accList);
		
		return viewName;
	}
	
}
