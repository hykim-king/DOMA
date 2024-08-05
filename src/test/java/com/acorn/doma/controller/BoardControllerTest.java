package com.acorn.doma.controller;

import static org.junit.Assert.*;

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
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.domain.Board;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.mapper.BoardMapper;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class BoardControllerTest implements PLog {

	@Autowired
	WebApplicationContext webApplicationContext;
	
	//브라우저 대신 Mock
	MockMvc mockMvc;
	
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	BoardService boardService;
	
	Board board01;
	Board board02;
	Board board03;

	Search search;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		boardMapper.deleteAll();
		
		board01 = new Board(1,"10","구_01","제목_01","admin","admin","내용_01","1111","사용안함","사용안함",0);
		board02 = new Board(2,"10","구_02","제목_02","admin","admin","내용_02","1111","사용안함","사용안함",0);
		board03 = new Board(3,"10","구_03","제목_03","admin","admin","내용_03","1111","사용안함","사용안함",0);

		search = new Search();
		
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}

	//@Ignore
	@Test
	public void test() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("==webApplicationContext==  :  " + webApplicationContext);
		log.debug("==mockMvc==  :  " + mockMvc);
		
		assertNotNull(webApplicationContext);
		assertNotNull(mockMvc);
		assertNotNull(boardMapper);
		assertNotNull(boardService);
	}

}
