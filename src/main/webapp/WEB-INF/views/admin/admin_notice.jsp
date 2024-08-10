<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DOMA</title>
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
    <script src="${CP }/resources/js/common.js"></script>
    <script src="${CP }/resources/js/jquery_3_7_1.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <main class="main-content">
        <h1>공지사항</h1>
        <div class="admin-actions">
            <a href="<%=request.getContextPath()%>/admin/adminuser.do" class="admin-action-button">회원관리</a>
        </div>

        <!-- 회원 관리 섹션 -->
        <div class="member-management">
            <div class="box member-list">
                <h2>공지사항 목록</h2>
                <div class="search-container">
                    <input type="text" class="search-input" placeholder="공지사항 검색">
                    <button class="search-button">검색</button>
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
                        <button type="submit" class="member-action-button" data-action="create">등록</button>
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
