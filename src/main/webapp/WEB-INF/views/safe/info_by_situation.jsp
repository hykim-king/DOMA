<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<body>
	<div class="pageDiv">
 		<h2 class="pageH2">상황별 안전 정보</h2>
 		<hr>
 		<c:forEach var="situation" items="${list30}">
	 		<ul class="ui_section">
				<li id="situation_seq_${situation.seq}" style="display: hidden; border : 0px;" data-value="${situation.seq}"></li>
				<li class="img_section">
					<img src="${CP }/resources/img/safe_img/${situation.imgLink}" style="width:100%; height:100%;">
				</li>
				<li class="title_section">${situation.title }</li>
			</ul>
 		</c:forEach>
 	</div>