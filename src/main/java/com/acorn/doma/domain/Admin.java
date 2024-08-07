package com.acorn.doma.domain;

import com.acorn.doma.cmn.DTO;

/**
 * Admin 도메인 클래스
 * Board와 User 정보를 포함하는 도메인 클래스
 */
public class Admin extends DTO {

    // Board 관련 필드
    private int boardSeq;
    private String boardDiv;
    private String boardTitle;
    private String boardRegId;
    private String boardModId;
    private String boardContent;
    private String boardImgLink;
    private String boardRegDt;
    private String boardModDt;
    private int boardViews;
    private String boardGname;

    // User 관련 필드
    private String userId;
    private String userName;
    private String userPw;
    private String userEmail;
    private String userBirth;
    private int userGrade; // 0 : 관리자, 1 : 사용자
    private String userAddress;
    private String userDetailAddress;
    private String userRegDt;

    // 기본 생성자
    public Admin() {
        super();
    }

    // 생성자
    public Admin(int boardSeq, String boardDiv, String boardTitle, String boardRegId, String boardModId,
                 String boardContent, String boardImgLink, String boardRegDt, String boardModDt,
                 int boardViews, String boardGname, String userId, String userName, String userPw,
                 String userEmail, String userBirth, int userGrade, String userAddress,
                 String userDetailAddress, String userRegDt) {
        super();
        this.boardSeq = boardSeq;
        this.boardDiv = boardDiv;
        this.boardTitle = boardTitle;
        this.boardRegId = boardRegId;
        this.boardModId = boardModId;
        this.boardContent = boardContent;
        this.boardImgLink = boardImgLink;
        this.boardRegDt = boardRegDt;
        this.boardModDt = boardModDt;
        this.boardViews = boardViews;
        this.boardGname = boardGname;
        this.userId = userId;
        this.userName = userName;
        this.userPw = userPw;
        this.userEmail = userEmail;
        this.userBirth = userBirth;
        this.userGrade = userGrade;
        this.userAddress = userAddress;
        this.userDetailAddress = userDetailAddress;
        this.userRegDt = userRegDt;
    }

    // Getter and Setter Methods
    public int getBoardSeq() {
        return boardSeq;
    }

    public void setBoardSeq(int boardSeq) {
        this.boardSeq = boardSeq;
    }

    public String getBoardDiv() {
        return boardDiv;
    }

    public void setBoardDiv(String boardDiv) {
        this.boardDiv = boardDiv;
    }

    public String getBoardTitle() {
        return boardTitle;
    }

    public void setBoardTitle(String boardTitle) {
        this.boardTitle = boardTitle;
    }

    public String getBoardRegId() {
        return boardRegId;
    }

    public void setBoardRegId(String boardRegId) {
        this.boardRegId = boardRegId;
    }

    public String getBoardModId() {
        return boardModId;
    }

    public void setBoardModId(String boardModId) {
        this.boardModId = boardModId;
    }

    public String getBoardContent() {
        return boardContent;
    }

    public void setBoardContent(String boardContent) {
        this.boardContent = boardContent;
    }

    public String getBoardImgLink() {
        return boardImgLink;
    }

    public void setBoardImgLink(String boardImgLink) {
        this.boardImgLink = boardImgLink;
    }

    public String getBoardRegDt() {
        return boardRegDt;
    }

    public void setBoardRegDt(String boardRegDt) {
        this.boardRegDt = boardRegDt;
    }

    public String getBoardModDt() {
        return boardModDt;
    }

    public void setBoardModDt(String boardModDt) {
        this.boardModDt = boardModDt;
    }

    public int getBoardViews() {
        return boardViews;
    }

    public void setBoardViews(int boardViews) {
        this.boardViews = boardViews;
    }

    public String getBoardGname() {
        return boardGname;
    }

    public void setBoardGname(String boardGname) {
        this.boardGname = boardGname;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPw() {
        return userPw;
    }

    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserBirth() {
        return userBirth;
    }

    public void setUserBirth(String userBirth) {
        this.userBirth = userBirth;
    }

    public int getUserGrade() {
        return userGrade;
    }

    public void setUserGrade(int userGrade) {
        this.userGrade = userGrade;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserDetailAddress() {
        return userDetailAddress;
    }

    public void setUserDetailAddress(String userDetailAddress) {
        this.userDetailAddress = userDetailAddress;
    }

    public String getUserRegDt() {
        return userRegDt;
    }

    public void setUserRegDt(String userRegDt) {
        this.userRegDt = userRegDt;
    }

    @Override
    public String toString() {
        return "Admin [boardSeq=" + boardSeq + ", boardDiv=" + boardDiv + ", boardTitle=" + boardTitle +
               ", boardRegId=" + boardRegId + ", boardModId=" + boardModId + ", boardContent=" + boardContent +
               ", boardImgLink=" + boardImgLink + ", boardRegDt=" + boardRegDt + ", boardModDt=" + boardModDt +
               ", boardViews=" + boardViews + ", boardGname=" + boardGname + ", userId=" + userId + 
               ", userName=" + userName + ", userPw=" + userPw + ", userEmail=" + userEmail + 
               ", userBirth=" + userBirth + ", userGrade=" + userGrade + ", userAddress=" + userAddress +
               ", userDetailAddress=" + userDetailAddress + ", userRegDt=" + userRegDt + "]";
    }
}
