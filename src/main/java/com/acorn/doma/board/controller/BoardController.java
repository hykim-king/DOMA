package com.acorn.doma.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.acorn.doma.cmn.PLog;

@Controller
@RequestMapping("board")
public class BoardController implements PLog {
	
	public BoardController() {
		log.debug("┌───────────────────────────┐");
		log.debug("│ BoardController()         │");
		log.debug("└───────────────────────────┘");
	}
	
	//http://localhost:8080/doma//board/board.do
	@GetMapping("/board.do")
	public String communityPage(Model model) throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ communityPage()           │");
		log.debug("└───────────────────────────┘");
		String viewName = "/board/board_list";
		
		return viewName;
	}

}
