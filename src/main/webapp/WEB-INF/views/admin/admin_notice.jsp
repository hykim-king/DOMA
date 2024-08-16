<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DOMA</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
    <script src="<%=request.getContextPath()%>/resources/js/admin/admin.js"></script>
    <link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/img/pcon.png">
</head>
<body>
    <%@ include file="/WEB-INF/views/template/header.jsp" %>

    <main class="main-content">
        <h1>공지사항</h1>
        <div class="admin-actions">
            <a href="<%=request.getContextPath()%>/admin/adminuser.do" class="admin-action-button">회원관리</a>
        </div>

        <div class="member-management">
            <div class="box member-list">
                <h2>공지사항 목록</h2>
                <div class="search-container">
                    <input type="text" id="searchWord" class="search-input" placeholder="공지사항 검색">
                    <input type="hidden" id="pageSize" value="5">
                    <button class="search-button" onclick="handleSearch()">검색</button>
                </div>
                <table class="member-table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>제목</th>
                            <th>내용</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody id="list-container">
                        <!-- 공지사항 항목이 이곳에 추가됩니다. -->
                    </tbody>
                </table>

                <!-- 페이징 섹션 -->
                <div class="pagination" id="pagination-container">
                    <!-- 페이지 버튼은 JavaScript에서 동적으로 생성됩니다. -->
                </div>
            </div>
            <div class="box member-info">
                <h2>공지사항</h2>
                <form class="member-form">
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" id="title" name="title" placeholder="">
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label>
                        <textarea id="content" name="content" placeholder=""></textarea>
                    </div>
                    <div class="form-buttons">
                        <button type="button" class="member-action-button" data-action="create" onclick="submitNotice()">등록</button>
                        <button type="button" class="member-action-button" data-action="update" onclick="handleUpdate()">수정</button>
                        <button type="button" class="member-action-button" data-action="delete" onclick="handleDelete()">삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/template/footer.jsp" %>
</body>
</html>
