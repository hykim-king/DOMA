package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Death;
import com.acorn.doma.mapper.DeathMapper;
import com.acorn.doma.mapper.WeatherMapper;

@Controller
@RequestMapping("chart")
public class ChartController implements PLog{

    @Autowired
    private DeathMapper deathMapper;
    @Autowired
    private WeatherMapper weatherMapper;
    //월별
    @GetMapping("/chartMonth.do")
    public String showChartPage() {
    	String viewName = "/chart/chartMonth";
    	log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName:"+viewName);                                 
        log.debug("└──────────────────────────────────────────┘");
        
        return viewName;
    }
    
    @GetMapping(value="/chartData1.do")
    @ResponseBody
    public List<Map<String, Object>> getChartData() throws SQLException {
    	
        Death inVO = new Death();
        List<Map<String, Object>> deathData = deathMapper.MonthDead(inVO);
        List<Map<String, Object>> casualtiesData = deathMapper.MonthCasualties(inVO);
        List<Map<String, Object>> seriouslyData = deathMapper.MonthSeriously(inVO);

        
        for (int i = 0; i < deathData.size(); i++) {
            deathData.get(i).put("TOTAL_CASUALTIES", casualtiesData.get(i).get("TOTAL_CASUALTIES"));
            deathData.get(i).put("TOTAL_SERIOUSLY", seriouslyData.get(i).get("TOTAL_SERIOUSLY"));
        }
        
        return deathData;
    }
    
    
    //요일별
    @GetMapping("/chartWeek.do")
    public String showChartPage1() {
    	String viewName = "/chart/chartWeek";
    	log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName:"+viewName);                                 
        log.debug("└──────────────────────────────────────────┘");
        
        return viewName;
    }
    
    @GetMapping(value="/chartData2.do")
    @ResponseBody
    public List<Map<String, Object>> chartWeek() throws SQLException {
        Death inVO = new Death();
        
        // 데이터 조회
        List<Map<String, Object>> deathData = deathMapper.WeekDead(inVO);
        List<Map<String, Object>> casualtiesData = deathMapper.WeekCasualties(inVO);
        List<Map<String, Object>> seriouslyData = deathMapper.WeekSeriously(inVO);

        // 요일별 데이터를 매핑하기 위한 맵 생성
        Map<String, Map<String, Object>> dataMap = new LinkedHashMap<>();

        // 사망자 데이터를 데이터 맵에 추가
        for (Map<String, Object> item : deathData) {
            String dayWeek = (String) item.get("DAY_WEEK");
            Map<String, Object> dayData = dataMap.computeIfAbsent(dayWeek, k -> new HashMap<>());
            dayData.put("TOTAL_DEATHS", item.get("TOTAL_DEATHS"));
        }

        // 부상자 데이터를 데이터 맵에 추가
        for (Map<String, Object> item : casualtiesData) {
            String dayWeek = (String) item.get("DAY_WEEK");
            Map<String, Object> dayData = dataMap.computeIfAbsent(dayWeek, k -> new HashMap<>());
            dayData.put("TOTAL_CASUALTIES", item.get("TOTAL_CASUALTIES"));
        }

        // 중상자 데이터를 데이터 맵에 추가
        for (Map<String, Object> item : seriouslyData) {
            String dayWeek = (String) item.get("DAY_WEEK");
            Map<String, Object> dayData = dataMap.computeIfAbsent(dayWeek, k -> new HashMap<>());
            dayData.put("TOTAL_SERIOUSLY", item.get("TOTAL_SERIOUSLY"));
        }

        // 결과 리스트 생성
        List<Map<String, Object>> result = new ArrayList<>();
        for (Map.Entry<String, Map<String, Object>> entry : dataMap.entrySet()) {
            Map<String, Object> dayData = new HashMap<>();
            dayData.put("DAY_WEEK", entry.getKey());
            dayData.putAll(entry.getValue());
            result.add(dayData);
        }

        return result;
    }
    
    
    //시간대별
    @GetMapping("/chartHour.do")
    public String showHourChartPage() {
        String viewName = "/chart/chartHour"; // JSP 페이지의 경로
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);
        log.debug("└──────────────────────────────────────────┘");

        return viewName;
    }

    @GetMapping(value="/chartData3.do")
    @ResponseBody
    public List<Map<String, Object>> chartHour() throws SQLException {
        Death inVO = new Death();
        List<Map<String, Object>> deathData = deathMapper.HourDead(inVO);
        List<Map<String, Object>> casualtiesData = deathMapper.HourCasualties(inVO);
        List<Map<String, Object>> seriouslyData = deathMapper.HourSeriously(inVO);

        // 시간별 데이터 매핑을 위한 맵 생성
        Map<String, Map<String, Object>> dataMap = new LinkedHashMap<>();

        // 사망자 데이터를 데이터 맵에 추가
        for (Map<String, Object> item : deathData) {
            String startHour = item.get("START_HOUR").toString();
            String endHour = item.get("END_HOUR").toString();
            String hourRange = startHour + " - " + endHour;
            Map<String, Object> hourData = dataMap.computeIfAbsent(hourRange, k -> new HashMap<>());
            hourData.put("TOTAL_DEATHS", item.get("TOTAL_DEATHS"));
        }

        // 부상자 데이터를 데이터 맵에 추가
        for (Map<String, Object> item : casualtiesData) {
            String startHour = item.get("START_HOUR").toString();
            String endHour = item.get("END_HOUR").toString();
            String hourRange = startHour + " - " + endHour;
            Map<String, Object> hourData = dataMap.computeIfAbsent(hourRange, k -> new HashMap<>());
            hourData.put("TOTAL_CASUALTIES", item.get("TOTAL_CASUALTIES"));
        }

        // 중상자 데이터를 데이터 맵에 추가
        for (Map<String, Object> item : seriouslyData) {
            String startHour = item.get("START_HOUR").toString();
            String endHour = item.get("END_HOUR").toString();
            String hourRange = startHour + " - " + endHour;
            Map<String, Object> hourData = dataMap.computeIfAbsent(hourRange, k -> new HashMap<>());
            hourData.put("TOTAL_SERIOUSLY", item.get("TOTAL_SERIOUSLY"));
        }

        // 결과 리스트 생성
        List<Map<String, Object>> result = new ArrayList<>();
        for (Map.Entry<String, Map<String, Object>> entry : dataMap.entrySet()) {
            Map<String, Object> hourData = new HashMap<>();
            hourData.put("HOUR_RANGE", entry.getKey());
            hourData.putAll(entry.getValue());
            result.add(hourData);
        }

        return result;
    }
    
    //주야별
    @GetMapping("/chartNight.do")
    public String showNightChartPage() {
        String viewName = "/chart/chartNight";  // JSP 페이지 경로
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                
        log.debug("└──────────────────────────────────────────┘");
        return viewName;
    }

    // 주간 및 야간 데이터 제공 메소드
    @GetMapping("/chartData4.do")
    @ResponseBody
    public Map<String, List<Map<String, Object>>> getNightChartData() throws SQLException {
        Death inVO = new Death();

        // 주간 및 야간 데이터 조회
        List<Map<String, Object>> nightDeadData = deathMapper.NightDead(inVO);
        List<Map<String, Object>> nightCasualtiesData = deathMapper.NightCasualties(inVO);
        List<Map<String, Object>> nightSeriouslyData = deathMapper.NightSeriously(inVO);

        // 로그 추가
        log.debug("Night Dead Data: " + nightDeadData);
        log.debug("Night Casualties Data: " + nightCasualtiesData);
        log.debug("Night Seriously Data: " + nightSeriouslyData);

        // 데이터 조합
        Map<String, List<Map<String, Object>>> response = new HashMap<>();
        response.put("nightDead", nightDeadData);
        response.put("nightCasualties", nightCasualtiesData);
        response.put("nightSeriously", nightSeriouslyData);

        return response;
    }

    //사고유형별
    @GetMapping("/chartMajor.do")
    public String showMajorChartPage() {
        String viewName = "/chart/chartMajor";  // JSP 페이지 경로
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                
        log.debug("└──────────────────────────────────────────┘");
        return viewName;
    }

    // 사고 유형별 데이터 제공 메소드
    @GetMapping("/chartDataMajor.do")
    @ResponseBody
    public Map<String, List<Map<String, Object>>> getMajorChartData() throws SQLException {
        Death inVO = new Death();

        // 사고 유형별 데이터 조회
        List<Map<String, Object>> majorDeadData = deathMapper.MajorDead(inVO);
        List<Map<String, Object>> majorCasualtiesData = deathMapper.MajorCasualties(inVO);
        List<Map<String, Object>> majorSeriouslyData = deathMapper.MajorSeriously(inVO);

        // 데이터 조합
        Map<String, List<Map<String, Object>>> response = new HashMap<>();
        response.put("majorDead", majorDeadData);
        response.put("majorCasualties", majorCasualtiesData);
        response.put("majorSeriously", majorSeriouslyData);

        return response;
    }
    
<<<<<<< HEAD
    @GetMapping("/chartWeatherYear.do")
    public String showWeather1() {
        String viewName = "/chart/weatherYear";  // JSP 페이지 경로
=======
    @GetMapping("/chartMedium.do")
    public String showMediumChartPage() {
        String viewName = "/chart/chartMedium";  // JSP 페이지 경로
>>>>>>> d327c0902ded54db9a99bdba0f67fc625fead6dc
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                
        log.debug("└──────────────────────────────────────────┘");
        return viewName;
    }
<<<<<<< HEAD
    @GetMapping("/getWeatherDataByYear.do")
    @ResponseBody
    public List<Map<String, Object>> getWeatherDataByYear(@RequestParam("year") int year) throws SQLException {
        return weatherMapper.getWeatherDataByYear(year);
    }
    
    @GetMapping("/chartWeatherFreq.do")
    public String showWeather2() {
        String viewName = "/chart/weatherFreq";  // JSP 페이지 경로
=======

    @GetMapping("/chartDataMedium.do")
    @ResponseBody
    public Map<String, List<Map<String, Object>>> getChartDataMedium() throws SQLException {
        Death inVO = new Death(); // 필요한 필드 설정
        List<Map<String, Object>> mediumDead = deathMapper.MediumDead(inVO);
        List<Map<String, Object>> mediumCasualties = deathMapper.MediumCasualties(inVO);
        List<Map<String, Object>> mediumSeriously = deathMapper.MediumSeriously(inVO);

        Map<String, List<Map<String, Object>>> response = new HashMap<>();
        response.put("mediumDead", mediumDead);
        response.put("mediumCasualties", mediumCasualties);
        response.put("mediumSeriously", mediumSeriously);
        return response;
    }


    @GetMapping("/chartGname.do")
    public String showGnameChartPage() {
        String viewName = "/chart/chartGname";  // JSP 페이지 경로
>>>>>>> d327c0902ded54db9a99bdba0f67fc625fead6dc
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                
        log.debug("└──────────────────────────────────────────┘");
        return viewName;
    }
<<<<<<< HEAD
    @GetMapping("/freqByYear.do")
    @ResponseBody
    public List<Map<String, Object>> getWeatherFreqByYear(@RequestParam("year") int year) throws SQLException {
        return weatherMapper.weatherFreqByYear(year);
    }
  
    @GetMapping("/chartWeatherTop5.do")
    public String showWeather3() {
        String viewName = "/chart/weatherTop5";  // JSP 페이지 경로
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                
        log.debug("└──────────────────────────────────────────┘");
        return viewName;
    }
    @GetMapping("/top5Region.do")
    @ResponseBody
    public List<Map<String, Object>> getTop5InjuryByRegion(@RequestParam("year") int year) throws SQLException {
        return weatherMapper.top5InjuryByRegion(year);
    }
  
    @GetMapping("/chartWeatherGuSelect.do")
    public String showWeather4() {
        String viewName = "/chart/weatherGu";  // JSP 페이지 경로
        log.debug("┌──────────────────────────────────────────┐");
        log.debug("│ viewName: " + viewName);                                
        log.debug("└──────────────────────────────────────────┘");
        return viewName;
    }
    @GetMapping("/weatherConditionForGnames.do")
    @ResponseBody
    public List<Map<String, Object>> getInjuryByWeatherConditionForGnames(@RequestParam("gname") List<String> gname) throws SQLException {
        return weatherMapper.injuryByWeatherConditionForGnames(gname);
=======

    @GetMapping("/chartDataGname.do")
    @ResponseBody
    public Map<String, List<Map<String, Object>>> getChartDataGname() throws SQLException {
        Death inVO = new Death(); // 필요한 필드 설정
        List<Map<String, Object>> gnameDead = deathMapper.GnameDead(inVO);
        List<Map<String, Object>> gnameCasualties = deathMapper.GnameCasualties(inVO);
        List<Map<String, Object>> gnameSeriously = deathMapper.GnameSeriously(inVO);

        Map<String, List<Map<String, Object>>> response = new HashMap<>();
        response.put("gnameDead", gnameDead);
        response.put("gnameCasualties", gnameCasualties);
        response.put("gnameSeriously", gnameSeriously);
        return response;
>>>>>>> d327c0902ded54db9a99bdba0f67fc625fead6dc
    }


}
