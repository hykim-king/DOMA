<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 사망자 수 및 부상자 수 차트</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>

<head>
    <title>월별 사망자 수 및 부상자 수 차트</title>
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
            gap: 10px;
            flex-wrap: wrap;
            margin: 20px 0;
        }
        .showChartsButton {
            padding: 10px 20px;
            font-size: 14px;
        }
        #chartContainer {
            width: 100%;
            height: 500px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

<div class="center-content">
    <h1>월별 총 사망자 수 및 부상자 수</h1>
</div>

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
        <button class="showChartsButton">연도별 부상자 상위 5개 구</button>
        <button class="showChartsButton">시군구별 기상상태와 부상자 수</button>
    </div>

<!-- 차트 컨테이너 -->
<div id="chartContainer"></div>

</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
