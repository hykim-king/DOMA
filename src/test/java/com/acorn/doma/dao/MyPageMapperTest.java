package com.acorn.doma.dao;

 
import static org.junit.Assert.assertEquals;

import static org.junit.Assert.assertNotNull;

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
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.User;
import com.acorn.doma.mapper.BoardMapper;
import com.acorn.doma.mapper.UserMapper;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.UserService; 
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

	//─────────────────────매퍼
	@Autowired
	UserMapper userMapper; 
	
	@Autowired
	BoardMapper boardMapper;
	
	//─────────────────────서비스
	@Autowired
	UserService userService;
	
	@Autowired
	BoardService boardService;
	
	
	
	 
	User userVO01; 
	Board boardV001;
	

	Search search;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		userVO01= new User("user2", "user2", "2222", "user2@naver.com", "2002-02-02", 1, "서울 서대문구", "101호", "x"); 
		//userMapper.doDelete(userVO01); 
		
		boardV001 = new Board(10,"10","구20", "제목2", "user1", "user1", "내용2", "이미지2","x", "x", 1);
		
	
		search = new Search();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	
	
	
	
	//게시판 셀렉
	  
	  @Test 
	  public void mpSelect() throws Exception{ 
		  List<Board> list = boardMapper.mpSelect(boardV001); 
		  log.debug("list : " + list); 
	}
	
	
	
	
//	@Ignore
	@Test
	public void mpSelectOne() throws Exception{  
		
		int flag = userMapper.doSave(userVO01);
		log.debug("flag:"+flag);
		assertEquals(1, flag); 
		
		User outVO = userService.mpSelectOne(userVO01);
		log.debug("outVO : " + outVO);
		
	}
//	@Ignore
	@Test
	public void mpGradeUp() throws Exception{
		
		//회원등급 올리는거  
		 
		
		int flag = userMapper.doSave(userVO01);
		assertEquals(1, flag); 	 
		//3
		User outVO = userMapper.mpSelectOne(userVO01);
		log.debug("outVO : " + outVO);
		assertNotNull(outVO);//return User Null check
		isSameUser(userVO01, outVO);
		
		//4
		String updateStr = "_U";
		//이름,비번,생일,등급,로그인, 추천, 이메일
		 
		outVO.setUserName(outVO.getUserName()+updateStr);
		outVO.setUserPw(outVO.getUserPw());
		outVO.setUserEmail(outVO.getUserEmail());
		
		outVO.setBirth(outVO.getBirth());
		outVO.setGrade(outVO.getGrade()+1);
		outVO.setAddress(outVO.getAddress());
		outVO.setDetailAddress(outVO.getDetailAddress());  
		
		flag = userService.doUpdate(outVO);
		flag = userMapper.doUpdate(outVO);
		log.debug("flag:"+flag);
		log.debug("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■");
		log.debug(outVO);
		log.debug("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■");
		assertEquals(1, flag);
		 
		User upOutVO = userMapper.mpSelectOne(outVO); 
		log.debug(upOutVO); 
		assertNotNull(upOutVO);
		
		//6
		isSameUser(upOutVO, outVO);
		
	}	
	 
	
//	@Ignore
	@Test
	public void doUpdate() throws Exception{
		//2. 데이터 1건 입력
		//3. 단건 조회
		//4. 조회 데이터로 데이터 수정및 Update
		//5. 수정데이터 조회
		//6. 비교 
		//2 등록
		 
		
		int flag = userMapper.doSave(userVO01);
		assertEquals(1, flag); 	 
		//3
		User outVO = userMapper.mpSelectOne(userVO01);
		log.debug("outVO : " + outVO);
		assertNotNull(outVO);//return User Null check
		isSameUser(userVO01, outVO);
		
		//4
		String updateStr = "_U";
		//이름,비번,생일,등급,로그인, 추천, 이메일
		 
		outVO.setUserName(outVO.getUserName()+updateStr);
		outVO.setUserPw(outVO.getUserPw());
		outVO.setUserEmail(outVO.getUserEmail());
		
		outVO.setBirth(outVO.getBirth());
		  
		outVO.setAddress(outVO.getAddress());
		outVO.setDetailAddress(outVO.getDetailAddress());  
		
		flag = userService.doUpdate(outVO);
		flag = userMapper.doUpdate(outVO);
		log.debug("flag:"+flag);
		log.debug("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■");
		log.debug(outVO);
		log.debug("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■");
		assertEquals(1, flag);
		 
		User upOutVO = userMapper.mpSelectOne(outVO); 
		log.debug(upOutVO); 
		assertNotNull(upOutVO);
		
		//6
		isSameUser(upOutVO, outVO);
		
	}	
	
	public void isSameUser(User userVO, User outVO) {
		assertEquals(userVO.getUserId(), outVO.getUserId());
		assertEquals(userVO.getUserName(), outVO.getUserName());
		assertEquals(userVO.getUserPw(),outVO.getUserPw());
		assertEquals(userVO.getUserEmail(),outVO.getUserEmail());
		
		assertEquals(userVO.getBirth(),outVO.getBirth());
		assertEquals(userVO.getGrade(),outVO.getGrade());
		assertEquals(userVO.getAddress(),outVO.getAddress());
		assertEquals(userVO.getDetailAddress(),outVO.getDetailAddress());
		 
		
	}
	public void isSameBoard(Board boardIn, Board boardOut) { 
		assertEquals(boardIn.getGname(), boardOut.getGname());
		assertEquals(boardIn.getTitle(), boardOut.getTitle());
		assertEquals(boardIn.getUserId(), boardOut.getUserId());
		assertEquals(boardIn.getModId(), boardOut.getModId());
		assertEquals(boardIn.getContent(), boardOut.getContent());
		assertEquals(boardIn.getImgLink(), boardOut.getImgLink());
		assertEquals(boardIn.getViews(), boardOut.getViews());
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