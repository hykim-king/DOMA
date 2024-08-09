package com.acorn.doma.dao;

import static org.junit.Assert.*;

import java.math.BigDecimal;
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
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Freezing;
import com.acorn.doma.mapper.FreezingMapper;
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class FreezingMapperTest implements PLog{
	@Autowired
	ApplicationContext context;
	@Autowired
	FreezingMapper freezingMapper;
	Freezing freezing01;
	Freezing freezing02;
	Freezing freezing03;
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
		freezing01 = new Freezing("1", "1111010300", "2024", 1, 1, 1, 1, 1, 1, 1, 1, "poly", "accPoint");
		freezing02 = new Freezing("2", "1111010300", "2023", 1, 1, 1, 1, 1, 1, 1, 1, "poly", "accPoint");
		freezing03 = new Freezing("3", "1111010300", "2022", 1, 1, 1, 1, 1, 1, 1, 1, "poly", "accPoint");
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}
//	@Ignore
	@Test
	public void sqlAll() throws Exception{
		log.debug("┌──────────────────────────────┐");
		log.debug("│ sqlAll()                     │");
		log.debug("└──────────────────────────────┘");
		freezingMapper.doDeleteAll();
		int flag = freezingMapper.dataInsert(freezing01);
		assertEquals(1, flag);
		flag =freezingMapper.dataInsert(freezing02);
		assertEquals(1, flag);
		flag =freezingMapper.dataInsert(freezing03);
		assertEquals(1, flag);
		
		List<Freezing> allData = freezingMapper.selectAllData();
		
		assertNotNull(allData);
		
		String fid = freezing01.getFid();
		Freezing outVO = freezingMapper.selectFreezingDataById(fid);
		assertNotNull(outVO);
		List<Integer> years = Arrays.asList(2024, 2023, 2022); // Specify the years you want to test
		List<Map<String, Object>> freezingData = freezingMapper.selectYearData(years);
		assertNotNull(freezingData);
	    assertFalse(freezingData.isEmpty());
	 // Check the results for each year
	    Map<String, Object> data2024 = freezingData.stream()
	        .filter(data -> 2024 == ((BigDecimal) data.get("YEAR")).intValue())
	        .findFirst()
	        .orElse(null);
	    assertNotNull(data2024);
	    assertEquals(2024,((BigDecimal) data2024.get("YEAR")).intValue());
	    
	    Map<String, Object> data2023 = freezingData.stream()
	        .filter(data -> 2023 == ((BigDecimal) data.get("YEAR")).intValue())
	        .findFirst()
	        .orElse(null);
	    assertNotNull(data2023);
	    assertEquals(2023, ((BigDecimal) data2023.get("YEAR")).intValue());

	    Map<String, Object> data2022 = freezingData.stream()
	        .filter(data -> 2022 == ((BigDecimal) data.get("YEAR")).intValue())
	        .findFirst()
	        .orElse(null);
	    assertNotNull(data2022);
	    assertEquals(2022, ((BigDecimal) data2022.get("YEAR")).intValue());
		 
		 
	}


	@Ignore
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		log.debug("freezingMapper:" + freezingMapper);

		assertNotNull(context);
		assertNotNull(freezingMapper);
	}

}
