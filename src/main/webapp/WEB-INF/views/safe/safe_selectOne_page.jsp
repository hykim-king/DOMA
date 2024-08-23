<%@page import="com.acorn.doma.domain.User"%>
<%@ page import="com.acorn.doma.cmn.StringUtil"%>
<%@ page import="com.acorn.doma.cmn.Search"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="${CP }/resources/css/bootstrap/simplemde.min.css">
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
body {
    font-family: 'Nanum Gothic', sans-serif;
    color: #333;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

header, footer {
    background-color: #fff;
    border-bottom: 1px solid #ddd;
}

.post {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    height : auto;
}

.post-title {
    font-weight: bold;
    font-size: 24px;
    color: #333;
    margin-top: 5px;
}

.post-content {
    font-size: 16px;
    color: #555;
}

.post-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.post-author {
    margin: 0;
    font-size: 14px;
    color: #555;
}

.post-date {
    margin: 0;
    font-size: 14px;
    color: #777;
}

.comments {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.comment-form {
    margin-bottom: 20px;
}

.comment-form label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.comment-form textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.comment-form button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 10px;
}

.comment-form button:hover {
    background-color: #0056b3;
}

.comment-list {
    margin-top: 20px;
}

.comment {
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
}

.comment p {
    margin: 0;
}

.comment strong {
    color: #007bff;
}
</style>
<title>DOMA</title>
</head>
<body>
	<input type="hidden" name="seq"    id="seq" value="${info.seq}">
    <input type="hidden" name="div"    id="div" value="${info.getDiv()}">
	<div class="container">
		<div class="d-flex align-items-center justify-content-between">
	    <h2 class="mb-0"></h2>
	    <c:choose>
		<c:when test="${user ne null}">
			<c:choose>
				<c:when test="${user.grade == 0}">
				<div class="d-flex" style="margin-bottom : 10px;">
			        <input type="button" value="목록" onclick="moveToList()" class="btn btn-secondary me-2">
			        <input type="button" value="수정" onclick="updatePage()" class="btn btn-dark me-2">
			        <input type="button" value="삭제" onclick="doDelete()" class="btn btn-dark me-2">
			    </div>
				</c:when>
				<c:when test="${user.grade == 1}">
				<div class="d-flex" style="margin-bottom : 10px;">
			        <input type="button" value="목록"onclick="moveToList()" class="btn btn-secondary me-2">
			    </div>
				</c:when>
			</c:choose>
		</c:when>
		<c:otherwise>
			<div class="d-flex" style="margin-bottom : 10px;">
		       <input type="button" value="목록" onclick="moveToList()" class="btn btn-secondary me-2">
		    </div>
		</c:otherwise>
	</c:choose>
	</div>
		<article class="post">
			<h2 id="title" class="post-title">${info.title}</h2>
			<div class="post-meta">
				<p id="userId" class="post-author">작성자: ${info.userId}</p>
				<p class="post-date">${info.regDt}</p>
			</div>
			<hr>
			<div id="content" class="post-content">
				<p>${info.content}</p>
				<c:forEach var="imgLink" items="${imgLinks}">
					<img style="width:100%;" src="${CP}/resources/img/safe_img/${imgLink }">
				</c:forEach>
			</div>
		</article>
	</div>
</body>
<script src="${CP }/resources/js/safeInfoPage/safe_selectOne_page.js"></script>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
