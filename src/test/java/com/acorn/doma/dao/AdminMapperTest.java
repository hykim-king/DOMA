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
import com.acorn.doma.domain.Board;
import com.acorn.doma.mapper.AdminMapper;
import com.acorn.doma.cmn.Search;

@RunWith(SpringRunner.class) 
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class AdminMapperTest implements PLog {

    @Autowired
    ApplicationContext context;
    
    @Autowired
    AdminMapper adminMapper;
    
    Board board01;
    Board board02;
    Board board03;
    
    Search search;
    
    @Before
    public void setUp() throws Exception {
        log.debug("┌──────────────────────────────┐");
        log.debug("│ setUp()                      │");
        log.debug("└──────────────────────────────┘");
        
        board01 = new Board(1, "20", "공지사항_01", "제목_01", "admin", "admin", "내용_01", "1111", null, null, 0);
        board02 = new Board(2, "20", "공지사항_02", "제목_02", "admin", "admin", "내용_02", "1111", null, null, 0);
        board03 = new Board(3, "20", "공지사항_03", "제목_03", "admin", "admin", "내용_03", "1111", null, null, 0);
        
        // adminMapper.deleteAll(); // 공지사항 전체 삭제
        search = new Search();
    }

    @After
    public void tearDown() throws Exception {
        log.debug("┌──────────────────────────────┐");
        log.debug("│ tearDown()                   │");
        log.debug("└──────────────────────────────┘");
    }
    
    public void isSameBoard(Board boardIn, Board boardOut) {
        assertEquals(boardIn.getSeq(), boardOut.getSeq());
        assertEquals(boardIn.getDiv(), boardOut.getDiv());
        assertEquals(boardIn.getTitle(), boardOut.getTitle());
        assertEquals(boardIn.getRegId(), boardOut.getRegId());
        assertEquals(boardIn.getModId(), boardOut.getModId());
        assertEquals(boardIn.getContent(), boardOut.getContent());
        assertEquals(boardIn.getImgLink(), boardOut.getImgLink());
    }
    
    @Ignore
    @Test
    public void addAndGet() throws Exception {
        // 공지사항 등록 테스트
        int flag = adminMapper.insertNotice(board01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        // 단건 조회 테스트
        Board outVO01 = adminMapper.getNotice(board01);
        log.debug("outVO01 : " + outVO01);
        assertNotNull(outVO01);
        isSameBoard(board01, outVO01);

        // 공지사항 수정 테스트
        String updateStr = "_U";
        outVO01.setTitle(outVO01.getTitle() + updateStr);
        outVO01.setModId(outVO01.getModId() + updateStr);
        outVO01.setContent(outVO01.getContent() + updateStr);

        flag = adminMapper.updateNotice(outVO01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);

        Board outVO01Update = adminMapper.getNotice(outVO01);
        log.debug("outVO01Update : " + outVO01Update);
        assertNotNull(outVO01Update);
        isSameBoard(outVO01Update, outVO01);

        // 공지사항 삭제 테스트
        flag = adminMapper.deleteNotice(outVO01);
        log.debug("flag : " + flag);
        assertEquals(1, flag);
    }

    @Ignore
    @Test
    public void doRetrieve() throws SQLException {
        // 공지사항 목록 조회 테스트
        search.setDiv("20");
        search.setSearchWord("공지사항");

        List<Board> list = adminMapper.getNotices(search);
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
