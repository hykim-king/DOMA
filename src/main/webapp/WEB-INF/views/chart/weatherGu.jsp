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
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOMA</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<link rel="stylesheet" href="${CP}/resources/css/chart/chart.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script src="${CP}/resources/js/chart/weatherGu.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
        /* CSS 스타일 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .chart-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
        }
        .chart-wrapper {
            flex: 1;
            min-width: 300px;
            max-width: 600px;
            height: 500px;
        }
        #guSelection {
            margin: 20px 0;
        }
        #guDropdown {
            width: 100%;
            height: 200px;
            overflow-y: auto;
        }
        #loadChartButton {
            width: 100%;
            height: 35px;
            font-weight: bold;
            border: 2px solid black;
            cursor: pointer;
        }
        .button-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }
        .showChartsButton {
            flex: 1;
            min-width: 150px;
            height: 35px;
            font-weight: bold;
            border: 2px solid black;
            cursor: pointer;
            text-align: center;
            background-color: #f8f9fa;
        }
        .showChartsButton:hover {
            background-color: #e2e6ea;
        }
    </style>
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
<body>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

    
    <!-- 버튼 컨테이너 -->
    <div class="button-container">
        <button class="showChartsButton">월별 교통사고</button>
        <button class="showChartsButton">요일별 교통사고</button>
        <button class="showChartsButton">시간대별 교통사고</button>
        <button class="showChartsButton">주야별 교통사고</button>
        <button class="showChartsButton">사고유형별 교통사고</button>
        <button class="showChartsButton">사고종류별 교통사고</button>
        <button class="showChartsButton">시군구별 교통사고</button>
        <button class="showChartsButton">연도별 기상사고</button>
        <button class="showChartsButton">연도별 기상사고 발생 빈도</button>
        <button class="showChartsButton">시군구별 기상상태와 부상자 수</button>
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
    <div id="chartContainer1" style="height: 500px; margin: 0 auto;"></div>
    <div id="chartContainer2" style="height: 500px; margin: 0 auto;"></div>
    
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>