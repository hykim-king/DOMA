package com.acorn.doma.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Point;
import com.acorn.doma.service.PointService;

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
		log.debug("│ point()               		  │");
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
}
