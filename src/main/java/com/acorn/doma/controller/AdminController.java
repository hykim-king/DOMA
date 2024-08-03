package com.acorn.doma.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.acorn.doma.cmn.PLog;

@Controller
@RequestMapping("admin")
public class AdminController implements PLog {

   public AdminController() {
      log.debug("┌──────────────────────────────────────────┐");
      log.debug("│ AdminController()                      │");
      log.debug("└──────────────────────────────────────────┘");   
   }

   @GetMapping("adminuser.do")
   public String userManagement() {
      String viewName = "admin/admin_user";
      
      log.debug("┌──────────────────────────────────────────┐");
      log.debug("│ viewName: " + viewName);                                 
      log.debug("└──────────────────────────────────────────┘");
      
      return viewName;
   }

   @GetMapping("adminnotice.do")
   public String noticeManagement() {
      String viewName = "admin/admin_notice";
      
      log.debug("┌──────────────────────────────────────────┐");
      log.debug("│ viewName: " + viewName);                                 
      log.debug("└──────────────────────────────────────────┘");
      
      return viewName;
   }
}
