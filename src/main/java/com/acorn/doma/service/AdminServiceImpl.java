package com.acorn.doma.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Admin;
import com.acorn.doma.mapper.AdminMapper;

@Service("adminServiceImpl")
public class AdminServiceImpl implements AdminService, PLog {

    @Autowired
    private AdminMapper adminMapper;

    public AdminServiceImpl() {}

    // 공지사항 관련 메서드
    @Override
    public List<Admin> getNotices(Search search) throws SQLException {
        log.debug("1. param :" + search);
        return adminMapper.getNotices(search);
    }

    @Override
    public int insertNotice(Admin admin) throws SQLException {
        log.debug("1. param :" + admin);
        return adminMapper.insertNotice(admin);
    }

    @Override
    public int updateNotice(Admin admin) throws SQLException {
        log.debug("1. param :" + admin);
        return adminMapper.updateNotice(admin);
    }

    @Override
    public int deleteNotice(Admin admin) throws SQLException {
        log.debug("1. param :" + admin);
        return adminMapper.deleteNotice(admin);
    }

    @Override
    public Admin getNoticeById(int seq) throws SQLException {
        log.debug("1. param :" + seq);
        return adminMapper.getNoticeById(seq);
    }

    // 회원 관리 관련 메서드
    @Override
    public List<Admin> getUsers(Search search) throws SQLException {
        log.debug("1. param :" + search);
        return adminMapper.getUsers(search);
    }

    @Override
    public int updateUser(Admin admin) throws SQLException {
        log.debug("1. param :" + admin);
        return adminMapper.updateUser(admin);
    }

    @Override
    public int deleteUser(Admin admin) throws SQLException {
        log.debug("1. param :" + admin);
        return adminMapper.deleteUser(admin);
    }

    @Override
    public Admin getUser(String userId) throws SQLException {
        log.debug("1. param :" + userId);
        return adminMapper.getUser(userId);
    }

    @Override
    public int insertUser(Admin admin) throws SQLException {
        log.debug("1. param :" + admin);
        return adminMapper.insertUser(admin);
    }

    @Override
    public Integer getLastInsertedSeq() throws SQLException {
        return adminMapper.getLastInsertedSeq();
    }

    // WorkDiv에서 상속받은 메서드
    @Override
    public List<Admin> doRetrieve(DTO search) throws SQLException {
        return getUsers((Search) search);
    }

    @Override
    public int doUpdate(Admin inVO) throws SQLException {
        return updateUser(inVO);
    }

    @Override
    public int doDelete(Admin inVO) throws SQLException {
        return deleteUser(inVO);
    }

    @Override
    public int doSave(Admin inVO) throws SQLException {
        return insertUser(inVO);
    }

    @Override
    public Admin doSelectOne(Admin inVO) throws SQLException, NullPointerException {
        return getUser(inVO.getUserId());
    }
}
