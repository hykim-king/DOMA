package com.acorn.doma.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.acorn.doma.cmn.PLog;

@Controller
@RequestMapping("template")

public class BootStrapController implements PLog {
   
   public BootStrapController() {
      log.debug("┌──────────────────────────────────────────┐");
      log.debug("│ BootStrapController()                    │");
      log.debug("└──────────────────────────────────────────┘");   
   }  
   
   
   @GetMapping("footer.do")
   public String footer() {
      String viewName = "template/footer";
      
      log.debug("┌──────────────────────────────────────────┐");
      log.debug("│ viewName:"+viewName);                                 
      log.debug("└──────────────────────────────────────────┘");
      
      return viewName;
   }
   
   @GetMapping("header.do")
   public String header() {
      String viewName = "template/header";
      
      log.debug("┌──────────────────────────────────────────┐");
      log.debug("│ viewName:"+viewName);                                 
      log.debug("└──────────────────────────────────────────┘");
      
      return viewName;
   }
}
