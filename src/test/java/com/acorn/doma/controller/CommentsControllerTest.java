package com.acorn.doma.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.controller.BoardControllerTest.Response;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Comments;
import com.acorn.doma.mapper.CommentsMapper;
import com.google.gson.Gson;


@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class CommentsControllerTest implements PLog {

	@Autowired
	WebApplicationContext webApplicationContext;
	
	@Autowired
	CommentsMapper commentsMapper;
	
	//브라우저 대신 Mock
	MockMvc mockMvc;
	
	Search search;
	
	Comments comments;
	Comments comments01;
	Comments comments02;
	Comments comments03;
	
	static class Response {
		Comments comments;
		Message message;
	}
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		
		commentsMapper.deleteAll();
		
		comments01 = new Comments(1, 1, "admin", "admin", "내용", "사용안함", "사용안함");
		comments02 = new Comments(2, 1, "admin", "admin", "내용", "사용안함", "사용안함");
		comments03 = new Comments(3, 1, "admin", "admin", "내용", "사용안함", "사용안함");
		
		commentsMapper.deleteAll();
		
		search = new Search();
		
		comments = new Comments();
		
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
    public void doRetrieve() throws Exception {
		// 저장
        commentsMapper.doSave(comments01);
        commentsMapper.doSave(comments02);
        commentsMapper.doSave(comments03);
		
        search.setSeq(1);
        search.setSearchWord("내용");

        List<Comments> outVO = 	commentsMapper.commentsList(1);
		assertNotNull(outVO);
    }
	
	@Ignore
	@Test
	public void doUpdate() throws Exception {
	    //저장
	    int flag = commentsMapper.doSave(comments01);
	    log.debug("flag : " + flag);
	    assertEquals(1, flag);

	    //등록 seq조회
	    int comSeq = commentsMapper.getSequence();
	    log.debug("comSeq : " + comSeq);
	    comments01.setComSeq(comSeq);

	    //단건 조회
	    Comments outVO01 = commentsMapper.doSelectOne(comments01);
	    log.debug("outVO01 : " + outVO01);
	    assertNotNull(outVO01);

	    //업데이트 코멘트
	    String updateStr = "_U";
	    outVO01.setModId("admin");
	    outVO01.setComments(outVO01.getComments() + updateStr);

	    flag = commentsMapper.doUpdate(outVO01);
	    log.debug("flag : " + flag);
	    assertEquals(1, flag);

	    Comments outVO01Update = commentsMapper.doSelectOne(outVO01);
	    log.debug("outVO01Update : " + outVO01Update);
	    assertNotNull(outVO01Update);

	    isSameComments(outVO01Update, outVO01);
	}
	
	@Ignore
	@Test
	public void doSelectOne() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doSelectOne()             │");
		log.debug("└───────────────────────────┘");
		
		//한건 등록
		int flag = commentsMapper.doSave(comments01);
		log.debug("flag:" + flag);
		assertEquals(1, flag);
		
		int seq = commentsMapper.getSequence();
		log.debug("seq:" + seq);
		comments01.setSeq(seq);
		
		//1. url, param 설정
		MockHttpServletRequestBuilder requestBuilder 
				= MockMvcRequestBuilders.get("/comments/doSelectOne.do")
				.param("ComSeq", comments01.getComSeq()+"")
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
		Comments comments = response.comments;
		
		//message 객체 출력
		log.debug("Message:" + message);
		log.debug("Comments:" + comments);
		
		assertEquals(1, message.getMessageId());
		assertEquals(comments.getComSeq() + "이 조회 되었습니다.", message.getMessageContents());
		
		isSameComments(comments, comments01);
	}
	
	//@Ignore
	@Test
	public void commentsDelete() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ *commentsDelete()*        │");
		log.debug("└───────────────────────────┘");
		
		//한건 등록
		int flag = commentsMapper.doSave(comments01);
		log.debug("flag:" + flag);
		assertEquals(1, flag);
		
		int comSeq = commentsMapper.getSequence();
		log.debug("comSeq:" + comSeq);
		comments01.setComSeq(comSeq);
		
		//삭제
		MockHttpServletRequestBuilder requestBuilder 
				= MockMvcRequestBuilders.get("/board/commentsDelete.do")
				.param("comSeq", comments01.getComSeq()+"")
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
		assertEquals(comments01.getComSeq() + "이 삭제 되었습니다.", resultMessage.getMessageContents());
		
	}
	
	@Ignore
	@Test
	public void doDelete() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ *doDelete()*              │");
		log.debug("└───────────────────────────┘");
		
		//한건 등록
		int flag = commentsMapper.doSave(comments01);
		log.debug("flag:" + flag);
		assertEquals(1, flag);
		
		int comSeq = commentsMapper.getSequence();
		log.debug("comSeq:" + comSeq);
		comments01.setComSeq(comSeq);
		
		//삭제
		MockHttpServletRequestBuilder requestBuilder 
				= MockMvcRequestBuilders.get("/board/doDelete.do")
				.param("comSeq", comments01.getComSeq()+"")
				.param("userId", comments01.getUserId())
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
		assertEquals(comments01.getComSeq() + "이 삭제 되었습니다.", resultMessage.getMessageContents());
		
	}
	
	@Ignore
	@Test
	public void doSave() throws Exception {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doSave()                  │");
		log.debug("└───────────────────────────┘");
		
		MockHttpServletRequestBuilder requestBuilder 
		= MockMvcRequestBuilders.post("/comments/doSave.do")
		.param("comSeq", comments01.getComSeq() + "")
		.param("seq", comments01.getSeq() + "")
		.param("userId", comments01.getUserId())
		.param("modId", comments01.getModId())
		.param("comments", comments01.getComments())
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
		assertEquals(comments01.getUserId() + "님이 등록 되었습니다.", resultMessage.getMessageContents());
		
	}
	
	@Ignore
	@Test
	public void addAndGet() throws Exception {
		
		//comment01-----------------------
		int flag = commentsMapper.doSave(comments01);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		int comSeq = commentsMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comments01.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO01 = commentsMapper.doSelectOne(comments01);
		log.debug("outVO01 : " + outVO01);
		assertNotNull(outVO01);
		

		
		//comment02-----------------------
		flag = commentsMapper.doSave(comments02);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		comSeq = commentsMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comments02.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO02 = commentsMapper.doSelectOne(comments01);
		log.debug("outVO02 : " + outVO02);
		assertNotNull(outVO02);
		

		
		
		//comment03-----------------------
		flag = commentsMapper.doSave(comments03);
		log.debug("flag : " + flag);
		assertEquals(1, flag);
		
		// 등록 seq조회 : 등록 당시에는 SEQ를 알지 못함
		comSeq = commentsMapper.getSequence();
		log.debug("comSeq : " + comSeq);
		comments03.setComSeq(comSeq);
		
		// 단건 조회
		Comments outVO03 = commentsMapper.doSelectOne(comments01);
		log.debug("outVO03 : " + outVO03);
		assertNotNull(outVO03);

		
		// 단건 삭제
		flag = commentsMapper.doDelete(outVO01);
		assertEquals(1, flag);
	}
	
	public void isSameComments(Comments commentsIn, Comments commentsOut) {
		assertEquals(commentsIn.getComSeq(), commentsOut.getComSeq());
		assertEquals(commentsIn.getSeq(), commentsOut.getSeq());
		assertEquals(commentsIn.getUserId(), commentsOut.getUserId());
		assertEquals(commentsIn.getModId(), commentsOut.getModId());
		assertEquals(commentsIn.getComments(), commentsOut.getComments());
	}

	@Ignore
	@Test
	public void test() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("==webApplicationContext==  :  " + webApplicationContext);
		
		assertNotNull(webApplicationContext);
	}

}
