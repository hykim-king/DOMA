package com.acorn.doma.dao;

import static org.junit.Assert.assertNotNull;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.mapper.WeatherMapper;
@RunWith(SpringRunner.class) // 스프링 컨텍스트 프레임워크의 JUnit확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })

@FixMethodOrder(MethodSorters.NAME_ASCENDING) //알파벳 순서로 테스트 메서드 실행
public class WeatherMapperTest implements PLog{
	@Autowired
	ApplicationContext context;
	@Autowired
	WeatherMapper weatherMapper;
	@Before
	public void setUp() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ setUp()                      │");
		log.debug("└──────────────────────────────┘");
	}

	@After
	public void tearDown() throws Exception {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ tearDown()                   │");
		log.debug("└──────────────────────────────┘");
	}

	@Test
    public void testAll() throws Exception{
        int year = 2012;

        // Test `getWeatherDataByYear`
        List<Map<String, Object>> weatherData = weatherMapper.getWeatherDataByYear(year);
        assertNotNull(weatherData);
        log.debug("Weather Data by Year: " + weatherData);

        // Test `weatherFreqByYear`
        List<Map<String, Object>> weatherFreq = weatherMapper.weatherFreqByYear(year);
        assertNotNull(weatherFreq);
        log.debug("Weather Frequency by Year: " + weatherFreq);

        // Test `top5InjuryByRegion`
        List<Map<String, Object>> top5Injury = weatherMapper.top5InjuryByRegion(year);
        assertNotNull(top5Injury);
        log.debug("Top 5 Injury by Region: " + top5Injury);

        // Test `injuryByWeatherConditionForRegions`
        List<String> regions = Arrays.asList("은평구", "서대문구");  // 테스트할 지역을 지정
        List<Map<String, Object>> injuryByWeather = weatherMapper.injuryByWeatherConditionForGnames(regions);
        assertNotNull(injuryByWeather);
        log.debug("Injury by Weather Condition for Regions: " + injuryByWeather);

    }
	@Test
	public void beans() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ beans()                      │");
		log.debug("└──────────────────────────────┘");
		log.debug("context:" + context);
		
		assertNotNull(context);
		assertNotNull(weatherMapper);
	}

}
