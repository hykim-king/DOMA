<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<body>
	<div class="pageDiv">
 		<h2 class="pageH2">상황별 안전 정보</h2>
 		<hr>
 		<c:forEach var="situation" items="${list30}">
	 		<ul id="situation_seq" class="ui_section" value="${situation.seq}" onclick="selectOne(this.value)">
	 			<li style="display : hidden; border : 0px;" value="30"></li>
				<li class="img_section">이미지 공사중</li>
				<li class="title_section">${situation.title }</li>
			</ul>
 		</c:forEach>
 	</div>