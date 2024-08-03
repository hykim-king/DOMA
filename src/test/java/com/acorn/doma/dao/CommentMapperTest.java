package com.acorn.doma.dao;

import static org.junit.Assert.*;

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
import com.acorn.doma.domain.Comments;
import com.acorn.doma.mapper.BoardMapper;
import com.acorn.doma.mapper.CommentsMapper;
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class CommentMapperTest implements PLog{
	@Autowired
	ApplicationContext context;
	@Autowired
	CommentsMapper commentMapper;
	
	Comments comment01;
	@Before
	public void setUp() throws Exception {
		log.debug("======setUp=========");
		comment01 = new Comments(1, 1, "등록자", "수정자", "내용", "사용안함", "사용안함");
	}
	
	@After
	public void tearDown() throws Exception {
		log.debug("=======tearDown=========");
	}
	@Test
	public void doSave() throws Exception{
		log.debug("doSave()");
		int flag = commentMapper.doSave(comment01);
		assertEquals(1, flag);
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
