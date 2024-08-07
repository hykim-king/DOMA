package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Admin;

@Mapper
public interface AdminMapper {

    /**
     * 공지사항 목록 조회
     * @param search 검색 조건
     * @return 공지사항 목록
     * @throws SQLException
     */
    List<Admin> getNotices(Search search) throws SQLException;

    /**
     * 공지사항 등록
     * @param admin 공지사항 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int insertNotice(Admin admin) throws SQLException;

    /**
     * 공지사항 수정
     * @param admin 공지사항 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int updateNotice(Admin admin) throws SQLException;

    /**
     * 공지사항 삭제
     * @param admin 공지사항 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int deleteNotice(Admin admin) throws SQLException;

    /**
     * 공지사항 단건 조회
     * @param admin 공지사항 객체
     * @return 공지사항 객체
     * @throws SQLException
     */
    Admin getNotice(Admin admin) throws SQLException;
}
