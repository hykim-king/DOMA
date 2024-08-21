<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 사망자 수 및 부상자 수 차트</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>

<head>
    <title>DOMA</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawCharts);

        function drawCharts() {
            fetch('${CP}/chart/chartData1.do')
                .then(response => response.json())
                .then(data => {
                    const dataTable = new google.visualization.DataTable();
                    dataTable.addColumn('string', '월');
                    dataTable.addColumn('number', '총 사망자 수');
                    dataTable.addColumn('number', '총 부상자 수');
                    dataTable.addColumn('number', '총 중상자 수');

                    data.forEach(item => {
                        dataTable.addRow([item.MONTH, item.TOTAL_DEATHS, item.TOTAL_CASUALTIES, item.TOTAL_SERIOUSLY]);
                    });

                    const options = {
                        title: '월별 총 사망자 수 및 부상자 수',
                        curveType: 'function',
                        legend: { position: 'bottom' },
                        colors: ['#FF0000', '#FFFF00', '#FFA500'], // 사망자: 빨강, 부상자: 노랑, 중상자: 주황
                        hAxis: {
                            title: '월',
                            titleTextStyle: {color: '#333'}
                        },
                        vAxis: {
                            minValue: 0
                        },
                        chartArea: {width: '70%', height: '70%'},
                        animation: {
                            startup: true,
                            duration: 1000,
                            easing: 'out'
                        }
                    };

                    const chart = new google.visualization.LineChart(document.getElementById('chartContainer'));
                    chart.draw(dataTable, options);
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        }
    </script>    
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
</head>
<body>

<div class="center-content">
    <h1>월별 총 사망자 수 및 부상자 수</h1>
</div>

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
<div id="chartContainer"></div>

</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
