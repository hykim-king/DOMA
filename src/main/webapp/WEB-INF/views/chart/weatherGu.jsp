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
 
<body>

      <div class="center-content">
        <h1>구별 기상상태와 부상자 수</h1>
        
   <!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
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