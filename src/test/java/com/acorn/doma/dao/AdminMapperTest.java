package com.acorn.doma.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.sql.SQLException;
import java.util.List;

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
        log.debug("┌──────────────────────────────┐");
        log.debug("│ setUp()                      │");
        log.debug("└──────────────────────────────┘");
        
        admin01 = new Admin(
                1, "20", "제목_01", "admin01", "admin01", "내용_01", "img_link_01", "2024-01-01", "2024-01-01", 0, "구_01",
                "User01", "password", "user01@example.com", "1990-01-01", 1, "서울 서대문구", "101호", "2024-01-01"
            );
            admin02 = new Admin(
                2, "20", "제목_02", "admin02", "admin02", "내용_02", "img_link_02", "2024-02-02", "2024-02-02", 0, "구_02",
                "User02", "password", "user02@example.com", "1992-02-02", 1, "서울 서대문구", "102호", "2024-02-02"
            );
            admin03 = new Admin(
                3, "20", "제목_03", "admin03", "admin03", "내용_03", "img_link_03", "2024-03-03", "2024-03-03", 0, "구_03",
                "User03", "password", "user03@example.com", "1994-03-03", 1, "서울 서대문구", "103호", "2024-03-03"
            );

            search = new Search();
        }

    @After
    public void tearDown() throws Exception {
        log.debug("┌──────────────────────────────┐");
        log.debug("│ tearDown()                   │");
        log.debug("└──────────────────────────────┘");
    }
    
    public void isSameAdmin(Admin adminIn, Admin adminOut) {
        assertEquals(adminIn.getSeq(), adminOut.getSeq());
        assertEquals(adminIn.getDiv(), adminOut.getDiv());
        assertEquals(adminIn.getTitle(), adminOut.getTitle());
        assertEquals(adminIn.getUserId(), adminOut.getUserId());
        assertEquals(adminIn.getModId(), adminOut.getModId());
        assertEquals(adminIn.getContent(), adminOut.getContent());
        assertEquals(adminIn.getImgLink(), adminOut.getImgLink());
        assertEquals(adminIn.getGname(), adminOut.getGname());
        assertEquals(adminIn.getViews(), adminOut.getViews());
        assertEquals(adminIn.getRegDt(), adminOut.getRegDt());
        assertEquals(adminIn.getModDt(), adminOut.getModDt());
        
        assertEquals(adminIn.getUserName(), adminOut.getUserName());
        assertEquals(adminIn.getUserPw(), adminOut.getUserPw());
        assertEquals(adminIn.getUserEmail(), adminOut.getUserEmail());
        assertEquals(adminIn.getUserBirth(), adminOut.getUserBirth());
        assertEquals(adminIn.getUserGrade(), adminOut.getUserGrade());
        assertEquals(adminIn.getUserAddress(), adminOut.getUserAddress());
        assertEquals(adminIn.getUserDetailAddress(), adminOut.getUserDetailAddress());
        assertEquals(adminIn.getUserRegDt(), adminOut.getUserRegDt());
    }
    
    @Test
    public void addAndGet() throws Exception {
        // 공지사항 등록 테스트
        int flag = adminMapper.insertNotice(admin01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        // 단건 조회 테스트
        Admin outAdmin01 = adminMapper.getNoticeById(admin01.getSeq());
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

    @Ignore 
    @Test
    public void doRetrieve() throws SQLException {
        // 공지사항 목록 조회 테스트
        search.setDiv("20");
        search.setSearchWord("공지사항");

        List<Admin> list = adminMapper.getNotices(search);
        assertNotNull(list);
    }


    @Ignore 
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

    @Ignore 
    @Test
    public void testNoticeSpecificRetrieve() throws Exception {
        try {
        	
            log.debug("┌──────────────────────────────┐");
            log.debug("│ testNoticeSpecificRetrieve() │");
            log.debug("└──────────────────────────────┘");
            // Given: 테스트 데이터 삽입
            int noticeId = admin01.getSeq(); // 예시로 admin01의 ID를 사용
            int flag = adminMapper.insertNotice(admin01);
            log.debug("Insert flag: " + flag);
            assertEquals(1, flag);

            // When: 공지사항 조회
            Admin retrievedAdmin = adminMapper.getNoticeById(noticeId);
            log.debug("Retrieved Admin: " + retrievedAdmin);

            // Then: 조회 결과 확인
            assertNotNull(retrievedAdmin); // 공지사항이 존재해야 함
            assertEquals(noticeId, retrievedAdmin.getSeq()); // 공지사항의 ID가 맞아야 함
            isSameAdmin(admin01, retrievedAdmin); // 공지사항 데이터가 올바른지 확인

            // Clean up: 삽입한 공지사항 삭제
            flag = adminMapper.deleteNotice(retrievedAdmin);
            log.debug("Delete flag: " + flag);
            assertEquals(1, flag);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("SQLException occurred: " + e.getMessage());
        }
    }

    @Ignore    
    @Test
    public void testUserRetrieve() throws SQLException {
        // 회원 목록 조회 테스트
        search.setDiv("20"); // 또는 적절한 값을 설정합니다
        search.setSearchWord("User Two"); // 또는 적절한 검색어 설정

        List<Admin> userList = adminMapper.getUsers(search);
        log.debug("userList : " + userList);
        assertNotNull(userList);
        assertTrue(userList.stream().anyMatch(user -> user.getUserId().equals(admin02.getUserId())));

        // 회원 단건 조회 테스트
        Admin retrievedUser = adminMapper.getUser(admin02);
        log.debug("retrievedUser : " + retrievedUser);
        assertNotNull(retrievedUser);
        assertEquals(admin02.getUserId(), retrievedUser.getUserId());

        // 회원 수정 테스트
        retrievedUser.setUserName("Updated User");
        int flag = adminMapper.updateUser(retrievedUser);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        // 수정된 회원 조회 테스트
        Admin updatedUser = adminMapper.getUser(retrievedUser);
        log.debug("updatedUser : " + updatedUser);
        assertNotNull(updatedUser);
        assertEquals("Updated User", updatedUser.getUserName());

        // 회원 삭제 테스트
        flag = adminMapper.deleteUser(retrievedUser);
        log.debug("flag : " + flag);
        assertEquals(1, flag);
    }
}
