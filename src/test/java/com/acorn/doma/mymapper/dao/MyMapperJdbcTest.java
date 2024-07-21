package com.acorn.doma.mymapper.dao;

import static org.junit.Assert.*;

import java.sql.SQLException;

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

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.mymapper.dao.MyMapperDao;
import com.acorn.doma.mymapper.domain.MyMapper;

@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class MyMapperJdbcTest implements PLog {

	@Autowired
	ApplicationContext context;
	
	@Autowired
	MyMapperDao myMapperDao;
	
	MyMapper myMapper;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ setUp()                                      │");
		log.debug("└──────────────────────────────────────────────┘");
		
		myMapper = new MyMapper();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ tearDown()                                   │");
		log.debug("└──────────────────────────────────────────────┘");
	}
	
	@Test
	public void doSelectOne() throws SQLException {
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ doSelectOne()                                │");
		log.debug("└──────────────────────────────────────────────┘");
		
		myMapper.setUserId("rogan");
		myMapper.setPassword("4321");
		
		MyMapper outVO =  myMapperDao.doSelectOne(myMapper);
		log.debug("│ outVO                                │"+ outVO);
		assertNotNull(outVO);
	}
	
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────────────────────┐");
		log.debug("│ beans()                                      │");
		log.debug("└──────────────────────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("myMapperDao:" + myMapperDao);
		assertNotNull(context);
		assertNotNull(myMapperDao);
		
	}
}