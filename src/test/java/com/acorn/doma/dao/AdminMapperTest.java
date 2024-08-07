package com.acorn.doma.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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
            1, "20", "제목_01", "admin", "admin", "내용_01", "1111", null, null, 0, "groupName",
            "user01", "User One", "password", "user01@example.com", "1990-01-01", 1, "Address", "Detail Address", "2024-01-01"
        );
        admin02 = new Admin(
            2, "20", "제목_02", "admin", "admin", "내용_02", "1111", null, null, 0, "groupName",
            "user02", "User Two", "password", "user02@example.com", "1992-02-02", 1, "Address", "Detail Address", "2024-02-02"
        );
        admin03 = new Admin(
            3, "20", "제목_03", "admin", "admin", "내용_03", "1111", null, null, 0, "groupName",
            "user03", "User Three", "password", "user03@example.com", "1994-03-03", 1, "Address", "Detail Address", "2024-03-03"
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
        assertEquals(adminIn.getBoardSeq(), adminOut.getBoardSeq());
        assertEquals(adminIn.getBoardDiv(), adminOut.getBoardDiv());
        assertEquals(adminIn.getBoardTitle(), adminOut.getBoardTitle());
        assertEquals(adminIn.getBoardRegId(), adminOut.getBoardRegId());
        assertEquals(adminIn.getBoardModId(), adminOut.getBoardModId());
        assertEquals(adminIn.getBoardContent(), adminOut.getBoardContent());
        assertEquals(adminIn.getBoardImgLink(), adminOut.getBoardImgLink());
        assertEquals(adminIn.getBoardGname(), adminOut.getBoardGname());
        assertEquals(adminIn.getBoardViews(), adminOut.getBoardViews());
        assertEquals(adminIn.getBoardRegDt(), adminOut.getBoardRegDt());
        assertEquals(adminIn.getBoardModDt(), adminOut.getBoardModDt());
        
        assertEquals(adminIn.getUserId(), adminOut.getUserId());
        assertEquals(adminIn.getUserName(), adminOut.getUserName());
        assertEquals(adminIn.getUserPw(), adminOut.getUserPw());
        assertEquals(adminIn.getUserEmail(), adminOut.getUserEmail());
        assertEquals(adminIn.getUserBirth(), adminOut.getUserBirth());
        assertEquals(adminIn.getUserGrade(), adminOut.getUserGrade());
        assertEquals(adminIn.getUserAddress(), adminOut.getUserAddress());
        assertEquals(adminIn.getUserDetailAddress(), adminOut.getUserDetailAddress());
        assertEquals(adminIn.getUserRegDt(), adminOut.getUserRegDt());
    }
    
    @Ignore
    @Test
    public void addAndGet() throws Exception {
        // 공지사항 등록 테스트
        int flag = adminMapper.insertNotice(admin01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        // 단건 조회 테스트
        Admin outAdmin01 = adminMapper.getNotice(admin01);
        log.debug("outAdmin01 : " + outAdmin01);
        assertNotNull(outAdmin01);
        isSameAdmin(admin01, outAdmin01);

        // 공지사항 수정 테스트
        String updateStr = "_U";
        outAdmin01.setBoardTitle(outAdmin01.getBoardTitle() + updateStr);
        outAdmin01.setBoardModId(outAdmin01.getBoardModId() + updateStr);
        outAdmin01.setBoardContent(outAdmin01.getBoardContent() + updateStr);

        flag = adminMapper.updateNotice(outAdmin01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        Admin outAdmin01Update = adminMapper.getNotice(outAdmin01);
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
}
