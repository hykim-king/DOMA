package com.acorn.doma.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Death;
@Mapper
public interface DeathMapper extends WorkDiv<Death> {
	int countAll() throws SQLException;
}
