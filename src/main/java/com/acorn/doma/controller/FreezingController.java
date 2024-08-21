package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Freezing;
import com.acorn.doma.service.FreezingService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	@RequestMapping(value="/yearSelect.do"
			,method=RequestMethod.GET
			,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String yearSelect(@RequestParam("year") String year) throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ yearSelect()                 │");
		log.debug("└──────────────────────────────┘");
		 List<Freezing> inVO = freezingService.selectPolyByYear(year);
		 // ObjectMapper를 사용해 리스트를 JSON 문자열로 변환
	    ObjectMapper objectMapper = new ObjectMapper();
	    String jsonString = "";
	    try {
	        jsonString = objectMapper.writeValueAsString(inVO);
	    } catch (JsonProcessingException e) {
	        log.error("Error converting to JSON", e);
	    }
		return jsonString;
	}
	@RequestMapping(value="/allYearsSelect.do"
			,method=RequestMethod.GET
			,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String allYear() throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ allYear()                    │");
		log.debug("└──────────────────────────────┘");
		List<Freezing> inVO = freezingService.selectPolyAll();
		 // ObjectMapper를 사용해 리스트를 JSON 문자열로 변환
	    ObjectMapper objectMapper = new ObjectMapper();
	    String jsonString = "";
	    try {
	        jsonString = objectMapper.writeValueAsString(inVO);
	    } catch (JsonProcessingException e) {
	        log.error("Error converting to JSON", e);
	    }
		return jsonString;
	}
		
}
