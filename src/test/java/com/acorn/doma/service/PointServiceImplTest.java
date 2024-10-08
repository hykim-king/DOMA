package com.acorn.doma.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;

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
import com.acorn.doma.domain.Point;
import com.acorn.doma.mapper.PointMapper;
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class PointServiceImplTest implements PLog{
	@Autowired
	ApplicationContext context;
	@Autowired
	PointService pointService;
	
	@Autowired
	PointMapper pointMapper;
	
	Point pointVO;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ setUp()                              │");
		log.debug("└──────────────────────────────────────┘");
		pointVO = new Point();
		
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ tearDown()                           │");
		log.debug("└──────────────────────────────────────┘");
		
	}	
//	@Ignore
	@Test
	public void dataInsert() throws Exception{
		pointMapper.doDeleteAll();
		pointService.insertPointData();
		pointMapper.countAll();
	}
	@Test
	public void serviceAll() throws Exception{
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ serviceAll()                         │");
		log.debug("└──────────────────────────────────────┘");
		pointVO.setGname("강남구");
		pointVO.setYear("2022");
		List<Point> pointList = pointService.detailInfoLoad(pointVO);
		assertEquals(25, pointList.size());
		List<Point> listPoint = pointService.fullTableScan();
		assertNotNull(listPoint);
	}

	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ beans()                              │");
		log.debug("└──────────────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("pointService:" + pointService);
		
		assertNotNull(context);
		assertNotNull(pointService);
	}

}
