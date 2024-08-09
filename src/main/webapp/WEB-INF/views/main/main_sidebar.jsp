	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<body>
		<div class="map-fn-l-box" style="diplay : inline-block">
	        <a href="/doma/main/main.do" class="fn-alert" title="돌발">
	            <span class="blind">돌발</span>
	        </a>
	        <a href="/doma/freezing/freezing.do" class="fn-freezing" title="결빙">
	            <span class="blind">결빙</span>    
	        </a> 
	        <a href="/doma/point/point.do" class="fn-freezing" title="사고다발">
	            <span class="blind">사고다발</span>    
	        </a>   
	    </div>	    