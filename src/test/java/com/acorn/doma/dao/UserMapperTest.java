package com.acorn.doma.dao;

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
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.UserMapper;

@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
public class UserMapperTest implements PLog {

	@Autowired
	ApplicationContext context;

	@Autowired
	UserMapper userMapper;

	User userVO01;
	User userVO02;
	User userVO03;

	Search search;

	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		userVO01 = new User("rkdgur2016", "임강혁", "1234", "rkdgur2016@gmail.com", "2001-01-16", 1, "서울시 마포구 숭문16길 28", "201호", "sysdate");
		userVO02 = new User("user1", "user1","1111","user1@naver.com",  "2001-01-01", 1,	"서울 서대문구", "101호","sysdate");
		userVO03 = new User("uki", "엄기은", "1111",	"uki2022751011@gmail.com",	"2001-01-01", 1, "인천 서구", "1111", "sysdate");
		search = new Search();
	}
	
	
	
	
	@Test
	public void saveAndCount() throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ saveAndCount()               │");
		log.debug("└──────────────────────────────┘");
		
		userMapper.deleteAll();
		
		//1번째 유저 저장
		int flag = userMapper.doSave(userVO01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		//2번째 유저 저장
		flag = userMapper.doSave(userVO02);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		//3번째 유저 저장
		flag = userMapper.doSave(userVO03);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		flag = userMapper.getCount();
		log.debug("flag : " + flag);
		assertEquals(3, flag);
		
	}
	
	
	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	
	@Test
	public void login() throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ getUserIdAndLogin()          │");
		log.debug("└──────────────────────────────┘");
		userMapper.deleteAll();
		int flag = userMapper.doSave(userVO01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		//2번째 유저 저장
		flag = userMapper.doSave(userVO02);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		//3번째 유저 저장
		flag = userMapper.doSave(userVO03);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		flag = userMapper.getCount();
		log.debug("flag : " + flag);
		assertEquals(3, flag);
		User outVO01 = userMapper.login(userVO01);
		User outVO02 = userMapper.login(userVO02);
		User outVO03 = userMapper.login(userVO03);
		log.debug("outVO01 : " + outVO01);
		log.debug("outVO02 : " + outVO02);
		log.debug("outVO03 : " + outVO03);
		
		isSameUser(userVO01, outVO01);
		isSameUser(userVO02, outVO02);
		isSameUser(userVO03, outVO03);
	}
	
	@Test
	public void getUserIdAndUpdate() throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ getUserId()                  │");
		log.debug("└──────────────────────────────┘");
		
		String outVO = userMapper.getUserId(userVO01.getUserId());
		log.debug("outVO : " + outVO);
		assertEquals(userVO01.getUserId(), outVO);
		

		log.debug("┌──────────────────────────────┐");
		log.debug("│ update()                     │");
		log.debug("└──────────────────────────────┘");
		String updateStr = "_Ultra";
		userVO03.setUserName(userVO03.getUserName() + updateStr);
		
		int flag = userMapper.doUpdate(userVO03);
		if(flag == 1) {			
			log.debug("flag : " + flag);
			log.debug("doUpdate() 성공");
		}else {
			log.debug("flag : " + flag);
			log.debug("doUpdate() 실패");
		}
		
		User userVO = userMapper.login(userVO03);
		
		assertNotEquals(userVO03, userVO);;
	}
	

	public void isSameUser(User userVO, User outVO) {
		assertEquals(userVO.getUserId(), outVO.getUserId());
		assertEquals(userVO.getUserName(), outVO.getUserName());
		assertEquals(userVO.getUserPw(), outVO.getUserPw());
		assertEquals(userVO.getBirth(), outVO.getBirth());
		assertEquals(userVO.getGrade(), outVO.getGrade());
		assertEquals(userVO.getAddress(), outVO.getAddress());
		assertEquals(userVO.getDetailAddress(), outVO.getDetailAddress());
	}

	@Ignore
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