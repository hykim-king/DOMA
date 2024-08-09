package com.acorn.doma.service;

import static org.junit.Assert.*;

import java.util.ArrayList;
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
import com.acorn.doma.domain.Code;
import com.acorn.doma.service.CodeService;

@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class CodeServiceImplTest implements PLog {

	@Autowired
	ApplicationContext context;
	
	@Autowired
	CodeService codeService;
	
	Code code;
	
	List<String> codeList;
	
	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ setUp()                              │");
		log.debug("└──────────────────────────────────────┘");
		code = new Code();
		codeList = new ArrayList<String>();
	}

	/**
	 * @throws java.lang.Exception
	 */
	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ tearDown()                           │");
		log.debug("└──────────────────────────────────────┘");
		
	}
	
	//@Ignore
	@Test
	public void doRetrieveIn() throws Exception {
		code.setMstCode("MEMBER_SEARCH");
		code.setMstCode("COM_PAGE_SIZE");
		code.setMstCode("GNAME");

		List<Code> list = this.codeService.doRetrieveIn(codeList);
		
		assertEquals(41, list.size());
	}
	
	@Ignore
	@Test
	public void doRetrieve() throws Exception {
		code.setMstCode("MEMBER_SEARCH");
		
		List<Code> list = this.codeService.doRetrieve(code);
		
		assertEquals(4,  list.size());
		
	}

	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ beans()                              │");
		log.debug("└──────────────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("codeService:" + codeService);
		
		assertNotNull(context);
		assertNotNull(codeService);
	}

}

