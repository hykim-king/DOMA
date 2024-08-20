<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DOMA</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
    <script src="<%=request.getContextPath()%>/resources/js/admin/admin_user.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/script.js"></script>
</head>
<body>
    <%@ include file="/WEB-INF/views/template/header.jsp" %>

    <main class="main-content">
        <h1>회원관리</h1>
        <div class="admin-actions">
            <a href="<%=request.getContextPath()%>/admin/adminnotice.do" class="admin-action-button">공지사항</a>
        </div>

        <!-- 회원 관리 섹션 -->
        <div class="member-management">
            <div class="box member-list">
                <h2>회원목록</h2>
                <div class="search-container">
                    <input type="text" id="searchWord" class="search-input" placeholder="회원 검색">
                    <input type="hidden" id="pageSize" value="5">
                    <button class="search-button" onclick="handleSearch()">검색</button>
                </div>
                <table class="member-table">
                    <thead>
                        <tr>
                            <th>회원 ID</th>
                            <th>이름</th>
                            <th>가입일</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody id="user-container">
                        <!-- 회원 목록이 이곳에 추가됩니다. -->
                    </tbody>
                </table>
                <!-- 페이징 섹션 -->
                <div class="pagination" id="pagination-container">
                    <!-- 페이지 버튼은 JavaScript에서 동적으로 생성됩니다. -->
                </div>
            </div>
            <div class="box member-info">
                <h2>상세정보</h2>
                <form class="member-form">
                    <div class="form-group">
                        <label for="memberId"></label>
                        <input type="text" id="memberId" name="memberId" placeholder="회원 ID" readonly>
                    </div>
                    <div class="form-group">
                        <label for="name"></label>
                        <input type="text" id="name" name="name" placeholder="이름">
                    </div>
                    <div class="form-group">
                        <label for="address"></label>
                        <input type="text" id="address" name="address" placeholder="주소" readonly>
                    </div>
                    <div class="form-group">
                        <label for="detailAddress"></label>
                        <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" readonly>
                    </div>
                    <div class="form-group">
                        <label for="birthdate"></label>
                        <input type="text" id="birthdate" name="birthdate" placeholder="생년월일">
                    </div>
                    <div class="form-group">
                        <label for="joinDate"></label>
                        <input type="text" id="joinDate" name="joinDate" placeholder="가입일" readonly>
                    </div>
                    <div class="form-group">
                        <label for="celdt"></label>
                        <input type="text" id="celdt" name="celdt" placeholder="상태" readonly>
                    </div>
                    <div class="form-buttons">
                        <button type="button" class="member-action-button" data-action="update" onclick="updateUser()">수정</button>
                        <button type="button" class="member-action-button" data-action="delete" onclick="deleteUser()">삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/template/footer.jsp" %>
</body>
</html>
