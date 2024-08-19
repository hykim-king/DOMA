<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지역별 사망자 수 및 부상자 수 차트</title>
    <!-- Google Charts Loader -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {packages: ['corechart']});
        google.charts.setOnLoadCallback(drawCharts);

        function drawCharts() {
            fetch('${CP}/chart/chartDataGname.do')
                .then(response => response.json())
                .then(data => {
                    // Prepare data for each chart
                    const gnameDeadData = [['지역', '사망자 수']].concat(
                        data.gnameDead.map(item => [item.GNAME, item.TOTAL_DEATHS])
                    );
                    const gnameCasualtiesData = [['지역', '부상자 수']].concat(
                        data.gnameCasualties.map(item => [item.GNAME, item.TOTAL_CASUALTIES])
                    );
                    const gnameSeriouslyData = [['지역', '중상자 수']].concat(
                        data.gnameSeriously.map(item => [item.GNAME, item.TOTAL_SERIOUSLY])
                    );

                    function createDoughnutChart(containerId, chartData, title) {
                        const dataTable = google.visualization.arrayToDataTable(chartData);
                        const options = {
                            title: title,
                            pieHole: 0.6,
                            chartArea: {width: '80%', height: '80%'},
                            legend: {position: 'right'},
                            colors: [ 
                            	'#000108', '#020439', '#030652', '#03086b', '#040a83',
                            	'#050C9C', '#3572EF', '#3ABEF9', '#A7E6FF', '#ffffff', 
                            	'#ACE2E1', '#41C9E2', '#36A2EB', '#0F67B1', '#f9eb97', 
                            	'#f7e36d', '#f6df58', '#f7e05f', '#f5dc47', '#F4D72F', 
                            	'#f3d217','#e4c40c','#EEEEEE','#A6A6A6','#737373'
                            	] 
                            
                            
                            
                        };
                        const chart = new google.visualization.PieChart(document.getElementById(containerId));
                        chart.draw(dataTable, options);
                    }

                    // Create charts
                    createDoughnutChart('deathChart', gnameDeadData, '지역별 총 사망자 수');
                    createDoughnutChart('casualtiesChart', gnameCasualtiesData, '지역별 총 부상자 수');
                    createDoughnutChart('seriouslyChart', gnameSeriouslyData, '지역별 총 중상자 수');

                    // Display chart container
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
        display: flex; /* Display charts in a flexible container */
        justify-content: space-between;
        flex-wrap: nowrap; /* Arrange charts horizontally */
        margin: 20px; /* Add margin to container */
        height: 100vh; /* Set container height to fill viewport height */
        overflow: auto; /* Add scrollbars if content overflows */
    }
    .chart-box {
        width: 32%; /* Increase width to make charts larger */
        margin: 10px; /* Add margin between charts */
        box-sizing: border-box; /* Ensure padding and border are included in width */
    }
    .chart-box canvas {
        width: 100% !important; /* Make canvas fill the chart box width */
        height: auto !important; /* Maintain aspect ratio */
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
        <h1>지역별 총 사망자 수 및 부상자 수</h1>
    </div>

    <!-- Button container -->
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

    <!-- Chart container -->
    <div id="chartsContainer" class="chart-container">
        <!-- Deaths chart -->
        <div id="deathChart" class="chart-box" style="height: 400px;">
            <canvas id="deathChartCanvas"></canvas>
        </div>

        <!-- Casualties chart -->
        <div id="casualtiesChart" class="chart-box" style="height: 400px;">
            <canvas id="casualtiesChartCanvas"></canvas>
        </div>

        <!-- Seriously Injured chart -->
        <div id="seriouslyChart" class="chart-box" style="height: 400px;">
            <canvas id="seriouslyChartCanvas"></canvas>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
