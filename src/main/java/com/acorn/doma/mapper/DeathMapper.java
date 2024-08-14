package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Death;
@Mapper
public interface DeathMapper extends WorkDiv<Death> {
	
	int countAll() throws SQLException;
	List<Death> selectTop5AccTypeByGname();
	
	List<Death> deathDayNight();
	int dataInsert(Death inVO) throws SQLException;
	int doDeleteAll() throws SQLException;
	

	//시각화페이지
	List<Map<String, Object>> MonthDead(Death inVO) throws SQLException; 
	
	
}
