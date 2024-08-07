package com.acorn.doma.service;

import static org.junit.Assert.assertNotNull;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

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
import com.acorn.doma.mapper.FreezingMapper;
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class FreezingServiceImplTest implements PLog{
	@Autowired
	ApplicationContext context;
	@Autowired
	FreezingService freezingService;
	
	@Autowired
	FreezingMapper freezingMapper;
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ setUp()                              │");
		log.debug("└──────────────────────────────────────┘");
		
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ tearDown()                           │");
		log.debug("└──────────────────────────────────────┘");
		
	}
	@Ignore
	@Test
	public void testInsertFreezingData() throws Exception{
		freezingService.insertFreezingData();
		freezingMapper.countAll();
	}
	@Test
	public void selectFreezingData() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ selectFreezingData()         │");
		log.debug("└──────────────────────────────┘");
		List<Integer> years = Arrays.asList(2021, 2020);
		 List<Map<String, Object>> result = freezingService.selectFreezingData(years);
	}
	@Ignore
	@Test
	public void test() {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ beans()                              │");
		log.debug("└──────────────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("freezingService:" + freezingService);
		
		assertNotNull(context);
		assertNotNull(freezingService);
	}

}
