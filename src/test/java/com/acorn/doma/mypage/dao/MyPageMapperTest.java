package com.acorn.doma.mypage.dao;

 
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.UserMapper;
import com.acorn.doma.user.service.UserService; 
@WebAppConfiguration
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class MyPageMapperTest implements PLog {

	 
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	MockMvc mockMvc;
	
	@Autowired
	ApplicationContext context;

	@Autowired
	UserMapper userMapper;

	@Autowired
	UserService userService;
	
	User userVO01; 

	Search search;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		//userMapper.deleteAll(); 
		userVO01= new User("user2", "user2", "2222", "user2@naver.com", "2002-02-02", 1, "서울 서대문구", "101호", "24/08/02"); 
		
		
		search = new Search();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	
	
	@Test
	public void mpSelectOne() throws Exception{  
		
		int flag = userMapper.doSave(userVO01);
		log.debug("flag:"+flag);
		assertEquals(1, flag); 
		
		User outVO = userService.mpSelctOne(userVO01);
		log.debug("outVO : " + outVO);
		
	}

	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("userMapper:" + userMapper);

		assertNotNull(context);
		assertNotNull(userMapper);
	
	}

}
