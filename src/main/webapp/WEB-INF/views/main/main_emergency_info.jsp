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
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script> 
<title>Insert title here</title>
<style>
    body, html {
        height: 100%;
        margin: 0;
        display: flex;
        flex-direction: column;
    }
    #map {
        width: 800px;
        height: 700px;
        margin: 0 auto;
    }
    .map-fn-i-box{
    	display: inline-block;
	    width: 60px;
    	height: 60px;
    }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="map-fn-i-box">
        <a href="" class="fn-alert" title="돌발">
            <span class="blind">돌발</span>
        </a>    
        <a href="" class="fn-road" title="도로">
            <span class="blind">도로</span> 
        </a>     
        <a href="" class="fn-freezing" title="결빙">
            <span class="blind">결빙</span>    
        </a>  
    </div>
    <div id="subMap" style="height : 815px">
		<section id="mapContainer" style="width:1181px; height:815px;">
			<div class="aside">
				<div class="asideContent">
					<h2 class="돌발정보"></h2>
					<div class="searchResult" style="margin-bottom : 10px;">
						
					</div>
				</div>
			</div>
		<jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
    </div>	