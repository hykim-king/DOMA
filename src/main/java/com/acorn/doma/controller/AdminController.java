package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

    //공지사항 노출
    @RequestMapping(value = "/doRetrieveNotices.do", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> doRetrieveNotices(
            @RequestParam Map<String, String> params, HttpSession httpSession ) throws SQLException {

        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doRetrieveNotices()                    │");
        log.debug("└──────────────────────────────────────────────┘");
        
        Search search = new Search();

        // 검색 조건 처리
        String searchWord = StringUtil.nvl(params.get("searchWord"), "");
        search.setSearchWord(searchWord);

        // 페이지 크기 및 페이지 번호 설정
        String pageSize = StringUtil.nvl(params.get("pageSize"), "5");
        String pageNo = StringUtil.nvl(params.get("pageNo"), "1");

        search.setPageSize(Integer.parseInt(pageSize));
        search.setPageNo(Integer.parseInt(pageNo));

        List<Admin> notices = adminService.getNotices(search);
        int totalCount = adminService.getNoticeCount(search);


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

    
    //게시글 상세 정보 조회
    @RequestMapping(value = "/getNoticeById.do", method = RequestMethod.GET)
    public @ResponseBody Admin getNoticeById(@RequestParam("seq") int seq) throws SQLException {

        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_getNoticeById()                      │");
        log.debug("└──────────────────────────────────────────────┘");

        // 게시글 상세 정보 조회
        Admin notice = adminService.getNoticeById(seq);

        log.debug("Notice Retrieved: " + notice);

        return notice;  // JSON 형식으로 반환
    }

    // 공지사항 등록
    @PostMapping("/addNotice.do")
    public @ResponseBody Map<String, Object> addNotice(@RequestBody Admin notice, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        HttpSession session = request.getSession();
        try {
            // 세션에서 userId 가져오기, 없으면 기본값 'admin' 설정
            String userId = (String) session.getAttribute("userId");
            userId = StringUtil.nvl(userId, "admin");

            // notice 객체에 userId 설정
            notice.setUserId(userId);

            // 공지사항 등록
            int result = adminService.insertNotice(notice);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "Notice added successfully.");
            } else {
                response.put("status", "error");
                response.put("message", "Failed to add notice.");
            }
        } catch (Exception e) {
            log.error("Error adding notice", e);
            response.put("status", "error");
            response.put("message", "Failed to add notice.");
        }
        return response;
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

    //공지사항 끝, 회원시작-----------------------------------------------------------
    
    
    
    //회원 목록 노출
    @RequestMapping(value = "/doRetrieveUsers.do", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> doRetrieveUsers(
            @RequestParam Map<String, String> params, HttpSession httpSession) throws SQLException {

        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doRetrieveUsers()                    │");
        log.debug("└──────────────────────────────────────────────┘");
        
        Search search = new Search();

        // 페이지 크기 및 페이지 번호 설정 (기본값 사용)
        String pageSize = StringUtil.nvl(params.get("pageSize"), "5");
        String pageNo = StringUtil.nvl(params.get("pageNo"), "1");

        search.setPageSize(Integer.parseInt(pageSize));
        search.setPageNo(Integer.parseInt(pageNo));

        List<Admin> users = adminService.getUsers(search);

        log.debug("Search Parameters: " + search);
        log.debug("Users Retrieved: " + users);

        Map<String, Object> result = new HashMap<>();
        result.put("users", users);
        result.put("pageSize", search.getPageSize());
        result.put("pageNo", search.getPageNo());

        return result;  // JSON 형식으로 반환
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