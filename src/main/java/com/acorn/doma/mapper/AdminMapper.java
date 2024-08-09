package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Admin;

@Mapper
public interface AdminMapper {

    // 공지사항 관련 메서드
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
     * @param seq 공지사항 ID
     * @return 공지사항 객체
     * @throws SQLException
     */
    Admin getNoticeById(int seq) throws SQLException;

    // 회원 관리 관련 메서드
    /**
     * 회원 목록 조회
     * @param search 검색 조건
     * @return 회원 목록
     * @throws SQLException
     */
    List<Admin> getUsers(Search search) throws SQLException;

    /**
     * 회원 수정
     * @param admin 회원 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int updateUser(Admin admin) throws SQLException;

    /**
     * 회원 삭제
     * @param admin 회원 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int deleteUser(Admin admin) throws SQLException;

    /**
     * 회원 단건 조회
     * @param admin 회원 객체
     * @return 회원 객체
     * @throws SQLException
     */
    Admin getUser(String userId) throws SQLException;

    /**
     * 가장 최근에 삽입된 시퀀스 값을 조회
     * @return 가장 최근의 시퀀스 값
     * @throws SQLException
     */
    int insertUser(Admin admin) throws SQLException;

    /**
     * 가장 최근에 삽입된 시퀀스 값을 조회
     * @return 가장 최근의 시퀀스 값
     * @throws SQLException
     */
    Integer getLastInsertedSeq() throws SQLException;    
}
