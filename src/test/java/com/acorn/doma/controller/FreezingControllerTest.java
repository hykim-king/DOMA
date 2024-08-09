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

//	@Ignore
	@Test
    public void testFreezing() throws Exception {
        List<String> years = Arrays.asList("2018", "2019", "2020", "2021", "2022", "2023");

        MockHttpServletRequestBuilder requestBuilder = 
        		MockMvcRequestBuilders.get("/freezing/freezing.do")
                .param("years", years.toArray(new String[0])); // "years" 파라미터 설정

        ResultActions resultActions = mockMvc.perform(requestBuilder)
                .andExpect(status().is2xxSuccessful()); // HTTP 2xx 상태 응답 기대
        
        // 결과 출력 및 모델 데이터 검증
        MvcResult mvcResult = resultActions.andDo(print()).andReturn();
        Map<String, Object> modelMap = mvcResult.getModelAndView().getModel();

        // 모델 데이터 검증 예시 (필요한 대로 수정)
        List<Map<String, Object>> freezingData = (List<Map<String, Object>>) modelMap.get("freezingData");
        assertNotNull(freezingData);
        assertFalse(freezingData.isEmpty());
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
