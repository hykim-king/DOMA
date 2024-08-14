package com.acorn.doma.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.domain.Death;
import com.acorn.doma.mapper.DeathMapper;

@Controller
@RequestMapping("chart")
public class ChartController {

    @Autowired
    private DeathMapper deathMapper;

    @GetMapping("/chart")
    public String showChartPage() {
        return "chartData"; // Returns the chartData.jsp view
    }

    @GetMapping("/chartData.do")
    @ResponseBody
    public List<Map<String, Object>> getChartData() throws SQLException {
        Death inVO = new Death();
        return deathMapper.MonthDead(inVO);
    }
}
