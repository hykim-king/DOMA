<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<body>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="${CP}/resources/css/main/main_emergency_info.css">
<div id="detailInfo" style="width : 520px; height:800px; display:none; overflow:scroll">
	<h2 id="yearH2" style="width:300px; font-wight : bold; text-align : center; border: 3px solid black;"></h2>
	<select name="gnameDiv" class="form-select" id="gnameDiv" style="width:300px;">
        <option value="">전체</option>
	</select>
	<ul id="detail_info" class="info_ul">
	</ul>
</div>
