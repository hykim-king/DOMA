package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.acorn.doma.domain.Weather;

@Mapper
public interface WeatherMapper {

    // 연도에 따른 날씨 데이터 조회
    List<Map<String, Object>> getWeatherDataByYear(@Param("year") int year) throws SQLException;

    // 연도별 날씨 조건 발생 빈도
    List<Map<String, Object>> weatherFreqByYear() throws SQLException;

    // 연도별 부상자 수 합산이 가장 많은 구 상위 5개
    List<Map<String, Object>> top5InjuryByRegion() throws SQLException;

    // 선택한 구에서 기상상태별 부상자 수
    List<Map<String, Object>> injuryByWeatherConditionForGnames(@Param("gname") List<String> gname) throws SQLException;

}
