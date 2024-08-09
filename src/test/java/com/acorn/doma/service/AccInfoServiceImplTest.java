package com.acorn.doma.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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
import com.acorn.doma.domain.Accident;
import com.acorn.doma.mapper.AccMapper;
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class AccInfoServiceImplTest implements PLog{
	
	@Autowired
	ApplicationContext context;
	
	@Autowired
	AccInfoService accInfoService;
	
	@Autowired
	AccMapper accMapper;
	
	Accident accident;
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ setUp()                              │");
		log.debug("└──────────────────────────────────────┘");
		accident = new Accident();
		accInfoService.insertAccidentData();
		accMapper.countAll();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ tearDown()                           │");
		log.debug("└──────────────────────────────────────┘");
		
	}
//	@Ignore
	@Test
	public void doSelectOne() throws Exception{
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ doSelectOne()                        │");
		log.debug("└──────────────────────────────────────┘");
		accident.setAccId("887084"); //db에 실제 값을 받아야 됨.
		Accident outVO =  accInfoService.doSelectOne(accident);
		assertNotNull(outVO);
		
	}
	@Ignore
	@Test
	public void fullTableScan() throws Exception{
		log.debug("┌─────────────────────────────────────────────────────────");
		log.debug("│ fullTableScan()");
		log.debug("└─────────────────────────────────────────────────────────");
		int flag = accMapper.countAll();
		log.debug("flag : " + flag);
		
		List<Accident> list = accInfoService.fullTableScan();
		log.debug("┌ list ┐");
		for(Accident acc : list) {
			log.debug("│ "+ acc);
		}
		log.debug("└ ");
		
	}
	@Ignore
	@Test
	public void Retrieve() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ Retrieve()                   │");
		log.debug("└──────────────────────────────┘");
		List<Accident> A01List = accInfoService.A01Retrieve();
		List<Accident> A02List = accInfoService.A04Retrieve();
		List<Accident> A04List = accInfoService.A04Retrieve();
		List<Accident> A11List = accInfoService.A04Retrieve();

		for(Accident acc : A01List) {
			log.debug("A01List"+ acc);
		}
		for(Accident acc : A02List) {
			log.debug("A02List"+ acc);
		}
		for(Accident acc : A04List) {
			log.debug("A04List"+ acc);
		}
		for(Accident acc : A11List) {
			log.debug("A11List"+ acc);
		}
	}
	
	@Ignore
	@Test
	public void testInsertAccidentData() throws Exception{
		accInfoService.insertAccidentData();
		accMapper.countAll();
	}
	@Ignore
	@Test
	public void test() {
		log.debug("┌──────────────────────────────────────┐");
		log.debug("│ beans()                              │");
		log.debug("└──────────────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("accInfoService:" + accInfoService);
		
		assertNotNull(context);
		assertNotNull(accInfoService);
	}

}
