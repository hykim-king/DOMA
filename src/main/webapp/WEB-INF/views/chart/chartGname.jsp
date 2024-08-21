<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DOMA</title>
    <!-- Google Charts Loader -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
    <%-- Additional CSS --%>
	<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
	<script src="${CP}/resources/js/common.js"></script>
	<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
	<script src="${CP}/resources/js/chart/chart.js"></script>
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
			    gap: 10px; /* 버튼 간의 간격을 10px로 설정 */
			    width: 100%;
			    max-width: 1200px;
			    margin-left: auto;
			    margin-right: auto;
			}
			
			.button-row {
			    display: flex;
			    justify-content: center;
			    gap: 10px; /* 버튼 간의 간격을 10px로 설정 */
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
			
			.chart-container {
			    display: flex;
			    justify-content: center; /* Align charts to the center */
			    flex-wrap: nowrap; /* Arrange charts horizontally */
			    margin: 10px; /* Add margin around the container */
			    height: calc(100vh - 80px); /* Adjust height to fit viewport minus footer height (예: 80px) */
			    overflow: auto; /* Add scrollbars if content overflows */
			    gap: 20px; /* Add space between chart boxes */
			}
			
			.chart-box {
			    width: 30%; /* Set width of each chart box */
			    box-sizing: border-box; /* Ensure padding and border are included in width */
			}
			
			/* Remove margin from the last chart box */
			.chart-box:last-child {
			    margin-right: 0;
			}
			
			.chart-box canvas {
			    width: 100% !important; /* Make canvas fill the chart box width */
			    height: auto !important; /* Maintain aspect ratio */
			}



</style>
</head>
<body>

    <div class="center-content">
        <h1>지역별 총 사망자 수 및 부상자 수</h1>
    </div>

    <!-- Button container -->
    <!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 

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
    
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</body> 
</html>
