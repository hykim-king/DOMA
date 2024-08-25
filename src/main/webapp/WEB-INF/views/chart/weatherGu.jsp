<%--
/**
	Class Name:
	Description:
	Author : user
	Modification information
	
	수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 8. 19        최초작성 
    
    author eclass 개발팀
    since 2024.07.18
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOMA</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<link rel="stylesheet" href="${CP}/resources/css/main/main_info.css">
<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<link rel="stylesheet" href="${CP}/resources/css/chart/chart.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script src="${CP}/resources/js/chart/weatherGu.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<!-- Highcharts more modules (including bubble chart) -->
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/treemap.js"></script>
<!-- Highcharts modules for exporting and accessibility (optional) -->
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>  
  <script>
  let gname = []; // 초기 구 배열 설정
  $(document).ready(function() {
	  gname = [];

      // 버튼 클릭 이벤트 핸들러
      $('.gu-button').click(function() {
          const value = $(this).data('value'); // 클릭된 버튼의 값
          const index = gname.indexOf(value);
          
          if (index === -1) {
              // 배열에 값이 없으면 추가
              gname.push(value);
              $(this).addClass('active');
          } else {
              // 배열에 값이 있으면 제거
              gname.splice(index, 1);
              $(this).removeClass('active');
          }
          
          console.log('Updated gname array:', gname); // 배열 업데이트 로그
      });

      // 차트 로드 버튼 클릭 이벤트 핸들러
      $('#loadChartButton').click(function() {
          if (gname.length < 3) {
              alert('최소 3개 구를 선택해야 합니다.');
              return;
          }
          
          loadChartData();
      });
  });
 </script>
 <style>
    /* 기존 스타일 유지 */
    .gu-selection {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }

    .form-select {
        width: 150px; /* 너비 조정 */
        height: auto; /* 높이 자동 조정 */
        max-height: 200px; /* 최대 높이 설정 */
        overflow-y: auto; /* 세로 스크롤 추가 */
        margin-bottom: 10px; /* 버튼과의 간격 조정 */
        box-sizing: border-box; /* 패딩과 테두리를 포함한 크기 설정 */
    }

    .btn-dark {
        width: 150px; /* 버튼 너비 설정 */
        box-sizing: border-box; /* 패딩과 테두리를 포함한 크기 설정 */
    }

    /* 차트 컨테이너 스타일 추가 */
    .chart-row {
        display: flex;
        flex-wrap: wrap;
        gap: 15px; /* 차트 간의 간격 조정 */
        margin-bottom: 20px; /* 차트와 다른 요소 간의 간격 조정 */
    }

    .chart-item {
        flex: 1; /* 차트 아이템의 너비를 자동으로 조정 */
        min-width: 0; /* 차트 아이템의 최소 너비를 설정 */
        height: 300px; /* 차트 아이템의 높이 설정 */
        max-height: 400px; /* 차트 아이템의 최대 높이 설정 */
        box-sizing: border-box; /* 패딩과 테두리를 포함한 크기 설정 */
        background-color: #f8f9fa; /* 배경색 설정 */
        border: 1px solid #dee2e6; /* 테두리 설정 */
        border-radius: 0.375rem; /* 테두리 반경 설정 */
    }
</style>
</head>
 <body>

<div class="container mt-4">
    <h1 class="text-center mb-4">구별 기상상태와 부상자 수</h1>
   <!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
    <!-- 구 선택 및 조회 버튼 -->
   <div class="row">
    <div class="col-md-3">
    <div class="gu-selection">
	        <h3>구 선택</h3>
	        <div id="guButtons" class="btn-container">
	            <!-- 첫 번째 줄 13개의 버튼 -->
	            <div class="btn-row">
	                <button class="btn btn-outline-primary gu-button" data-value="강남구">강남구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="강동구">강동구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="강북구">강북구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="강서구">강서구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="관악구">관악구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="광진구">광진구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="구로구">구로구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="금천구">금천구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="노원구">노원구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="도봉구">도봉구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="동대문구">동대문구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="동작구">동작구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="마포구">마포구</button>
	            </div>
	            <!-- 두 번째 줄 12개의 버튼 -->
	            <div class="btn-row">
	                <button class="btn btn-outline-primary gu-button" data-value="서대문구">서대문구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="서초구">서초구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="성동구">성동구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="성북구">성북구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="송파구">송파구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="양천구">양천구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="영등포구">영등포구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="용산구">용산구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="은평구">은평구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="종로구">종로구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="중구">중구</button>
	                <button class="btn btn-outline-primary gu-button" data-value="중랑구">중랑구</button>
	            </div>
	        </div>
	        <!-- 조회 버튼 -->
	        <div class="text-center mt-3">
	            <button id="loadChartButton" class="btn btn-dark">조회</button>
	        </div>
	    </div>
	</div>

	        <!-- 차트 컨테이너 -->
	<div class="col-md-9">
	    <div class="chart-row">
	        <div id="chartContainer1" class="chart-item"></div>
	        <div id="chartContainer2" class="chart-item"></div>
	    </div>
	    <div class="chart-row">
	        <div id="chartContainer3" class="chart-item"></div>
	        <div id="chartContainer4" class="chart-item"></div>
	    </div>
	</div>
        
    </div>
</div>

<%@ include file="/WEB-INF/views/template/footer.jsp" %> 

</body>
</html>