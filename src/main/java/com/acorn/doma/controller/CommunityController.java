package com.acorn.doma.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.acorn.doma.cmn.PLog;

@Controller
@RequestMapping("community")
public class CommunityController implements PLog{
	
	public CommunityController() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ CommunityController()     │");
		log.debug("└───────────────────────────┘");
	}
	
	@GetMapping("/community.do")
	public String communityPage(Model model) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ communityPage()           │");
		log.debug("└───────────────────────────┘");
		String viewName = "/join/community_page";
		
		return viewName;
	}
}
