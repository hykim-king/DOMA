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
	List<Map<String, Object>> MonthCasualties(Death inVO) throws SQLException; 
	List<Map<String, Object>> MonthSeriously(Death inVO) throws SQLException; 
	
	List<Map<String, Object>> WeekDead(Death inVO) throws SQLException; 
	List<Map<String, Object>> WeekCasualties(Death inVO) throws SQLException; 
	List<Map<String, Object>> WeekSeriously(Death inVO) throws SQLException; 
	
	List<Map<String, Object>> HourDead(Death inVO) throws SQLException; 
	List<Map<String, Object>> HourCasualties(Death inVO) throws SQLException; 
	List<Map<String, Object>> HourSeriously(Death inVO) throws SQLException; 
	
	List<Map<String, Object>> NightDead(Death inVO) throws SQLException; 
	List<Map<String, Object>> NightCasualties(Death inVO) throws SQLException; 
	List<Map<String, Object>> NightSeriously(Death inVO) throws SQLException; 
	
	List<Map<String, Object>> MajorDead(Death inVO) throws SQLException; 
	List<Map<String, Object>> MajorCasualties(Death inVO) throws SQLException; 
	List<Map<String, Object>> MajorSeriously(Death inVO) throws SQLException; 
	
	List<Map<String, Object>> MediumDead(Death inVO) throws SQLException; 
	List<Map<String, Object>> MediumCasualties(Death inVO) throws SQLException; 
	List<Map<String, Object>> MediumSeriously(Death inVO) throws SQLException; 
	 
	List<Map<String, Object>> GnameDead(Death inVO) throws SQLException; 
	List<Map<String, Object>> GnameCasualties(Death inVO) throws SQLException; 
	List<Map<String, Object>> GnameSeriously(Death inVO) throws SQLException; 
	
	
}
