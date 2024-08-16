package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Death;
import com.acorn.doma.mapper.DeathMapper;

@Controller
@RequestMapping("chart")
public class ChartController implements PLog{

    @Autowired
    private DeathMapper deathMapper;

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

}
