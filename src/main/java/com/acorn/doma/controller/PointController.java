package com.acorn.doma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Point;
import com.acorn.doma.service.PointService;
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
		
		String viewName = "main/main_occur_info";
		
		List<Point> listPoint = pointService.fullTableScan();
		
		log.debug("┌ list ┐");
		for(Point point : listPoint) {
			log.debug("│ point : " + point);
		}
		log.debug("└");
		
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
		
		log.debug("┌ list ┐");
		for(String gu : guList) {
			log.debug("│ gu : " + gu);
		}
		log.debug("└");
		
		Gson gson = new Gson();
		String jsonString = gson.toJson(guList);
		
		return jsonString;
	}
	
	@RequestMapping(value="/pointDetail.do"
			,method=RequestMethod.POST
			,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String pointDetailInfo(Point inVO) throws Exception {
		log.debug("┌─────────────────────────────────────┐");
		log.debug("│ PointController : pointDetailInfo() │");
		log.debug("└─────────────────────────────────────┘");
		
		log.debug("inVO : " + inVO);
		
		List<Point> listPoint = pointService.detailInfoLoad(inVO);
		
		log.debug("┌ list ┐");
		for(Point point : listPoint) {
			log.debug("│ point : " + point);
		}
		log.debug("└");
		
		Gson gson = new Gson();
		
		String jsonString = gson.toJson(listPoint);
		
		return jsonString;
	}
}
