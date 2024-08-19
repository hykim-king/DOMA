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
import com.acorn.doma.domain.User;
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
    
    @RequestMapping(value = "/checkUserPermission.do", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> checkUserPermission(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.put("status", "error");
                response.put("message", "사용자가 로그인되지 않았습니다.");
                return response;
            }
            
            if (user.getGrade() != 0) {  // 권한 체크: GRADE가 0이 아니면 권한 없음
                response.put("status", "error");
                response.put("message", "권한이 없습니다.");
            } else {
                response.put("status", "success");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "권한 확인 중 오류가 발생했습니다.");
        }
        return response;
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
            // 세션에서 userId 가져오기
            User user = (User) session.getAttribute("user");
            String userId = user.getUserId();
            notice.setUserId(userId);
            notice.setModId(userId);
            //userId = StringUtil.nvl(userId, "admin");

            // notice 객체에 userId 설정
            //notice.setUserId(userId);

            // 공지사항 등록
            int result = adminService.insertNotice(notice);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "공지사항을 등록에 성공했습니다.");
            } else {
                response.put("status", "error");
                response.put("message", "공지사항 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("Error adding notice", e);
            response.put("status", "error");
            response.put("message", "Failed to add notice.");
        }
        return response;
    }
      

    // 공지사항 수정
    @PostMapping("/updateNotice.do")
    public @ResponseBody Map<String, Object> updateNotice(@RequestBody Admin notice, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        HttpSession session = request.getSession();
        
        try {
            // 세션에서 modId 가져오기
            User user = (User) session.getAttribute("user");
            String modId = user.getUserId();
            notice.setModId(modId);

            // 공지사항 수정
            int result = adminService.updateNotice(notice);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "공지사항이 성공적으로 수정되었습니다.");
            } else {
                response.put("status", "error");
                response.put("message", "공지사항 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("Error updating notice", e);
            response.put("status", "error");
            response.put("message", "공지사항 수정 중 오류가 발생했습니다.");
        }
        return response;
    }

    // 공지사항 삭제
    @RequestMapping(value = "/deleteNotice.do", method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String, Object> deleteNotice(@RequestParam("seq") int seq) {
        Map<String, Object> response = new HashMap<>();
        try {
            Admin admin = new Admin();
            admin.setSeq(seq);

            int result = adminService.deleteNotice(admin);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "공지사항이 성공적으로 삭제되었습니다.");
            } else {
                response.put("status", "error");
                response.put("message", "공지사항 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "공지사항 삭제 중 오류가 발생했습니다.");
        }
        return response;
    }




    //공지사항 끝, 회원시작-----------------------------------------------------------
    
    
    
    //회원 목록 노출
    @RequestMapping(value = "/doRetrieveUsers.do", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> doRetrieveUsers(
            @RequestParam Map<String, String> params, HttpSession httpSession) throws SQLException {

        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_doRetrieveUsers()                      │");
        log.debug("└──────────────────────────────────────────────┘");
        
        Search search = new Search();

        // 페이지 크기 및 페이지 번호 설정 (기본값 사용)
        String pageSize = StringUtil.nvl(params.get("pageSize"), "5");
        String pageNo = StringUtil.nvl(params.get("pageNo"), "1");

        search.setPageSize(Integer.parseInt(pageSize));
        search.setPageNo(Integer.parseInt(pageNo));
        String searchWord = (String) params.get("searchWord");
        search.setSearchWord(searchWord);
        List<Admin> users = adminService.getUsers(search);
        int totalCount = adminService.getUsersCount(search);
        log.debug("Search Parameters: " + search);
        log.debug("Users Retrieved: " + users);

        Map<String, Object> result = new HashMap<>();
        result.put("users", users);
        result.put("totalCount", totalCount);
        result.put("pageSize", search.getPageSize());
        result.put("pageNo", search.getPageNo());

        return result;  // JSON 형식으로 반환
    }
    
    //회원 상세 정보 조회
    @RequestMapping(value = "/doSelectUser.do", method = RequestMethod.GET)
    public @ResponseBody Admin getUser(@RequestParam("userId") String userId) throws SQLException {
        log.debug("┌──────────────────────────────────────────────┐");
        log.debug("│ admin_getUser()                            │");
        log.debug("└──────────────────────────────────────────────┘");

        // 회원 상세 정보 조회
        Admin user = adminService.getUser(userId);

        log.debug("User Retrieved: " + user);

        return user;  // JSON 형식으로 반환
    }


    //회원 수정
    @RequestMapping(value = "/updateUser.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> updateUser(@RequestBody Admin user) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 현재 데이터베이스의 값을 가져옵니다.
            Admin existingUser = adminService.getUser(user.getUserId());

            // 데이터베이스의 기존 값과 비교하여 수정된 사항이 있는지 확인
            boolean isUpdated = false;
            if (user.getUserName() != null && !user.getUserName().equals(existingUser.getUserName())) {
                isUpdated = true;
            }
            if (user.getUserBirth() != null && !user.getUserBirth().equals(existingUser.getUserBirth())) {
                isUpdated = true;
            }
            if (user.getUserAddress() != null && !user.getUserAddress().equals(existingUser.getUserAddress())) {
                isUpdated = true;
            }
            if (user.getUserDetailAddress() != null && !user.getUserDetailAddress().equals(existingUser.getUserDetailAddress())) {
                isUpdated = true;
            }

            if (!isUpdated) {
                response.put("status", "error");
                response.put("message", "업데이트 실패 : 수정사항을 입력해주세요.");
                return response;
            }

            // 사용자의 정보를 업데이트합니다.
            int result = adminService.updateUser(user);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "회원 정보가 업데이트되었습니다.");
            } else {
                response.put("status", "error");
                response.put("message", "회원 정보 업데이트에 실패했습니다.");
            }
        } catch (SQLException e) {
            log.error("Error updating user information", e);
            response.put("status", "error");
            response.put("message", "Database error occurred while updating user information.");
        } catch (Exception e) {
            log.error("Unexpected error", e);
            response.put("status", "error");
            response.put("message", "An unexpected error occurred while updating user information.");
        }
        return response;
    }


    //회원 삭제
    @RequestMapping(value = "/deleteUser.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> deleteUser(@RequestParam("userId") String userId) {
        log.debug("Received userId for deletion: " + userId); // userId 디버깅용 로그 추가
        Map<String, Object> response = new HashMap<>();
        
        try {
            Admin admin = new Admin();
            admin.setUserId(userId);

            int result = adminService.deleteUser(admin);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "User deleted successfully.");
            } else {
                response.put("status", "error");
                response.put("message", "Failed to delete user.");
            }
        } catch (Exception e) {
            log.error("Error deleting user", e);
            response.put("status", "error");
            response.put("message", "Error deleting user.");
        }
        
        return response;
    }






}