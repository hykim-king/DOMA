package com.acorn.doma.domain;

import com.acorn.doma.cmn.DTO;

/**
 * Admin 도메인 클래스
 * Board와 User 정보를 포함하는 도메인 클래스
 */
public class Admin extends DTO {

    // Board 관련 필드
    private int seq; // SEQ
    private String div; // DIV
    private String title; // TITLE
    private String userId; // USER_ID
    private String modId; // MOD_ID
    private String content; // CONTENT
    private String imgLink; // IMG_LINK
    private String regDt; // REG_DT
    private String modDt; // MOD_DT
    private int views; // VIEWS
    private String gname; // GNAME

    // User 관련 필드
    private String userName; // USER_NAME
    private String userPw; // USER_PW
    private String userEmail; // USER_EMAIL
    private String userBirth; // BIRTH
    private int userGrade; // GRADE
    private String userAddress; // ADDRESS
    private String userDetailAddress; // DETAIL_ADDRESS
    private String userRegDt; // REG_DT

    // 기본 생성자
    public Admin() {
        super();
    }

    // 생성자
    public Admin(int seq, String div, String title, String userId, String modId,
                 String content, String imgLink, String regDt, String modDt,
                 int views, String gname, String userName, String userPw,
                 String userEmail, String userBirth, int userGrade, String userAddress,
                 String userDetailAddress, String userRegDt) {
        super();
        this.seq = seq;
        this.div = div;
        this.title = title;
        this.userId = userId;
        this.modId = modId;
        this.content = content;
        this.imgLink = imgLink;
        this.regDt = regDt;
        this.modDt = modDt;
        this.views = views;
        this.gname = gname;
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
    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getDiv() {
        return div;
    }

    public void setDiv(String div) {
        this.div = div;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getModId() {
        return modId;
    }

    public void setModId(String modId) {
        this.modId = modId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImgLink() {
        return imgLink;
    }

    public void setImgLink(String imgLink) {
        this.imgLink = imgLink;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public String getModDt() {
        return modDt;
    }

    public void setModDt(String modDt) {
        this.modDt = modDt;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getGname() {
        return gname;
    }

    public void setGname(String gname) {
        this.gname = gname;
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
        return "Admin [seq=" + seq + ", div=" + div + ", title=" + title +
               ", userId=" + userId + ", modId=" + modId + ", content=" + content +
               ", imgLink=" + imgLink + ", regDt=" + regDt + ", modDt=" + modDt +
               ", views=" + views + ", gname=" + gname + ", userName=" + userName + 
               ", userPw=" + userPw + ", userEmail=" + userEmail + 
               ", userBirth=" + userBirth + ", userGrade=" + userGrade + ", userAddress=" + userAddress +
               ", userDetailAddress=" + userDetailAddress + ", userRegDt=" + userRegDt + "]";
    }
}
