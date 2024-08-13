package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Admin;
import com.acorn.doma.service.AdminService;
import com.google.gson.GsonBuilder;
import com.acorn.doma.cmn.Message;

@Controller
@RequestMapping("admin")
public class AdminController implements PLog {

    @Autowired
    AdminService adminService;

    public AdminController() {
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ AdminController()                        │");
        log.debug("└──────────────────────────────────────────┘");
    }

    // 공지사항 목록 페이지 이동
    @GetMapping("/adminnotice.do")
    public String noticeManagement() {
        String viewName = "admin/admin_notice";

        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                 
        log.debug("└──────────────────────────────────────────┘");

        return viewName;
    }


    // 회원 관리 페이지 이동
    @GetMapping("/adminuser.do")
    public String userManagement() {
        String viewName = "admin/admin_user";

        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                 
        log.debug("└──────────────────────────────────────────┘");

        return viewName;
    }

    @RequestMapping(value = "/doRetrieveNotices.do", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> doRetrieveNotices(
            @RequestParam Map<String, String> params) throws SQLException {

        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doRetrieveNotices()                    │");
        log.debug("└──────────────────────────────────────────────┘");

        Search search = new Search();

        // 검색 조건 처리
        String searchWord = StringUtil.nvl(params.get("searchWord"), "");
        search.setSearchWord(searchWord);

        // 페이지 크기 및 페이지 번호 설정
        String pageSize = StringUtil.nvl(params.get("pageSize"), "6");
        String pageNo = StringUtil.nvl(params.get("pageNo"), "1");

        search.setPageSize(Integer.parseInt(pageSize));
        search.setPageNo(Integer.parseInt(pageNo));

        List<Admin> notices = adminService.getNotices(search);
        int totalCount = adminService.getNoticeCount(search);

        // 로그 추가
        log.debug("Search Parameters: " + search);
        log.debug("Notices Retrieved: " + notices);
        log.debug("Total Count: " + totalCount);

        Map<String, Object> result = new HashMap<>();
        result.put("notices", notices);
        result.put("totalCount", totalCount);
        result.put("pageSize", search.getPageSize());
        result.put("pageNo", search.getPageNo());

        return result;  // JSON 형식으로 반환
    }















    // 공지사항 등록
    @PostMapping("/doInsertNotice.do")
    @ResponseBody
    public String doInsertNotice(Admin admin) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doInsertNotice()                       │");
        log.debug("└──────────────────────────────────────────────┘");

        int result = adminService.insertNotice(admin);
        String message = result == 1 ? "공지사항이 등록되었습니다." : "공지사항 등록에 실패했습니다.";

        Message messageObj = new Message(result, message);
        return new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
    }

    // 공지사항 수정
    @PostMapping("/doUpdateNotice.do")
    @ResponseBody
    public String doUpdateNotice(Admin admin) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doUpdateNotice()                       │");
        log.debug("└──────────────────────────────────────────────┘");

        int result = adminService.updateNotice(admin);
        String message = result == 1 ? "공지사항이 수정되었습니다." : "공지사항 수정에 실패했습니다.";

        Message messageObj = new Message(result, message);
        return new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
    }

    // 공지사항 삭제
    @PostMapping("/doDeleteNotice.do")
    @ResponseBody
    public String doDeleteNotice(@RequestParam("seq") int seq) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doDeleteNotice()                       │");
        log.debug("└──────────────────────────────────────────────┘");

        Admin admin = new Admin();
        admin.setSeq(seq);
        int result = adminService.deleteNotice(admin);
        String message = result == 1 ? "공지사항이 삭제되었습니다." : "공지사항 삭제에 실패했습니다.";

        Message messageObj = new Message(result, message);
        return new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
    }

    // 회원 목록 조회
    @RequestMapping(value = "/doRetrieveUsers.do", method = RequestMethod.GET)
    public String doRetrieveUsers(Model model, HttpServletRequest req) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doRetrieveUsers()                      │");
        log.debug("└──────────────────────────────────────────────┘");

        String viewName = "admin/admin_user";
        Search search = new Search();

        // 검색 조건 처리
        String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"), "");
        String searchWord = StringUtil.nvl(req.getParameter("searchWord"), "");

        search.setSearchDiv(searchDiv);
        search.setSearchWord(searchWord);

        // 페이지 크기 및 페이지 번호 설정
        String pageSize = StringUtil.nvl(req.getParameter("pageSize"), "10");
        String pageNo = StringUtil.nvl(req.getParameter("pageNo"), "1");

        search.setPageSize(Integer.parseInt(pageSize));
        search.setPageNo(Integer.parseInt(pageNo));

        List<Admin> users = adminService.getUsers(search);
        model.addAttribute("users", users);
        model.addAttribute("search", search);

        // 총 개수 처리
        int totalCnt = users.size() > 0 ? users.get(0).getTotalCnt() : 0;
        model.addAttribute("totalCnt", totalCnt);

        return viewName;
    }

    // 회원 등록
    @PostMapping("/doInsertUser.do")
    @ResponseBody
    public String doInsertUser(Admin admin) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doInsertUser()                         │");
        log.debug("└──────────────────────────────────────────────┘");

        int result = adminService.insertUser(admin);
        String message = result == 1 ? "회원이 등록되었습니다." : "회원 등록에 실패했습니다.";

        Message messageObj = new Message(result, message);
        return new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
    }

    // 회원 수정
    @PostMapping("/doUpdateUser.do")
    @ResponseBody
    public String doUpdateUser(Admin admin) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doUpdateUser()                         │");
        log.debug("└──────────────────────────────────────────────┘");

        int result = adminService.updateUser(admin);
        String message = result == 1 ? "회원이 수정되었습니다." : "회원 수정에 실패했습니다.";

        Message messageObj = new Message(result, message);
        return new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
    }

    // 회원 삭제
    @PostMapping("/doDeleteUser.do")
    @ResponseBody
    public String doDeleteUser(@RequestParam("userId") String userId) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doDeleteUser()                         │");
        log.debug("└──────────────────────────────────────────────┘");

        Admin admin = new Admin();
        admin.setUserId(userId);
        int result = adminService.deleteUser(admin);
        String message = result == 1 ? "회원이 삭제되었습니다." : "회원 삭제에 실패했습니다.";

        Message messageObj = new Message(result, message);
        return new GsonBuilder().setPrettyPrinting().create().toJson(messageObj);
    }

    // 단건 조회 (회원 또는 공지사항)
    @GetMapping("/doSelectNotice.do")
    public String doSelectNotice(@RequestParam("seq") int seq, Model model) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doSelectNotice()                       │");
        log.debug("└──────────────────────────────────────────────┘");

        Admin admin = adminService.getNoticeById(seq);
        model.addAttribute("admin", admin);

        return "admin/admin_notice_detail";
    }

    @GetMapping("/doSelectUser.do")
    public String doSelectUser(@RequestParam("userId") String userId, Model model) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doSelectUser()                         │");
        log.debug("└──────────────────────────────────────────────┘");

        Admin admin = adminService.getUser(userId);
        model.addAttribute("admin", admin);

        return "admin/admin_user_detail"; //수정예정
    }

}