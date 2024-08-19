<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
	<link rel="stylesheet" href="${CP}/resources/css/chart/chart.css"> 
    <title>지역별 사망자 수 및 부상자 수 차트</title>
    <!-- Chart.js Library -->
    <script src="${CP}/resources/js/chart/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            fetch('${CP}/chart/chartDataGname.do')
                .then(response => response.json())
                .then(data => {
                    console.log('Fetched data:', data);  // 데이터를 확인하기 위한 콘솔 로그

                    // Prepare data for each chart
                    const gnameDeadData = {
                        labels: data.gnameDead.map(item => item.GNAME),
                        datasets: [{
                            label: '사망자 수',
                            data: data.gnameDead.map(item => item.TOTAL_DEATHS),
                            backgroundColor: [
                                '#FF6384', '#36A2EB', '#FFCE56', '#E9ECEF', '#8E5EA2',
                                '#3CBA9F', '#F6BF00', '#F7A03C', '#C0C0C0', '#FF6347'
                            ],
                            borderColor: '#ffffff',
                            borderWidth: 1
                        }]
                    };

                    const gnameCasualtiesData = {
                        labels: data.gnameCasualties.map(item => item.GNAME),
                        datasets: [{
                            label: '부상자 수',
                            data: data.gnameCasualties.map(item => item.TOTAL_CASUALTIES),
                            backgroundColor: [
                                '#FF6384', '#36A2EB', '#FFCE56', '#E9ECEF', '#8E5EA2',
                                '#3CBA9F', '#F6BF00', '#F7A03C', '#C0C0C0', '#FF6347'
                            ],
                            borderColor: '#ffffff',
                            borderWidth: 1
                        }]
                    };

                    const gnameSeriouslyData = {
                        labels: data.gnameSeriously.map(item => item.GNAME),
                        datasets: [{
                            label: '중상자 수',
                            data: data.gnameSeriously.map(item => item.TOTAL_SERIOUSLY),
                            backgroundColor: [
                                '#FF6384', '#36A2EB', '#FFCE56', '#E9ECEF', '#8E5EA2',
                                '#3CBA9F', '#F6BF00', '#F7A03C', '#C0C0C0', '#FF6347'
                            ],
                            borderColor: '#ffffff',
                            borderWidth: 1
                        }]
                    };

                    function createPieChart(containerId, chartData, title) {
                        const canvas = document.getElementById(containerId);
                        if (!canvas) {
                            console.error('Canvas element not found:', containerId);
                            return;
                        }
                        const ctx = canvas.getContext('2d');
                        if (!ctx) {
                            console.error('Failed to get canvas context:', containerId);
                            return;
                        }

                        new Chart(ctx, {
                            type: 'pie',
                            data: chartData,
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {
                                        position: 'right',
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
                    createPieChart('deathChartCanvas', gnameDeadData, '지역별 총 사망자 수');
                    createPieChart('casualtiesChartCanvas', gnameCasualtiesData, '지역별 총 부상자 수');
                    createPieChart('seriouslyChartCanvas', gnameSeriouslyData, '지역별 총 중상자 수');

                    // Display chart container
                    document.getElementById('chartsContainer').style.display = 'flex';
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        });
    </script>
</head>
<body>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

    <div class="center-content">
        <h1>지역별 총 사망자 수 및 부상자 수</h1>
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