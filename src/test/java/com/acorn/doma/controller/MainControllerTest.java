package com.acorn.doma.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.mapper.AccMapper;
import com.acorn.doma.mapper.FreezingMapper;
import com.acorn.doma.service.AccInfoService;
import com.acorn.doma.service.FreezingService;
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class MainControllerTest implements PLog{
	@Autowired
	WebApplicationContext webApplicationContext;
	MockMvc mockMvc;
	
	@Autowired
	AccInfoService accInfoService;
	
	@Autowired
	FreezingService freezingService;
	
	@Autowired
	AccMapper accMapper;
	@Autowired
	FreezingMapper freezingMapper;
	
	Accident accident01;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		accMapper.doDeleteAll();
		accident01 = new Accident("1112", "A01", "12B01", "강남 한복판에서 현석이형이..", "2024-08-06", "11:30:00", "2024-08-06", "11:30:00", 11, 11);
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
//	@Ignore
	@Test
	public void accIdSelect() throws Exception{
		log.debug("┌───────────────────────────┐");
		log.debug("│ idSelect()                │");
		log.debug("└───────────────────────────┘");
		int flag = accMapper.dataInsert(accident01);
		assertEquals(1, flag);
		
		
		/*
		 * MockHttpServletRequestBuilder requestBuilder =
		 * MockMvcRequestBuilders.get("/main/emergency.do") .param("accId", );
		 */
	}
	@Ignore
	@Test
	public void freezing() throws Exception{
		log.debug("┌───────────────────────────┐");
		log.debug("│ freezing()                │");
		log.debug("└───────────────────────────┘");
		MockHttpServletRequestBuilder requestBuilder 
		= MockMvcRequestBuilders.get("/main/freezing.do");
		
		ResultActions resultActions = mockMvc.perform(requestBuilder)
				//Controller produces = "text/plain;charset=UTF-8" 
				.andExpect(MockMvcResultMatchers.content().contentType("text/plain;charset=UTF-8"))
				//Web상태
				.andExpect(status().is2xxSuccessful());
		
		
		
	}
	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("==webApplicationContext==  :  " + webApplicationContext);
		log.debug("==mockMvc==  :  " + mockMvc);
		assertNotNull(webApplicationContext);
		assertNotNull(mockMvc);
	}

}
