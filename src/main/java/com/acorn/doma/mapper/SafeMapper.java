package com.acorn.doma.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Board;

@Mapper
public interface SafeMapper extends WorkDiv<Board>{
	
}
