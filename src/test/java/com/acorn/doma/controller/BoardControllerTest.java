package com.acorn.doma.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;
import java.util.Map;

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
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.domain.Board;
import com.acorn.doma.service.BoardService;
import com.google.gson.Gson;
import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.mapper.BoardMapper;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class BoardControllerTest implements PLog {

	@Autowired
	WebApplicationContext webApplicationContext;
	
	
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	BoardService boardService;
	
	//브라우저 대신 Mock
	MockMvc mockMvc;
	
	Board board01;
	Board board02;
	Board board03;

	Search search;
	
	static class Response {
		Board board;
		Message message;
	}
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		boardMapper.deleteAll();
		
		board01 = new Board(1,"10","구_01","제목_01","admin","admin","내용_01","1111","사용안함","사용안함",0);
		board02 = new Board(2,"10","구_02","제목_02","admin","admin","내용_02","1111","사용안함","사용안함",0);
		board03 = new Board(3,"10","구_03","제목_03","admin","admin","내용_03","1111","사용안함","사용안함",0);

		search = new Search();
		
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	
	@Ignore
	@Test
	public void doUpdate() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ *doUpdate()*              │");
		log.debug("└───────────────────────────┘");
		
		//한건 등록 : 단독으로 돌게 하기 위해서 등록한다
		int flag = boardMapper.doSave(board01);
		log.debug("flag:" + flag);
		assertEquals(1, flag);
		
		int seq = boardMapper.getSequence();
		log.debug("seq:" + seq);
		board01.setSeq(seq);
		
		Board selectOneVO = boardMapper.doSelectOne(board01);
		
		MockHttpServletRequestBuilder requestBuilder 
		= MockMvcRequestBuilders.post("/board/doUpdate.do")
		.param("seq", selectOneVO.getSeq()+"")
		.param("div", selectOneVO.getDiv())
		.param("title", selectOneVO.getTitle()+"_U")
		.param("userId", selectOneVO.getUserId())
		.param("modId", selectOneVO.getModId())
		.param("content", selectOneVO.getContent()+"_U")
		.param("imgLink", selectOneVO.getImgLink())
		.param("views", selectOneVO.getViews()+"")
		.param("gname", selectOneVO.getGname())
		;
		
		//호출 및 결과
		ResultActions resultActions = mockMvc.perform(requestBuilder)
				//Controller produces = "text/plain;charset=UTF-8" 
				.andExpect(MockMvcResultMatchers.content().contentType("text/plain;charset=UTF-8"))
				//Web상태
				.andExpect(status().is2xxSuccessful());
		
		//json문자열
		String jsonResult = resultActions.andDo(print())
							.andReturn()
							.getResponse().getContentAsString()
							;
		
		log.debug("┌──────────────────────────────┐");
		log.debug("│ jsonResult:" + jsonResult      );
		log.debug("└──────────────────────────────┘");
		
		//json 문자열을 Message로 변환
		Message resultMessage = new Gson().fromJson(jsonResult, Message.class);
		
		//비교
		assertEquals(1, resultMessage.getMessageId());
		assertEquals(board01.getTitle() + "_U님이 수정 되었습니다.", resultMessage.getMessageContents());
		
	}
	
	//@Ignore
	@Test
	public void doRetrieve() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ *doRetrieve()*            │");
		log.debug("└───────────────────────────┘");
		
		//다건 데이터 입력
		boardMapper.multipleSave();
		
		search.setPageNo((1));
		search.setPageSize(10);
		search.setDiv("");
		
		//1.url, param 설정
		MockHttpServletRequestBuilder requestBuilder 
			= MockMvcRequestBuilders.get("/board/doRetrieve.do")
			.param("searchDiv", search.getSearchDiv())
			.param("searchWord", search.getSearchWord())
			.param("pageSize", search.getPageSize()+"")
			.param("pageNo", search.getPageNo()+"")
			.param("div", search.getDiv())
			;
		
		//2. 호출
		//호출 및 결과
		ResultActions resultActions = mockMvc.perform(requestBuilder)
				.andExpect(status().is2xxSuccessful());
		
		//Model
		MvcResult mvcResult = resultActions.andDo(print()).andReturn();
		
		Map<String, Object> modelMap = mvcResult.getModelAndView().getModel();
		
		List<Board> list = (List<Board>) modelMap.get("list");
		
		for(Board vo :list) {
			log.debug(vo);
		}
		
		int totalCnt = (Integer)modelMap.get("totalCnt");
		String viewName = mvcResult.getModelAndView().getViewName();
		
		assertEquals(202, totalCnt);
		assertEquals("board/board_list", viewName);
		
	}
	
	@Ignore
	@Test
	public void doDelete() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ *doDelete()*              │");
		log.debug("└───────────────────────────┘");
		
		//한건 등록
		int flag = boardMapper.doSave(board01);
		log.debug("flag:" + flag);
		assertEquals(1, flag);
		
		int seq = boardMapper.getSequence();
		log.debug("seq:" + seq);
		board01.setSeq(seq);
		
		//삭제
		MockHttpServletRequestBuilder requestBuilder 
				= MockMvcRequestBuilders.get("/board/doDelete.do")
				.param("seq", board01.getSeq()+"")
				.param("userId", board01.getUserId())
				;
		
		//호출 및 결과
		ResultActions resultActions = mockMvc.perform(requestBuilder)
		.andExpect(MockMvcResultMatchers.content().contentType("text/plain;charset=UTF-8"))
		.andExpect(status().is2xxSuccessful());
		
		//3.JSON -> Message
		String jsonResult = resultActions.andDo(print())
							.andReturn()
							.getResponse().getContentAsString()
							;
		
		log.debug("┌──────────────────────────────┐");
		log.debug("│ jsonResult:" + jsonResult      );
		log.debug("└──────────────────────────────┘");
		
		//json 문자열을 message로 변환
		Message resultMessage = new Gson().fromJson(jsonResult, Message.class);
		
		//비교
		assertEquals(1, resultMessage.getMessageId());
		assertEquals(board01.getSeq() + "이 삭제 되었습니다.", resultMessage.getMessageContents());
		
	}
	
	@Ignore
	@Test
	public void doSelectOne() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doSelectOne()             │");
		log.debug("└───────────────────────────┘");
		
		//한건 등록
		int flag = boardMapper.doSave(board01);
		log.debug("flag:" + flag);
		assertEquals(1, flag);
		
		int seq = boardMapper.getSequence();
		log.debug("seq:" + seq);
		board01.setSeq(seq);
		
		//1. url, param 설정
		MockHttpServletRequestBuilder requestBuilder 
				= MockMvcRequestBuilders.get("/board/doSelectOne.do")
				.param("seq", board01.getSeq()+"")
				.param("userId", board01.getUserId())
				;

		//호출 및 결과 
		ResultActions resultActions = mockMvc.perform(requestBuilder)
				.andExpect(MockMvcResultMatchers.content().contentType("text/plain;charset=UTF-8"))			
				.andExpect(status().is2xxSuccessful());		
		
		String jsonResult = resultActions.andDo(print())
				.andReturn()
				.getResponse().getContentAsString()
				;
		
		log.debug("┌──────────────────────────────┐");
		log.debug("│ jsonResult:" + jsonResult      );
		log.debug("└──────────────────────────────┘");
		
		//Gson 객체 생성
		Gson gson = new Gson();
		
		//전체 JSON 파싱
		Response response = gson.fromJson(jsonResult, Response.class);
		
		//message 객체 추출
		Message message = response.message;
		
		//Board 객체 추출
		Board board = response.board;
		
		//message 객체 출력
		log.debug("Message:" + message);
		log.debug("Board:" + board);
		
		assertEquals(1, message.getMessageId());
		assertEquals(board.getTitle() + "이 조회 되었습니다.", message.getMessageContents());
		
		isSameBoard(board, board01);
	}
	
	public void isSameBoard(Board boardIn, Board boardOut) {
		assertEquals(boardIn.getSeq(), boardOut.getSeq());
		assertEquals(boardIn.getDiv(), boardOut.getDiv());
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
	public void doSave() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doSave()                  │");
		log.debug("└───────────────────────────┘");
		
		//board01 = new Board(1,"10","구_01","제목_01","admin","admin","내용_01","1111","사용안함","사용안함",0);
		MockHttpServletRequestBuilder requestBuilder 
		= MockMvcRequestBuilders.post("/board/doSave.do")
		.param("div", board01.getDiv())
		.param("gname", board01.getGname())
		.param("title", board01.getTitle())
		.param("userId", board01.getUserId())
		.param("content", board01.getContent())
		.param("imgLink", board01.getImgLink())
		;
		
		//호출 및 결과
		ResultActions resultActions = mockMvc.perform(requestBuilder)
				//Controller produces = "text/plain;charset=UTF-8" 
				.andExpect(MockMvcResultMatchers.content().contentType("text/plain;charset=UTF-8"))
				//Web상태
				.andExpect(status().is2xxSuccessful());
		
		//json문자열
		String jsonResult = resultActions.andDo(print())
							.andReturn()
							.getResponse().getContentAsString()
							;
		
		log.debug("┌──────────────────────────────┐");
		log.debug("│ jsonResult:" + jsonResult      );
		log.debug("└──────────────────────────────┘");
		
		//json 문자열을 Message로 변환
		Message resultMessage = new Gson().fromJson(jsonResult, Message.class);
		
		//비교
		assertEquals(1, resultMessage.getMessageId());
		assertEquals(board01.getTitle() + "님이 등록 되었습니다.", resultMessage.getMessageContents());

	}
		
	@Ignore
	@Test
	public void test() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("==webApplicationContext==  :  " + webApplicationContext);
		log.debug("==mockMvc==  :  " + mockMvc);
		
		assertNotNull(webApplicationContext);
		assertNotNull(mockMvc);
		assertNotNull(boardMapper);
		assertNotNull(boardService);
	}

}
