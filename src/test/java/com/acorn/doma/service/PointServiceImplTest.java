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
		pointMapper.doDeleteAll();
		pointService.insertPointData();
		pointMapper.countAll();
		pointVO = new Point("", "", 0, 0, 0, 0, 0, "", 0.0, 0.0, "2022", "강남구");
		
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ tearDown()                           │");
		log.debug("└──────────────────────────────────────┘");
		
	}
//	@Ignore
	@Test
	public void guLoad() throws Exception	{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ guLoad()                │");
		log.debug("└──────────────────────────────┘");
		
		List<String> guList = pointService.guLoad("2022");
		log.debug("┌ list ┐");
		for(String gu : guList) {
			log.debug("│ gu : " + gu);
		}
		log.debug("└─────────────────────────────────────────────");
		
		assertEquals(25, guList.size());
	}
	@Ignore
	@Test
	public void detailInfoLoad() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ detailInfoLoad()             │");
		log.debug("└──────────────────────────────┘");
		
		List<Point> pointList = pointService.detailInfoLoad(pointVO);
		log.debug("1. pointVO : " + pointVO);
		log.debug("┌ list ┐");
		for(Point point : pointList) {
			log.debug("│ Point : " + point);
		}
		log.debug("└─────────────────────────────────────────────");
		
		assertEquals(25, pointList.size());
	}
	
	@Ignore
	@Test
	public void fullTableScan() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ fullTableScan()              │");
		log.debug("└──────────────────────────────┘");
		List<Point> listPoint = pointService.fullTableScan();
		
		log.debug("┌ list ┐");
		for(Point point : listPoint) {
			log.debug("│ point : " + point);
		}
		log.debug("└");
		
		assertEquals(6, listPoint.size());
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
