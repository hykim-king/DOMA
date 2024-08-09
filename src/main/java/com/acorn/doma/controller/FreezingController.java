package com.acorn.doma.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Freezing;
import com.acorn.doma.domain.Point;
import com.acorn.doma.service.FreezingService;
import com.acorn.doma.service.PointService;

@Controller
@RequestMapping("freezing")
public class FreezingController implements PLog{

	@Autowired
	FreezingService freezingService;
	
	public FreezingController() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ FreezingController()         │");
		log.debug("└──────────────────────────────┘");
	}
	@RequestMapping(value="/freezing.do"
			,method=RequestMethod.GET
			,produces = "text/plain;charset=UTF-8")
	public String freezing(Model model) throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ freezingMain()               │");
		log.debug("└──────────────────────────────┘");
		
		String viewName = "main/main_freezing_info";
		List<Freezing> allData = freezingService.selectAllData();
		model.addAttribute("allData", allData);
		return viewName;
	}
		
}
