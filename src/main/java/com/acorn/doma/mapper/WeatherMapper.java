package com.acorn.doma.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Weather;
@Mapper
public interface WeatherMapper extends WorkDiv<Weather> {

}
