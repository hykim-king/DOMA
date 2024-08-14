package com.acorn.doma.dao;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search; 
import com.acorn.doma.domain.Death;
import com.acorn.doma.mapper.BoardMapper;
import com.acorn.doma.mapper.DeathMapper;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.DeathService;

@WebAppConfiguration
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) // 알파벳 순서로 테스트 메서드 실행
public class ChartMapperTest implements PLog {
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	BoardMapper boardMapper;
	
	
	@Autowired
	DeathMapper deathMapper;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	DeathService deathService;
	Search search;
	

	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}

	@Test
	public void MonthDead() throws SQLException { 
		Death inVO = new Death(); 
	    List<Map<String, Object>> list = deathMapper.MonthDead(inVO);

	    // Log the results
	    log.debug("list : " + list);
	}

	
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		 
	}

}
