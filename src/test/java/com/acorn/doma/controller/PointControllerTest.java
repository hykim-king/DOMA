package com.acorn.doma.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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
import com.acorn.doma.domain.Point;
import com.acorn.doma.mapper.PointMapper;
import com.acorn.doma.service.PointService;
import com.fasterxml.jackson.databind.ObjectMapper;
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) // 알파벳 순서로 테스트 메서드 실행
public class PointControllerTest implements PLog{
	@Autowired
	WebApplicationContext webApplicationContext;
	MockMvc mockMvc;
	@Autowired
	PointService pointService;
	@Autowired
	PointMapper pointMapper;
	
	Point point;
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		point = new Point();
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	@Test
	public void getPointsByYearAndGu() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ getPointsByYearAndGu()       │");
		log.debug("└──────────────────────────────┘");
		 // Mock data
        String year = "2021";
        String guList = "강남구,강동구";
        MockHttpServletRequestBuilder requestBuilder =
        		MockMvcRequestBuilders.get("/point/yearguSelect.do")
        		.param("year",year)
        		.param("guList", guList);
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
