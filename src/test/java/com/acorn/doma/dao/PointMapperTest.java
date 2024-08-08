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
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		point = new Point("3", "d", 1, 1, 1, 1, 1, "type", 1, 2, "2", "d");
		pointMapper.doDeleteAll();
	}
	
	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
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
	
//	@Ignore
	@Test
	public void dataInsert() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ dataInsert()                 │");
		log.debug("└──────────────────────────────┘");
		int flag = pointMapper.dataInsert(point);
		assertEquals(1, flag);
		
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
