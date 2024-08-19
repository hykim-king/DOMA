<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요일별 사망자 수 및 부상자 수 차트</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        fetch('${CP}/chart/chartData2.do')
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 오류');
                }
                return response.json();
            })
            .then(data => {
                console.log('Fetched data:', data); // 데이터 구조 확인

                const dataTable = new google.visualization.DataTable();
                dataTable.addColumn('string', '요일');
                dataTable.addColumn('number', '사망자 수');
                dataTable.addColumn('number', '부상자 수');
                dataTable.addColumn('number', '중상자 수');

                data.forEach(item => {
                    dataTable.addRow([item.DAY_WEEK, item.TOTAL_DEATHS, item.TOTAL_CASUALTIES, item.TOTAL_SERIOUSLY]);
                });

                const options = {
                    title: '요일별 사망자 수, 부상자 수 및 중상자 수',
                    hAxis: {
                        title: '요일',
                        titleTextStyle: { color: '#333' }
                    },
                    vAxis: {
                        minValue: 0
                    },
                    chartArea: { width: '70%', height: '70%' },
                    colors: ['#FF0000', '#FFFF00', '#FFA500'],
                    curveType: 'function',
                    legend: { position: 'bottom' },
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
    .chart-container {
        margin: 20px;
        text-align: center;
    }
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
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

<div class="center-content">
    <h1>요일별 사망자 수 및 부상자 수</h1>
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
        <button class="showChartsButton">시군구별 기상상태와 부상자 수</button>
    </div>
<!-- 차트 컨테이너 -->
<div id="chartContainer" class="chart-container" style="height: 500px;"></div>

<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</body>
</html>
