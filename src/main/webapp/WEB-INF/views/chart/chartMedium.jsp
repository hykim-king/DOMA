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
    <!-- Chart.js Library -->
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        fetch('${CP}/chart/chartDataMedium.do')
            .then(response => response.json())
            .then(data => {
                // Prepare data for each chart
                const mediumDeadData = data.mediumDead.map(item => ({label: item.MEDIUM_NAME, value: item.TOTAL_DEATHS}));
                const mediumCasualtiesData = data.mediumCasualties.map(item => ({label: item.MEDIUM_NAME, value: item.TOTAL_CASUALTIES}));
                const mediumSeriouslyData = data.mediumSeriously.map(item => ({label: item.MEDIUM_NAME, value: item.TOTAL_SERIOUSLY}));

                function createPieChart(containerId, chartData, title) {
                    // Sort chart data by value in descending order
                    chartData.sort((a, b) => b.value - a.value);

                    // Exclude "기타" data
                    const filteredData = chartData.filter(item => item.label !== '기타');

                    // Extract labels and values
                    const labels = filteredData.map(item => item.label);
                    const values = filteredData.map(item => item.value);

                    // Add "기타" data to the end for the legend
                    const 기타Data = chartData.find(item => item.label === '기타');
                    if (기타Data) {
                        labels.push(기타Data.label);
                        values.push(기타Data.value);
                    }

                    const ctx = document.getElementById(containerId).getContext('2d');
                    new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: title,
                                data: values,
                                backgroundColor: ['#050C9C', '#3572EF', '#3ABEF9', '#A7E6FF', '#ffffff',
                                    '#f9eb97', '#f7e36d', '#f6df58', '#F4D72F', '#F7F7F8',
                                    '#EEEEEE', '#ACE2E1', '#41C9E2', '#36A2EB', '#0F67B1'
                                ],
                                borderColor: '#ffffff',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                title: {
                                    display: true,
                                    text: title, // Title for each chart
                                    font: {
                                        size: 18
                                    }
                                },
                                legend: {
                                    position: 'right',
                                    labels: {
                                        usePointStyle: true,
                                        // Note: Chart.js does not have a native sort for legend items based on data values.
                                        // Sorting needs to be handled in data processing or by other methods.
                                    }
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(tooltipItem) {
                                            return tooltipItem.label + ': ' + tooltipItem.raw;
                                        }
                                    }
                                }
                            }
                        }
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
    });
</script>
   
   
</head>
<body>

    <div class="center-content">
        <h1>사고 종류별 총 사망자 수 및 부상자 수</h1>
    </div>

   <!-- 버튼 컨테이너 -->
<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 

    <!-- 차트 컨테이너 -->
    <div id="chartsContainer" class="chart-container">
        <!-- 사망자 수 차트 -->
        <div class="chart-box">
            <canvas id="deathChart" style="height: 400px;"></canvas>
        </div>

        <!-- 부상자 수 차트 -->
        <div class="chart-box">
            <canvas id="casualtiesChart" style="height: 400px;"></canvas>
        </div>

        <!-- 중상자 수 차트 -->
        <div class="chart-box">
            <canvas id="seriouslyChart" style="height: 400px;"></canvas>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
