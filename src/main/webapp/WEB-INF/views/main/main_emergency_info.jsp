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
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="map-fn-l-box">
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
    <div id="subMap" style="height : 815px; float: left;">
		<section id="mapContainer" style="width:1181px; height:815px; position: inherit;">
			<div class="aside">
				<div class="asideContent">
					<h2 class="돌발정보"></h2>
					<div class="searchResult" style="margin-bottom : 10px;">
						<ul>
							<li>
								<div class="position">
									<a>위치</a>
								</div>
								<div class="position_info">
									<table>
										<colgroup>
											<col>
											<col>
										</colgroup>
										<tbody>
											<tr>
												<th>기간</th>
												<td>오늘부터 내일까지</td>
											</tr>
											<tr>
												<th>돌발유형</th>
												<td>차량고장</td>
											</tr>
											<tr>
												<th>도로</th>
												<td>용산대로</td>
											</tr>
											<tr>
												<th>통제여부</th>
												<td>부분 통제</td>
											</tr>
											<tr>
												<th>통제여부</th>
												<td>부분 통제</td>
											</tr>
											<tr>
												<td>용산대로에서 차량고장으로 인한 차막힘</td>
											</tr>
										</tbody>
									</table>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</section>
</div>
<jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
    