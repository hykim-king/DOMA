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

<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<link rel="stylesheet" href="${CP}/resources/css/chart/chart.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script src="${CP}/resources/js/chart/weatherGu.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script>
 let gname = []; 

 $(document).ready(function() {
     // Initialize gname as an empty array
     gname = []; // 초기값 설정

     // Load Google Charts library
     google.charts.load('current', {'packages':['corechart']});
     
     // Function to handle dropdown selection changes
     function updateGuSelection() {
         const selectedGu = $('#guDropdown').val();

         // Update gname array
         gname = selectedGu;
         
         // Log the updated gname array
         console.log('Updated gname array:', gname);

         // Validate number of selected regions
         if (selectedGu.length < 3 || selectedGu.length > 10) {
             $('#loadChartButton').prop('disabled', true);
             if (selectedGu.length < 3) {
                 $('#loadChartButton').attr('title', '최소 3개 구를 선택해야 합니다.');
             } else if (selectedGu.length > 10) {
                 $('#loadChartButton').attr('title', '최대 10개 구를 선택할 수 있습니다.');
             }
         } else {
             $('#loadChartButton').prop('disabled', false);
             $('#loadChartButton').removeAttr('title');
         }
     }

     // Attach updateGuSelection to dropdown change
     $('#guDropdown').change(updateGuSelection);

     

            

    // Attach loadChartData to button click
    $('#loadChartButton').click(loadChartData);
});
    </script>
</head>
  <style>
		 .center-content {
		    text-align: center;
		    margin: 20px 0;
		}
		
		.button-container {
		    display: flex;
		    justify-content: center;
		    flex-wrap: wrap;
		    margin: 20px 0;
		    gap: 5px; /* 버튼 간의 간격을 5px로 줄임 */
		    width: 100%;
		    max-width: 1200px;
		    margin-left: auto;
		    margin-right: auto;
		}
		
		.button-row {
		    display: flex;
		    justify-content: center;
		    gap: 10px;
		    margin-bottom: 10px;
		    flex-wrap: wrap;
		    width: 100%;
		}
		
		.showChartsButton {
		    padding: 0 20px; /* 패딩을 상하 0, 좌우 20px로 설정 */
		    font-size: 14px;
		    width: 220px; /* 버튼 너비를 220px로 설정 */
		    height: 40px; /* 버튼 높이 */
		    line-height: 40px; /* 높이와 동일하게 설정하여 텍스트 수직 중앙 정렬 */
		    box-sizing: border-box;
		
		    background-color: #ffffff;
		    color: #000000;
		    border: 2px solid #cccccc;
		    border-radius: 15px;
		    text-align: center; /* 텍스트 중앙 정렬 */
		    cursor: pointer; /* 커서를 포인터로 변경 */
		    transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
		}

		/* 마우스 호버 시 스타일 */
		.showChartsButton:hover {
		    background-color: #f0f0f0; /* 호버 시 배경색 */
		    color: #333333; /* 호버 시 텍스트 색상 */
		    border-color: #999999; /* 호버 시 테두리 색상 */
		}
		
		#chartContainer {
		    width: 100%;
		    height: 500px;
		    margin-top: 20px;
		    margin-left: 100px; /* 왼쪽 마진 */
		    margin-right: 100px; /* 오른쪽 마진 */
		    margin-bottom: 40px; /* 아래쪽 마진 */
		}

    </style>
<body>

      <div class="center-content">
        <h1>구별 기상상태와 부상자 수</h1>
        
    <!-- 버튼 컨테이너 -->
    <div class="button-container">
         <div class="button-row">
        <button class="showChartsButton">월별 교통사고</button>
        <button class="showChartsButton">요일별 교통사고</button>
        <button class="showChartsButton">시간대별 교통사고</button>
        <button class="showChartsButton">주야별 교통사고</button>
        <button class="showChartsButton">사고유형별 교통사고</button>
    </div>
    <div class="button-row">
        <button class="showChartsButton">사고종류별 교통사고</button>
        <button class="showChartsButton">구별 교통사고</button>
        <button class="showChartsButton">연도별 기상사고(구)</button>
        <button class="showChartsButton">연도별 기상상태와 부상자 수</button>
        <button class="showChartsButton">구별 기상상태와 부상자 수</button>
    </div>
    </div>
    <!-- 전체 선택 버튼 및 구 선택 드롭다운 -->
   <!-- 구 선택 버튼 및 드롭다운 -->
    <div class="gu-selection" id="guSelection">
        <h3>구 선택</h3>
        <select id="guDropdown" multiple="multiple" size="10">
            <!-- Options for the dropdown -->
            <option value="강남구">강남구</option>
            <option value="강동구">강동구</option>
            <option value="강북구">강북구</option>
            <option value="강서구">강서구</option>
            <option value="관악구">관악구</option>
            <option value="광진구">광진구</option>
            <option value="구로구">구로구</option>
            <option value="금천구">금천구</option>
            <option value="노원구">노원구</option>
            <option value="도봉구">도봉구</option>
            <option value="동대문구">동대문구</option>
            <option value="동작구">동작구</option>
            <option value="마포구">마포구</option>
            <option value="서대문구">서대문구</option>
            <option value="서초구">서초구</option>
            <option value="성동구">성동구</option>
            <option value="성북구">성북구</option>
            <option value="송파구">송파구</option>
            <option value="양천구">양천구</option>
            <option value="영등포구">영등포구</option>
            <option value="용산구">용산구</option>
            <option value="은평구">은평구</option>
            <option value="종로구">종로구</option>
            <option value="중구">중구</option>
            <option value="중랑구">중랑구</option>
        </select>
        <!-- 조회 버튼 -->
        <div style="text-align: center; margin-bottom: 20px;">
            <button id="loadChartButton" style="width: 150px; height: 35px; font-weight: bold; text-align: center; border: 2px solid black;">조회</button>
        </div>
    </div>
    <div id="chartContainer1" style="width: 45%; height: 400px; display: inline-block;"></div>
    <div id="chartContainer2" style="width: 45%; height: 400px; display: inline-block;"></div>
    <div id="chartContainer3" style="width: 45%; height: 400px; display: inline-block;"></div>
    <div id="chartContainer4" style="width: 45%; height: 400px; display: inline-block;"></div>
    <div id="chartContainer5" style="width: 45%; height: 400px; display: inline-block;"></div>
    </div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>