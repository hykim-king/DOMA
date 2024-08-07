package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.Search;
import com.acorn.doma.domain.Board;

@Mapper
public interface AdminMapper {

    /**
     * 공지사항 목록 조회
     * @param search 검색 조건
     * @return 공지사항 목록
     * @throws SQLException
     */
    List<Board> getNotices(Search search) throws SQLException;

    /**
     * 공지사항 등록
     * @param board 공지사항 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int insertNotice(Board board) throws SQLException;

    /**
     * 공지사항 수정
     * @param board 공지사항 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int updateNotice(Board board) throws SQLException;

    /**
     * 공지사항 삭제
     * @param board 공지사항 객체
     * @return 성공 여부
     * @throws SQLException
     */
    int deleteNotice(Board board) throws SQLException;

    /**
     * 공지사항 단건 조회
     * @param board 공지사항 객체
     * @return 공지사항 객체
     * @throws SQLException
     */
    Board getNotice(Board board) throws SQLException;
}
