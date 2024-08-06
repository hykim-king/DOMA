package com.acorn.doma.dao;

import static org.junit.Assert.*;

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
public class AccMapperTest implements PLog{
	@Autowired
	ApplicationContext context;

	@Autowired
	AccMapper accMapper;
	
	Accident acc;
	Accident acc01;
	Accident accidentSelect01;
	
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		acc = new Accident("1111", "A01", "12B01", "강남 한복판에서 현석이형이..", "2024-08-06", "11:30:00", "2024-08-06", "11:30:00", 11, 11);
		acc01 = new Accident("1111", "A01", "교통사고", "12B01","제보", "강남 한복판에서 현석이형이..", "2024-08-06", "11:30:00", "2024-08-06", "11:30:00", 11, 11);
		accidentSelect01 = new Accident();
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
	
	@Ignore
	@Test
	public void fullTableScan() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ fullTableScan()              │");
		log.debug("└──────────────────────────────┘");
		
		List<Accident> accList = accMapper.fullTableScan();
		
		log.debug("┌ list ");
		for(Accident acc : accList) {
			log.debug("│ "+ acc);
		}
		log.debug("└ ");
	}
	
	@Ignore
	@Test
	public void dataInsert() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ dataInsert()                 │");
		log.debug("└──────────────────────────────┘");
		int flag = accMapper.dataInsert(acc);
		assertEquals(1, flag);
	}
	@Ignore
	@Test
	public void doDeletaAll() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ dataInsert()                 │");
		log.debug("└──────────────────────────────┘");
		int flag = accMapper.doDeleteAll();
		assertEquals(0, flag);
	}
	@Ignore
	@Test
	public void sqlAll() throws Exception{
		int flag = accMapper.countAll();
		log.debug("count(*): "+flag);
		
		accidentSelect01.setAccId("983182");
		
		accMapper.doSelectOne(accidentSelect01);
		List<Accident> list = accMapper.fullTableScan();
		
	}
	@Ignore
	@Test
	public void countAll() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ countAll()                   │");
		log.debug("└──────────────────────────────┘");
		int flag = accMapper.countAll();
		log.debug("count(*): "+flag);
	}
	
	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("accMapper:" + accMapper);

		assertNotNull(context);
		assertNotNull(accMapper);
	}

}
