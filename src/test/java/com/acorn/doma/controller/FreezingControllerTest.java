package com.acorn.doma.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
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
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Freezing;
import com.acorn.doma.mapper.AccMapper;
import com.acorn.doma.mapper.FreezingMapper;
import com.acorn.doma.service.AccInfoService;
import com.acorn.doma.service.FreezingService;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) // 알파벳 순서로 테스트 메서드 실행
public class FreezingControllerTest implements PLog {
	@Autowired
	WebApplicationContext webApplicationContext;
	MockMvc mockMvc;

	@Autowired
	FreezingService freezingService;

	@Autowired
	FreezingMapper freezingMapper;

	Freezing freezing;

	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		freezing = new Freezing();
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	@Test
	public void allYear() throws Exception{
		MockHttpServletRequestBuilder requestBuilder 
		= MockMvcRequestBuilders.get("/freezing/allYearsSelect.do");
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
	}
//	@Ignore
	@Test
    public void yearSelect() throws Exception {
		String year = "2018";
		freezing.setYear(year);
		MockHttpServletRequestBuilder requestBuilder 
		= MockMvcRequestBuilders.get("/freezing/yearSelect.do")
		.param("year", freezing.getYear());
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

    }
//	@Ignore
	@Test
    public void freezingIdSelect() throws Exception {
        String fid = "6805181";
        freezing.setFid(fid);
        MockHttpServletRequestBuilder requestBuilder 
		= MockMvcRequestBuilders.get("/freezing/idSelect.do")
		.param("fid", freezing.getFid());
		;
		//호출 및 결과
		ResultActions resultActions = mockMvc.perform(requestBuilder)
				.andExpect(status().is2xxSuccessful());
		//Model
		MvcResult mvcResult = resultActions.andDo(print()).andReturn();
		
		Map<String, Object> modelMap = mvcResult.getModelAndView().getModel();
		Freezing outVO = (Freezing) modelMap.get("fidSelect");
		log.debug(outVO);
		
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
