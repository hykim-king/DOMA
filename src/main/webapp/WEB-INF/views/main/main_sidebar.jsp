	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap.css">
<link rel="stylesheet" href="${CP}/resources/css/main/main_emergency_info.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<title>Insert title here</title>
</head>
<body>
		<div class="map-fn-l-box" style="float : left">
	        <a href="/doma/main/emergency.do" class="fn-alert" title="돌발">
	            <span class="blind">돌발</span>
	        </a>
	        <a href="/doma/main/freezing.do" class="fn-freezing" title="결빙">
	            <span class="blind">결빙</span>    
	        </a> 
	        <a href="/doma/main/point.do" class="fn-freezing" title="결빙">
	            <span class="blind">사고다발</span>    
	        </a>   
	    </div>	    