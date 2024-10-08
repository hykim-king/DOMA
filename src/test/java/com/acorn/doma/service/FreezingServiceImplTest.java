package com.acorn.doma.service;

import static org.junit.Assert.assertFalse;
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
import com.acorn.doma.domain.Freezing;
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
	
	Freezing freezing;
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ setUp()                              │");
		log.debug("└──────────────────────────────────────┘");
		freezing = new Freezing();
		
		
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ tearDown()                           │");
		log.debug("└──────────────────────────────────────┘");
		
	}
	@Test
	public void dataInsert() throws Exception{
		freezingMapper.doDeleteAll();
		freezingService.insertFreezingData();
		freezingMapper.countAll();
	}
//	@Ignore
	@Test
	public void serviceSqlAll() throws Exception{
		List<Freezing> allData = freezingService.selectAllData();		
		assertNotNull(allData);
		String fid = "6571253";
		Freezing outVO = freezingService.selectFreezingDataById(fid);
		assertNotNull(outVO);
		String year = "2018";
		List<Freezing> yearData = freezingService.selectPolyByYear(year);
		assertNotNull(yearData);
		List<Freezing> allYear = freezingService.selectPolyAll();
		assertNotNull(allYear);
		
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
