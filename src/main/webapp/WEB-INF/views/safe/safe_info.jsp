<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- favicon  --%>
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script> 
<title>Insert title here</title>
</head>
<body>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 <div style="display:flex">
 	<div style="width : 600px; height : 500px;">
 		<!--<c:forEach var="" items="">
		<ul style="display:inline-block">
			<li>이미지</li>
			<li>제목</li>
		</ul>
		</c:forEach>-->
 	</div>
 	<div style="width : 600px; height : 500px;">
 		<ul>
			<li>이미지</li>
			<li>제목</li>
		</ul>
		<ul>
			<li>이미지</li>
			<li>제목</li>
		</ul>
		<ul>
			<li>이미지</li>
			<li>제목</li>
		</ul>
		<ul>
			<li>이미지</li>
			<li>제목</li>
		</ul>
 	</div>
 </div>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>