package com.acorn.doma.controller;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Comments;
import com.acorn.doma.mapper.CommentsMapper;


@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class commentsControllerTest implements PLog {

	@Autowired
	WebApplicationContext webApplicationContext;
	
	@Autowired
	CommentsMapper commentsMapper;
	
	Search search;
	
	Comments comments01;
	Comments comments02;
	Comments comments03;
	
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		commentsMapper.deleteAll();
		
		comments01 = new Comments(1, 1, "등록자01", "수정자01", "내용", "사용안함", "사용안함");
		comments02 = new Comments(2, 1, "등록자02", "수정자02", "내용", "사용안함", "사용안함");
		comments03 = new Comments(3, 1, "등록자03", "수정자03", "내용", "사용안함", "사용안함");
		
		commentsMapper.deleteAll();
		
		search = new Search();
		
		
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
		
	}
	
	@Ignore
	@Test
    public void doRetrieve() throws Exception {
		// 저장
        commentsMapper.doSave(comments01);
        commentsMapper.doSave(comments02);
        commentsMapper.doSave(comments03);
		
        search.setSeq(1);
        search.setSearchWord("내용");

        List<Comments> list = commentsMapper.doRetrieve(search);
        assertNotNull(list);
    }
	
	@Ignore
	@Test
	public void doUpdate() throws Exception {
	    //저장
	    int flag = commentsMapper.doSave(comments01);
	    log.debug("flag : " + flag);
	    assertEquals(1, flag);

	    //등록 seq조회
	    int comSeq = commentsMapper.getSequence();
	    log.debug("comSeq : " + comSeq);
	    comments01.setComSeq(comSeq);

	    //단건 조회
	    Comments outVO01 = commentsMapper.doSelectOne(comments01);
	    log.debug("outVO01 : " + outVO01);
	    assertNotNull(outVO01);

	    //업데이트 코멘트
	    String updateStr = "_U";
	    outVO01.setModId("등록자01");
	    outVO01.setComments(outVO01.getComments() + updateStr);

	    flag = commentsMapper.doUpdate(outVO01);
	    log.debug("flag : " + flag);
	    assertEquals(1, flag);

	    Comments outVO01Update = commentsMapper.doSelectOne(outVO01);
	    log.debug("outVO01Update : " + outVO01Update);
	    assertNotNull(outVO01Update);

	    isSameComments(outVO01Update, outVO01);
	}
	
	
//	@Ignore
	@Test
	public void addAndGet() throws Exception {
		
		//comment01-----------------------
		int flag = commentsMapper.doSave(comments01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		int comSeq = commentsMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comments01.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO01 = commentsMapper.doSelectOne(comments01);
		log.debug("outVO01 : " + outVO01);
		assertNotNull(outVO01);
		

		
		//comment02-----------------------
		flag = commentsMapper.doSave(comments02);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		comSeq = commentsMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comments02.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO02 = commentsMapper.doSelectOne(comments01);
		log.debug("outVO02 : " + outVO02);
		assertNotNull(outVO02);
		

		
		
		//comment03-----------------------
		flag = commentsMapper.doSave(comments03);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		comSeq = commentsMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comments03.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO03 = commentsMapper.doSelectOne(comments01);
		log.debug("outVO03 : " + outVO03);
		assertNotNull(outVO03);

		
		// 단건 삭제
		flag = commentsMapper.doDelete(outVO01);
		assertEquals(1, flag);
	}
	
	public void isSameComments(Comments commentsIn, Comments commentsOut) {
		assertEquals(commentsIn.getComSeq(), commentsOut.getComSeq());
		assertEquals(commentsIn.getSeq(), commentsOut.getSeq());
		assertEquals(commentsIn.getUserId(), commentsOut.getUserId());
		assertEquals(commentsIn.getModId(), commentsOut.getModId());
		assertEquals(commentsIn.getComments(), commentsOut.getComments());
	}

	@Test
	public void test() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("==webApplicationContext==  :  " + webApplicationContext);
		
		assertNotNull(webApplicationContext);
	}

}
