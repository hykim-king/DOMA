<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<body>
	<div class="pageDiv">
 		<h2 class="pageH2">위급상황 대처방법</h2>
 		<hr>
 		<c:forEach var="acting" items="${list40}">
	 		<ul id="acting_seq" class="ui_section" value="${acting.seq}" onclick="selectOne(this.value)">
	 			<li style="display : hidden; border : 0px;" value="40"></li>
				<li class="img_section">이미지 공사중</li>
				<li class="title_section">${acting.title }</li>
			</ul>
 		</c:forEach>
 	</div>