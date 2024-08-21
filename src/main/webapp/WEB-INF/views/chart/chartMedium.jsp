<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DOMA</title>
    <link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
    
<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<link rel="stylesheet" href="${CP}/resources/css/chart/chart.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>  
    <script type="text/javascript">
        fetch('${CP}/chart/chartDataMedium.do')
            .then(response => response.json())
            .then(data => {
                // Prepare data for each chart
                const mediumDeadData = data.mediumDead.map(item => ({name: item.MEDIUM_NAME, y: item.TOTAL_DEATHS}));
                const mediumCasualtiesData = data.mediumCasualties.map(item => ({name: item.MEDIUM_NAME, y: item.TOTAL_CASUALTIES}));
                const mediumSeriouslyData = data.mediumSeriously.map(item => ({name: item.MEDIUM_NAME, y: item.TOTAL_SERIOUSLY}));

                function createPieChart(containerId, chartData, title) {
                    // Sort chart data by value in descending order
                    chartData.sort((a, b) => b.y - a.y);

                    // Exclude "기타" data
                    const filteredData = chartData.filter(item => item.name !== '기타');

                    // Add "기타" data to the end for the legend
                    const 기타Data = chartData.find(item => item.name === '기타');
                    if (기타Data) {
                        filteredData.push(기타Data);
                    }

                    Highcharts.chart(containerId, {
                        chart: {
                            type: 'pie',
                            events: {
                                load: function () {
                                    // Optional: handle chart events if needed
                                }
                            }
                        },
                        title: {
                            text: title // Title for each chart
                        },
                        tooltip: {
                            pointFormat: '{point.name}: <b>{point.y}</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '{point.name}: {point.y}'
                                },
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: title,
                            colorByPoint: true,
                            data: filteredData,
                            colors: ['#050C9C', '#3572EF', '#3ABEF9', '#A7E6FF', '#ffffff',
                                    '#f9eb97', '#f7e36d', '#f6df58', '#F4D72F', '#F7F7F8',
                                    '#EEEEEE', '#ACE2E1', '#41C9E2', '#36A2EB', '#0F67B1'
                                ]
                        }]
                    });
                }

                // Create charts
                createPieChart('deathChart', mediumDeadData, '총 사망자 수');
                createPieChart('casualtiesChart', mediumCasualtiesData, '총 부상자 수');
                createPieChart('seriouslyChart', mediumSeriouslyData, '총 중상자 수');

                // 차트 컨테이너 표시
                document.getElementById('chartsContainer').style.display = 'flex';
            })
            .catch(error => console.error('차트 데이터 가져오기 오류:', error));
</script>
   
   
</head>
<body>

    <div class="center-content">
        <h1>사고 종류별 총 사망자 수 및 부상자 수</h1>
    </div>

<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 

<!-- 차트 컨테이너 -->
<div id="chartsContainer" class="chart-container" style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <!-- 사망자 수 차트 -->
    <div class="chart-box" style="flex: 1; min-width: 300px; max-width: 500px; margin: 10px;">
        <div id="deathChart" style="height: 400px;"></div>
    </div>

    <!-- 부상자 수 차트 -->
    <div class="chart-box" style="flex: 1; min-width: 300px; max-width: 500px; margin: 10px;">
        <div id="casualtiesChart" style="height: 400px;"></div>
    </div>

    <!-- 중상자 수 차트 -->
    <div class="chart-box" style="flex: 1; min-width: 300px; max-width: 500px; margin: 10px;">
        <div id="seriouslyChart" style="height: 400px;"></div>
    </div>
</div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
