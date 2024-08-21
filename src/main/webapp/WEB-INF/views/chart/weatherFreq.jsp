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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
        <h1>연도별 기상상태와 부상자 수</h1>

    
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
    
    <!-- 차트 컨테이너 -->
    <div id="chartContainer" style="height: 500px; margin: 0 auto;"></div>

    <script>
    $(document).ready(function() {
        // 페이지 로드 후 바로 데이터 요청
        loadChartData();

        function loadChartData() {
            $.ajax({
                url: '${CP}/chart/freqByYear.do', // 데이터 요청 URL
                method: 'GET',
                success: function(response) {
                    console.log(response); // 데이터 확인용
                    drawChart(response); // 차트 그리기
                },
                error: function() {
                    alert('데이터를 가져오는 데 실패했습니다.');
                }
            });
        }

        function drawChart(data) {
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(function() {
                // 데이터 형식을 변환하여 2차원 배열 생성
                var chartDataArray = [];
                
                // 첫 번째 행에 헤더를 추가합니다 (연도, 기상 상태, 부상자 수)
                chartDataArray.push(['Year', '눈', '비', '안개', '흐림']);

                // 연도별로 부상자 수를 모은 객체
                var yearData = {};
                
                // 데이터를 연도별로 기상 상태를 기준으로 부상자 수를 집계
                data.forEach(function(item) {
                    if (!yearData[item.YEAR]) {
                        yearData[item.YEAR] = { '눈': 0, '비': 0, '안개': 0, '흐림': 0 };
                    }
                    yearData[item.YEAR][item.CONDITION] = item.INJURY;
                });

                // 연도별 데이터를 배열로 변환
                for (var year in yearData) {
                    chartDataArray.push([
                        year, 
                        yearData[year]['눈'], 
                        yearData[year]['비'], 
                        yearData[year]['안개'], 
                        yearData[year]['흐림']
                    ]);
                }

                // 구글 차트 데이터 테이블로 변환
                var chartData = google.visualization.arrayToDataTable(chartDataArray);

                // 차트 옵션 설정
                var options = {
                    title: '연도별 기상사고 발생 빈도(log)',
                    hAxis: { title: '연도' },
                    vAxis: { title: '부상자수', scaleType: 'log' }, // 로그 스케일 적용
                    series: {
                        1: { color: '#FF0000' }, // 색상 설정 (기상 상태에 따라 색상 설정 가능)
                        2: { color: '#00FF00' },
                        3: { color: '#0000FF' },
                        4: { color: '#FFFF00' }
                    },
                    curveType: 'function',
                    pointSize: 5,
                    legend: { position: 'bottom' }, // 범례 위치 설정
                };

                // 차트 그리기
                var chart = new google.visualization.LineChart(document.getElementById('chartContainer'));
                chart.draw(chartData, options);
            });
        }
    });
</script>
</div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
