package com.acorn.doma.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.sql.SQLException;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import org.junit.Assert;
import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Admin;
import com.acorn.doma.mapper.AdminMapper;
import com.acorn.doma.cmn.Search;

@RunWith(SpringRunner.class)
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class AdminMapperTest implements PLog {

    @Autowired
    ApplicationContext context;
    
    @Autowired
    AdminMapper adminMapper;
    
    Admin admin01;
    Admin admin02;
    Admin admin03;
    
    Search search;
    
    @Before
    public void setUp() throws Exception {
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        LocalDate currentDate = LocalDate.now();
        String currentDateString = formatDate(currentDate);

        admin01 = new Admin(
            1, "20", "제목_01", "admin01", "admin01", "내용_01", "img_link_01", 
            currentDateString, currentDateString, 0, "구_01", 
            "admin01", "password", "user01@example.com", "1990-01-01", 
            0, "서울 서대문구", "101호", "2024-01-01"
        );

        admin02 = new Admin(
            2, "20", "제목_02", "admin02", "admin02", "내용_02", "img_link_02", 
            currentDateString, currentDateString, 0, "구_02", 
            "admin02", "password", "user02@example.com", "1992-02-02", 
            0, "서울 서대문구", "102호", "2024-02-02"
        );

        admin03 = new Admin(
            3, "20", "제목_03", "admin03", "admin03", "내용_03", "img_link_03", 
            currentDateString, currentDateString, 0, "구_03", 
            "admin03", "password", "user03@example.com", "1994-03-03", 
            0, "서울 서대문구", "103호", "2024-03-03"
        );

        search = new Search();
    }

    @After
    public void tearDown() throws Exception {
        // Optional cleanup code
    }

    private String formatDate(LocalDate date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return date.format(formatter);
    }

    private LocalDate parseDateString(String dateString) {
        if (dateString == null || dateString.trim().isEmpty()) {
            return null;
        }
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return LocalDate.parse(dateString, formatter);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Failed to parse date string: " + dateString, e);
        }
    }

    private void isSameAdmin(Admin expected, Admin actual) {
        LocalDate expectedBoardRegDate = parseDateString(expected.getBoardRegDt().split(" ")[0]);
        LocalDate actualBoardRegDate = parseDateString(actual.getBoardRegDt().split(" ")[0]);
        assertEquals(expectedBoardRegDate, actualBoardRegDate);

        LocalDate expectedModDate = parseDateString(expected.getModDt().split(" ")[0]);
        LocalDate actualModDate = parseDateString(actual.getModDt().split(" ")[0]);
        assertEquals(expectedModDate, actualModDate);

        LocalDate expectedUserRegDate = parseDateString(expected.getUserRegDt().split(" ")[0]);
        LocalDate actualUserRegDate = parseDateString(actual.getUserRegDt().split(" ")[0]);
        assertEquals(expectedUserRegDate, actualUserRegDate);

        
        assertEquals(expected.getSeq(), actual.getSeq());
        assertEquals(expected.getDiv(), actual.getDiv());
        assertEquals(expected.getTitle(), actual.getTitle());
        assertEquals(expected.getUserId(), actual.getUserId());
        assertEquals(expected.getModId(), actual.getModId());
        assertEquals(expected.getContent(), actual.getContent());
        assertEquals(expected.getImgLink(), actual.getImgLink());
        assertEquals(expected.getViews(), actual.getViews());
        assertEquals(expected.getGname(), actual.getGname());
        assertEquals(expected.getUserName(), actual.getUserName());
        assertEquals(expected.getUserPw(), actual.getUserPw());
        assertEquals(expected.getUserEmail(), actual.getUserEmail());
        assertEquals(expected.getUserBirth(), actual.getUserBirth());
        assertEquals(expected.getUserGrade(), actual.getUserGrade());
        assertEquals(expected.getUserAddress(), actual.getUserAddress());
        assertEquals(expected.getUserDetailAddress(), actual.getUserDetailAddress());
    }

    @Test
    public void addAndGet() throws Exception {
        // 공지사항 등록 테스트
        int flag = adminMapper.insertNotice(admin01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        
        int generatedSeq = adminMapper.getLastInsertedSeq();
        admin01.setSeq(generatedSeq);
        log.debug("Generated SEQ : " + generatedSeq);

        // 단건 조회 테스트
        Admin outAdmin01 = adminMapper.getNoticeById(generatedSeq);
        log.debug("outAdmin01 : " + outAdmin01);
        
        assertNotNull(outAdmin01);
        isSameAdmin(admin01, outAdmin01);
        
        // 공지사항 수정 테스트
        String updateStr = "_U";
        outAdmin01.setTitle(outAdmin01.getTitle() + updateStr);
        outAdmin01.setModId(outAdmin01.getModId() + updateStr);
        outAdmin01.setContent(outAdmin01.getContent() + updateStr);

        flag = adminMapper.updateNotice(outAdmin01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        Admin outAdmin01Update = adminMapper.getNoticeById(outAdmin01.getSeq());
        log.debug("outAdmin01Update : " + outAdmin01Update);
        assertNotNull(outAdmin01Update);
        isSameAdmin(outAdmin01Update, outAdmin01);

        // 공지사항 삭제 테스트
        flag = adminMapper.deleteNotice(outAdmin01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);
    }


    @Test
    public void doRetrieve() throws SQLException {
        // 공지사항 목록 조회 테스트
        search.setDiv("20");
        search.setSearchWord("제목");

        List<Admin> list = adminMapper.getNotices(search);
        assertNotNull(list);
    }

    @Test
    public void beans() {
        log.debug("┌──────────────────────────────┐");
        log.debug("│ beans()                      │");
        log.debug("└──────────────────────────────┘");
        log.debug("context:" + context);
        log.debug("adminMapper:" + adminMapper);

        assertNotNull(context);
        assertNotNull(adminMapper);
    }

 
    @Test
    public void testUserRetrieve() throws SQLException {
        // 1. 회원 등록 테스트
        Admin existingUser = adminMapper.getUser(admin02.getUserId());
        if (existingUser != null) {
            adminMapper.deleteUser(existingUser);
        }

        // 회원 등록
        int insertFlag = adminMapper.insertUser(admin02);
        log.debug("User Inserted : " + insertFlag);
        assertEquals(1, insertFlag);

        // 2. 전체 회원 목록 조회 테스트
        Search search = new Search(); // 기본값으로 전체 조회
        List<Admin> userList = adminMapper.getUsers(search);
        log.debug("userList : " + userList);

        assertNotNull(userList);
        assertTrue(userList.stream().anyMatch(user -> "admin02".equals(user.getUserId())));

        // 3. 회원 단건 조회 테스트
        Admin retrievedUser = adminMapper.getUser("admin02");
        log.debug("retrievedUser : " + retrievedUser);
        assertNotNull(retrievedUser);
        assertEquals("admin02", retrievedUser.getUserId());

        // 4. 회원 수정 테스트
        retrievedUser.setUserName("Updated User");
        int updateFlag = adminMapper.updateUser(retrievedUser);
        log.debug("Updated : " + updateFlag);
        assertEquals(1, updateFlag);

        // 5. 수정된 회원 조회 테스트
        Admin updatedUser = adminMapper.getUser("admin02");
        log.debug("updatedUser : " + updatedUser);
        assertNotNull(updatedUser);
        assertEquals("admin02", updatedUser.getUserId());
        assertEquals("Updated User", updatedUser.getUserName());

        // 6. 회원 삭제 테스트
        int deleteFlag = adminMapper.deleteUser(updatedUser);
        log.debug("deleteFlag : " + deleteFlag);
        assertEquals(1, deleteFlag);
    }




}
