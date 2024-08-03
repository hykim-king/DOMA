<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DOMA</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
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
                    <input type="text" class="search-input" placeholder="회원 정보 검색">
                    <button class="search-button">검색</button>
                </div>
                <table class="member-table">
                    <thead>
                        <tr>
                            <th>회원 ID</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>가입일</th>
                            <th>등급</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 빈 행 5개 추가 -->
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                <!-- 페이징 섹션 -->
                <div class="pagination">
                    <button class="page-button" data-page="prev">이전</button>
                    <button class="page-button" data-page="1">1</button>
                    <button class="page-button" data-page="2">2</button>
                    <button class="page-button" data-page="3">3</button>
                    <button class="page-button" data-page="next">다음</button>
                </div>
            </div>
            <div class="box member-info">
                <h2>상세정보</h2>
                <form class="member-form">
                    <div class="form-group">
                        <label for="memberId">회원 ID</label>
                        <input type="text" id="memberId" name="memberId" placeholder="회원 ID" readonly>
                    </div>
                    <div class="form-group">
                        <label for="name">이름</label>
                        <input type="text" id="name" name="name" placeholder="이름">
                    </div>
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="email" placeholder="e-mail">
                    </div>
                    <div class="form-group">
                        <label for="address">주소</label>
                        <input type="text" id="address" name="address" placeholder="주소">
                    </div>
                    <div class="form-group">
                        <label for="detailAddress">상세주소</label>
                        <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
                    </div>
                    <div class="form-group">
                        <label for="birthdate">생년월일</label>
                        <input type="text" id="birthdate" name="birthdate" placeholder="생년월일">
                    </div>
                    <div class="form-group">
                        <label for="joinDate">가입일</label>
                        <input type="text" id="joinDate" name="joinDate" placeholder="가입일">
                    </div>
                    <div class="form-group">
                        <label for="grade">등급</label>
                        <select id="grade" name="grade">
                            <option value="super_admin">Super Admin</option>
                            <option value="content_admin">Content Admin</option>
                            <option value="user">User</option>
                        </select>
                    </div>
                    <div class="form-buttons">
                        <button type="submit" class="member-action-button" data-action="update">수정</button>
                        <button type="submit" class="member-action-button" data-action="delete">삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/template/footer.jsp" %>
</body>
</html>
