package com.pcwk.ehr.mapper;

import java.sql.SQLException;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.user.domain.User;

@Mapper
public interface UserMapper extends WorkDiv<User> {

	
}
