<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사고 종류별 사망자 수 및 부상자 수 차트</title>
    <link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
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
                        const ctx = document.getElementById(containerId).getContext('2d');
                        new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: chartData.map(item => item.label),
                                datasets: [{
                                    label: title,
                                    data: chartData.map(item => item.value),
                                    backgroundColor: ['#050C9C', '#3572EF', '#3ABEF9', '#A7E6FF', '#ffffff',
                                    	'#f9eb97', '#f7e36d', '#f6df58', '#F4D72F', '#F7F7F8',  
                                    	'#EEEEEE', '#ACE2E1', '#41C9E2', '#36A2EB', '#0F67B1' ],
                                    borderColor: '#ffffff',
                                    borderWidth: 1
                                }]
                            },
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
                    createPieChart('deathChart', mediumDeadData, '사고 종류별 총 사망자 수');
                    createPieChart('casualtiesChart', mediumCasualtiesData, '사고 종류별 총 부상자 수');
                    createPieChart('seriouslyChart', mediumSeriouslyData, '사고 종류별 총 중상자 수');

                    // 차트 컨테이너 표시
                    document.getElementById('chartsContainer').style.display = 'flex';
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        });
    </script>    
    <style>
        .chart-container {
            display: none; /* 처음에는 차트를 숨김 */
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
        <h1>사고 종류별 총 사망자 수 및 부상자 수</h1>
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
