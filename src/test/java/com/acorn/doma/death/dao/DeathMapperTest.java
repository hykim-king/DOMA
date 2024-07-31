package com.acorn.doma.death.dao;

import static org.junit.Assert.*;


import java.sql.SQLException;
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
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Death;
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.DeathMapper;
import com.acorn.doma.mapper.UserMapper;



@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class DeathMapperTest implements PLog {

	@Autowired
	ApplicationContext context;
	
	@Autowired
	UserMapper userMapper;
	@Autowired
	DeathMapper deathMapper;
 
	
	Search search;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		

		
	}
	@Ignore
	
	@Test
	public void doRetrieve() throws SQLException{
		
		//건수 조회
		int count = userMapper.getCount();
		assertEquals(1, count);
		
		search.setPageNo(1);
		search.setPageSize(10);
		
		search.setSearchDiv("10");
		search.setSearchWord("rogan");
		
		List<User> list = userMapper.doRetrieve(search);
		assertEquals(10, list.size());
	}
	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	
	 
	@Test
    public void deathDayNight() throws Exception {
        
        List<Death> results = deathMapper.deathDayNight();

       
    }
	
	
	@Ignore
	@Test
	public void countAll() throws Exception{
		int count = deathMapper.countAll();
	}
	
	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		
		assertNotNull(context);
	}

}
