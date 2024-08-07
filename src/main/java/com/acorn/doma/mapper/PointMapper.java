package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Point;
@Mapper
public interface PointMapper extends WorkDiv<Point> {
	
	int dataInsert(Point inVO) throws SQLException;
	
	int doDeleteAll() throws SQLException;
	
	int countAll() throws SQLException;
	
	List<Point> fullTableScan() throws SQLException;
}
