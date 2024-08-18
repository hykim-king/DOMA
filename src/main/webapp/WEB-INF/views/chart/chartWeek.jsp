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

<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawCharts);

    function drawCharts() {
        fetch('http://localhost:8080/doma/chart/chartData2.do')
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 오류');
                }
                return response.json();
            })
            .then(data => {
                console.log('Fetched data:', data); // 데이터 구조 확인

                const deathData = data.map(item => [item.DAY_WEEK, item.TOTAL_DEATHS]);
                const casualtiesData = data.map(item => [item.DAY_WEEK, item.TOTAL_CASUALTIES]);
                const seriouslyData = data.map(item => [item.DAY_WEEK, item.TOTAL_SERIOUSLY]);

                function createChart(containerId, chartData, title) {
                    const dataTable = new google.visualization.DataTable();
                    dataTable.addColumn('string', '요일');
                    dataTable.addColumn('number', title);
                    dataTable.addRows(chartData);

                    const options = {
                        title: title,
                        hAxis: {
                            title: '요일',
                            titleTextStyle: {color: '#333'}
                        },
                        vAxis: {
                            minValue: 0
                        },
                        chartArea: {width: '70%', height: '70%'},
                        bars: 'vertical',
                        animation: {
                            startup: true,
                            duration: 1000,
                            easing: 'out'
                        }
                    };

                    const chart = new google.visualization.BarChart(document.getElementById(containerId));
                    chart.draw(dataTable, options);
                }

                createChart('deathChart', deathData, '총 사망자 수');
                createChart('casualtiesChart', casualtiesData, '총 부상자 수');
                createChart('seriouslyChart', seriouslyData, '총 중상자 수');

                document.getElementById('chartsContainer').style.display = 'flex';
            })
            .catch(error => console.error('차트 데이터 가져오기 오류:', error)); 

    }
</script>
<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.showChartsButton').forEach((button, index) => {
            button.addEventListener('click', () => {
                switch (index) {
                    case 0:
                        window.location.href = '${CP}/chart/chartMonth.do';
                        break;
                    case 1:
                        window.location.href = '${CP}/chart/chartWeek.do';
                        break;
                    case 2:
                        window.location.href = '${CP}/chart/chartHour.do';
                        break;
                    case 3:
                        window.location.href = '${CP}/chart/chartNight.do'; // 예시 URL
                        break;
                    case 4:
                        window.location.href = '${CP}/chart/chartMajor.do'; // 예시 URL
                        break;
                    case 5:
                        window.location.href = '${CP}/chart/chartMedium.do'; // 예시 URL
                        break;
                    case 6:
                        window.location.href = '${CP}/chart/chartGname.do'; // 예시 URL
                        break;
                    case 7:
                        window.location.href = '${CP}/chart/chartSummary.do'; // 예시 URL
                        break;
                }
            });
        });
    });
</script>
<style>
    .chart-container {
        display: none; /* 처음에는 차트를 숨김 */
        display: flex;
        justify-content: space-between;
        flex-wrap: nowrap; /* 가로로 배열 */
        margin: 20px; /* 컨테이너에 마진 추가 */
    }
    .chart-box {
        width: 30%; /* 차트의 너비를 설정 */
        margin: 10px; /* 차트 사이의 여백 */
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
    <h1>요일별 총 사망자 수 및 부상자 수</h1>
</div>

 <!-- 버튼 컨테이너 -->
        <!-- 버튼 컨테이너 -->
      <div class="button-container">
        <button class="showChartsButton">월별 교통사고</button>
        <button class="showChartsButton">요일별 교통사고</button>
        <button class="showChartsButton">시간대별 교통사고</button>
        <button class="showChartsButton">주야별 교통사고</button>
        <button class="showChartsButton">사고유형별 교통사고</button>
        <button class="showChartsButton">사고종류별 교통사고</button>
        <button class="showChartsButton">시군구별 교통사고</button>
        <button class="showChartsButton">이건 걍만든버튼</button>
    </div>

<!-- 차트 컨테이너 -->
<div id="chartsContainer" class="chart-container">
    <!-- 사망자 수 차트 -->
    <div id="deathChart" class="chart-box" style="height: 400px;"></div>

    <!-- 부상자 수 차트 -->
    <div id="casualtiesChart" class="chart-box" style="height: 400px;"></div>

    <!-- 중상자 수 차트 -->
    <div id="seriouslyChart" class="chart-box" style="height: 400px;"></div>
</div>

<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</body>
</html>
