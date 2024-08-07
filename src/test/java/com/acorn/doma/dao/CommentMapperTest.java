package com.acorn.doma.dao;

import static org.junit.Assert.*;

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
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Code;
import com.acorn.doma.domain.Comments;
import com.acorn.doma.mapper.CommentsMapper;
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class CommentMapperTest implements PLog {
	@Autowired
	ApplicationContext context;
	
	@Autowired
	CommentsMapper commentMapper;
	
	Comments comment01;
	Comments comment02;
	Comments comment03;
	
	Search search;
	
	
	@Before
	public void setUp() throws Exception {
		log.debug("======setUp=========");
		
		comment01 = new Comments(1, 1, "등록자01", "등록자01", "내용", "사용안함", "사용안함");
		comment02 = new Comments(2, 1, "등록자02", "등록자02", "내용", "사용안함", "사용안함");
		comment03 = new Comments(3, 1, "등록자03", "등록자03", "내용", "사용안함", "사용안함");
		
		commentMapper.deleteAll();
		
	}
	
	@After
	public void tearDown() throws Exception {
		log.debug("=======tearDown=========");
	}
	
	//@Ignore
	@Test
	public void doRetrieve() throws Exception {
		

		search.setPageNo(1);
		search.setPageSize(10);
		
		search.setSearchDiv("30");
		//제목000001
		//내용000001
		search.setSearchWord("내용000001");
		
		List<Comments> list = commentMapper.doRetrieve(search);
		assertEquals(0, list.size());

	}
	
	@Ignore
	@Test
	public void doUpdate() throws Exception {
	    //저장
	    int flag = commentMapper.doSave(comment01);
	    log.debug("flag : " + flag);
	    assertEquals(1, flag);

	    //등록 seq조회
	    int comSeq = commentMapper.getSequence();
	    log.debug("comSeq : " + comSeq);
	    comment01.setComSeq(comSeq);

	    //단건 조회
	    Comments outVO01 = commentMapper.doSelectOne(comment01);
	    log.debug("outVO01 : " + outVO01);
	    assertNotNull(outVO01);

	    //업데이트 코멘트
	    String updateStr = "_U";
	    outVO01.setModId("등록자01");
	    outVO01.setComments(outVO01.getComments() + updateStr);

	    flag = commentMapper.doUpdate(outVO01);
	    log.debug("flag : " + flag);
	    assertEquals(1, flag);

	    Comments outVO01Update = commentMapper.doSelectOne(outVO01);
	    log.debug("outVO01Update : " + outVO01Update);
	    assertNotNull(outVO01Update);

	    isSameComments(outVO01Update, outVO01);
	}
	
	
	@Ignore
	@Test
	public void addAndGet() throws Exception {
		
		//comment01-----------------------
		int flag = commentMapper.doSave(comment01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		int comSeq = commentMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comment01.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO01 = commentMapper.doSelectOne(comment01);
		log.debug("outVO01 : " + outVO01);
		assertNotNull(outVO01);
		
		isSameComments(comment01, outVO01);
		
		//comment02-----------------------
		flag = commentMapper.doSave(comment02);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		comSeq = commentMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comment02.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO02 = commentMapper.doSelectOne(comment01);
		log.debug("outVO02 : " + outVO02);
		assertNotNull(outVO02);
		
		isSameComments(comment01, outVO02);
		
		
		//comment03-----------------------
		flag = commentMapper.doSave(comment03);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		comSeq = commentMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comment03.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO03 = commentMapper.doSelectOne(comment01);
		log.debug("outVO03 : " + outVO03);
		assertNotNull(outVO03);
		
		isSameComments(comment01, outVO03);
		
		// 단건 삭제
		flag = commentMapper.doDelete(outVO01);
		assertEquals(1, flag);
	}
	
	public void isSameComments(Comments commentsIn, Comments commentsOut) {
		assertEquals(commentsIn.getComSeq(), commentsOut.getComSeq());
		assertEquals(commentsIn.getSeq(), commentsOut.getSeq());
		assertEquals(commentsIn.getUserId(), commentsOut.getUserId());
		assertEquals(commentsIn.getModId(), commentsOut.getModId());
		assertEquals(commentsIn.getComments(), commentsOut.getComments());
	}
	
	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("commentMapper:" + commentMapper);

		assertNotNull(context);
		assertNotNull(commentMapper);
	}

}
