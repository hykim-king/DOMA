package com.acorn.doma.user.dao;

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

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
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


		userVO01 = new User("user01", "이용자01", "4321", "2002/12/31", "01071409360", "서울시 마포구 숭문16길 28", "ddswlstj@naver.com");
		userVO02 = new User("user02", "이용자02", "4321", "2002/12/30", "01071409360",  "서울시 마포구 숭문16길 28", "ddswlstj@naver.com");
		userVO03 = new User("user03", "이용자03", "4321", "2002/12/29", "01071409360",  "서울시 마포구 숭문16길 28", "ddswlstj@naver.com");

		search = new Search();
	}

	
	@Test
	public void addAndGet() throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ addAndGet()                  │");
		log.debug("└──────────────────────────────┘");

		// 1. 등록
		// 2. 한건조회
		// 3. 비교

		// 1건 등록
		int flag = userMapper.doSave(userVO01);
		log.debug("flag :" + flag);
		assertEquals(1, flag);

		User outVO = userMapper.doSelectOne(userVO01);
		assertNotNull(outVO);// return User Null check
		isSameUser(userVO01, outVO);

		// 2번째 User
		flag = userMapper.doSave(userVO02);
		assertEquals(1, flag);

		User outVO02 = userMapper.doSelectOne(userVO02);
		assertNotNull(outVO02);
		isSameUser(userVO02, outVO02);

		// 3번째 User
		flag = userMapper.doSave(userVO03);
		assertEquals(1, flag);

		User outVO03 = userMapper.doSelectOne(userVO03);
		assertNotNull(outVO03);
		isSameUser(userVO03, outVO03);

	}

	public void isSameUser(User userVO, User outVO) {
		assertEquals(userVO.getUserId(), outVO.getUserId());
		assertEquals(userVO.getName(), outVO.getName());
		assertEquals(userVO.getPassword(), outVO.getPassword());
		assertEquals(userVO.getBirthday(), outVO.getBirthday());
		// 2024-07-03 추가
		assertEquals(userVO.getPhone(), outVO.getPhone());
		assertEquals(userVO.getLocation(), outVO.getLocation());
		assertEquals(userVO.getEmail(), outVO.getEmail());
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
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