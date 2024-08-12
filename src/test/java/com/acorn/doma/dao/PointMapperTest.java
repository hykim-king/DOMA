package com.acorn.doma.dao;

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
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
									"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class PointMapperTest implements PLog{
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	PointMapper pointMapper;
	
	Point point;
	Point pointVO02;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		point = new Point("3", "d", 1, 1, 1, 1, 1, "type", 1, 2, "2", "d");
		pointVO02 = new Point("1", "2", 0, 0, 0, 0, 0, "", 0.0, 0.0, "2022", "강남구");
		pointMapper.doDeleteAll();
	}
	
	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	@Test
	public void sqlAll() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ sqlAll()                     │");
		log.debug("└──────────────────────────────┘");
		int flag = pointMapper.dataInsert(point);
		assertEquals(flag, 1);
		flag = pointMapper.dataInsert(pointVO02);
		assertEquals(flag, 1);
		List<String> guList = pointMapper.guLoad("2022");
		log.debug("┌ list ┐");
		for(String gu : guList) {
			log.debug("│ gu : " + gu);
		}
		log.debug("└─────────────────────────────────────────────");
		assertEquals(1, guList.size());
		
		List<Point> pointList = pointMapper.detailInfoLoad(pointVO02);
		log.debug("1. pointVO02 : " + pointVO02);
		log.debug("┌ list ┐");
		for(Point point : pointList) {
			log.debug("│ Point : " + point);
		}
		log.debug("└─────────────────────────────────────────────");
		assertEquals(1, pointList.size());
		
		List<Point> listPoint = pointMapper.fullTableScan();
		assertEquals(2, listPoint.size());
		
		int count = pointMapper.countAll();
		assertEquals(2, count);
	}
	@Test
	public void guLoad() throws Exception	{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ guLoad()                │");
		log.debug("└──────────────────────────────┘");
		int flag = pointMapper.dataInsert(pointVO02);
		List<String> guList = pointMapper.guLoad("2022");
		log.debug("┌ list ┐");
		for(String gu : guList) {
			log.debug("│ gu : " + gu);
		}
		log.debug("└─────────────────────────────────────────────");
		
		assertEquals(1, guList.size());
	}
	

	@Test
	public void detailInfoLoad() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ detailInfoLoad()             │");
		log.debug("└──────────────────────────────┘");
		int flag = pointMapper.dataInsert(pointVO02);
		assertEquals(1, flag);
		List<Point> pointList = pointMapper.detailInfoLoad(pointVO02);
		log.debug("1. pointVO02 : " + pointVO02);
		log.debug("┌ list ┐");
		for(Point point : pointList) {
			log.debug("│ Point : " + point);
		}
		log.debug("└─────────────────────────────────────────────");
		
		assertEquals(1, pointList.size());
	}
	
	

	@Test
	public void fullTableScan() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ fullTableScan()              │");
		log.debug("└──────────────────────────────┘");
		int flag = pointMapper.dataInsert(point);
		assertEquals(1, flag);
		List<Point> listPoint = pointMapper.fullTableScan();

		log.debug("┌ list ┐");
		for(Point point : listPoint) {
			log.debug("│ point : " + point);
		}
		log.debug("└");
		
		assertEquals(1, listPoint.size());
		
	}
	
	
	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("pointMapper:" + pointMapper);

		assertNotNull(context);
		assertNotNull(pointMapper);
	}

}
