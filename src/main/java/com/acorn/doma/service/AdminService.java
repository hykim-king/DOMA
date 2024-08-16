package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Admin;

public interface AdminService extends WorkDiv<Admin>{

	
    // 공지사항 관련 메서드
    List<Admin> getNotices(Search search) throws SQLException;

    int insertNotice(Admin admin) throws SQLException;

    int updateNotice(Admin admin) throws SQLException;

    int deleteNotice(Admin admin) throws SQLException;

    Admin getNoticeById(int seq) throws SQLException;
    
    int getNoticeCount(Search search) throws SQLException;

    // 회원 관리 관련 메서드
    List<Admin> getUsers(Search search) throws SQLException;

    int updateUser(Admin admin) throws SQLException;

    Admin getUser(String userId) throws SQLException;

    int insertUser(Admin admin) throws SQLException;

    Integer getLastInsertedSeq() throws SQLException;

	int getUsersCount(Search search) throws SQLException;

	int deleteUser(Admin admin) throws SQLException;
}