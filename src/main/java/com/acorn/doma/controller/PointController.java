package com.acorn.doma.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Point;
import com.acorn.doma.service.PointService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
@RequestMapping("point")
public class PointController implements PLog{

	@Autowired
	PointService pointService;
	
	public PointController() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ PointController()            │");
		log.debug("└──────────────────────────────┘");
	}
	
	@RequestMapping(value="/point.do"
			,method=RequestMethod.GET
			,produces = "text/plain;charset=UTF-8")
	public String point(Model model) throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ PointController : point()    │");
		log.debug("└──────────────────────────────┘");
		
		String viewName = "main/main_occur_info2";
		List<Point> listPoint = pointService.fullTableScan();
		
		model.addAttribute("pointData", listPoint);
		
		return viewName;
	}
	
	@RequestMapping(value="/guListLoad.do"
			,method=RequestMethod.POST
			,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String guListLoad(Model model,String year) throws Exception{
		log.debug("┌───────────────────────────────────┐");
		log.debug("│ PointController : guListLoad()	   │");
		log.debug("└───────────────────────────────────┘");
		
		List<String> guList = pointService.guLoad(year);
		Gson gson = new Gson();
		String jsonString = gson.toJson(guList);
		
		return jsonString;
	}
	
	@RequestMapping(value="/pointDetail.do"
			,method=RequestMethod.GET
			,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String pointDetailInfo(Point inVO) throws Exception {
		log.debug("┌─────────────────────────────────────┐");
		log.debug("│ PointController : pointDetailInfo() │");
		log.debug("└─────────────────────────────────────┘");
		
		
		List<Point> listPoint = pointService.detailInfoLoad(inVO);
		Gson gson = new Gson();
		String jsonString = gson.toJson(listPoint);
		return jsonString;
	}
	@RequestMapping(value = "/yearguSelect.do", 
			method = RequestMethod.GET,
			produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getPointsByYearAndGu(
	        @RequestParam("year") int year,
	        @RequestParam("guList") String guList) {
	    // 콤마로 구분된 구 리스트를 분리하여 리스트로 변환
	    List<String> guListParsed = Arrays.asList(guList.split(","));
	    
	    List<Point> ygData = pointService.databyYearAndGu(year, guListParsed);
	    String jsonString = "";
	    ObjectMapper objectMapper = new ObjectMapper();
	    try {
	        jsonString = objectMapper.writeValueAsString(ygData);
	    } catch (JsonProcessingException e) {
	        log.error("Error converting to JSON", e);
	    }
	    return jsonString;
	}
}
