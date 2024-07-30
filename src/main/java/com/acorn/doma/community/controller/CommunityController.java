package com.acorn.doma.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("community")
public class CommunityController {
	
	@GetMapping("/community.do")
	public String communityPage(Model model) throws Exception {
		String viewName = "/join/community_page";
		
		return viewName;
	}
}
