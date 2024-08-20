<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주간 및 야간 사망자 수 및 부상자 수 차트</title>
<!-- bootstrap css -->
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<!-- Chart.js 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', () => {
        drawCharts();
    });

    function drawCharts() {
        fetch('${CP}/chart/chartData4.do')
            .then(response => response.json())
            .then(data => {
                // 데이터 정리
                const nightSeriouslyData = data.nightSeriously;
                const nightDeadData = data.nightDead;
                const nightCasualtiesData = data.nightCasualties;

                // 주간 및 야간 데이터 분리
                const daySeriously = nightSeriouslyData.find(item => item.DAY_NIGHT === '주간').TOTAL_SERIOUSLY;
                const nightSeriously = nightSeriouslyData.find(item => item.DAY_NIGHT === '야간').TOTAL_SERIOUSLY;

                const dayDead = nightDeadData.find(item => item.DAY_NIGHT === '주간').TOTAL_DEATHS;
                const nightDead = nightDeadData.find(item => item.DAY_NIGHT === '야간').TOTAL_DEATHS;

                const dayCasualties = nightCasualtiesData.find(item => item.DAY_NIGHT === '주간').TOTAL_CASUALTIES;
                const nightCasualties = nightCasualtiesData.find(item => item.DAY_NIGHT === '야간').TOTAL_CASUALTIES;

                // 차트 데이터 준비
                const dayChartData = [dayDead, dayCasualties, daySeriously];
                const nightChartData = [nightDead, nightCasualties, nightSeriously];
                const labels = ['사망자 수', '부상자 수', '중상자 수'];
                const chartData = {
                        labels: labels,
                        datasets: [
                            {
                                label: '주간',
                                data: [dayDead, dayCasualties, daySeriously],
                                backgroundColor: '#FF6384'
                            },
                            {
                                label: '야간',
                                data: [nightDead, nightCasualties, nightSeriously],
                                backgroundColor: '#36A2EB'
                            }
                        ]
                    };
                const ctx = document.getElementById('comparisonChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: chartData,
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: '주간 및 야간 사망자 수, 부상자 수, 중상자 수 비교'
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('차트 데이터 가져오기 오류:', error));
    }
</script>
<style>
    .chart-container {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        margin: 20px;
    }
    .chart-box {
        width: 45%; /* 차트의 너비를 설정 */
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
        <h1>주간 및 야간 총 사망자 수 및 부상자 수</h1>
    </div>
    
    <!-- 버튼 컨테이너 -->
    <div class="button-container">
        <button class="showChartsButton">월별 교통사고</button>
        <button class="showChartsButton">요일별 교통사고</button>
        <button class="showChartsButton">시간대별 교통사고</button>
        <button class="showChartsButton">주야별 교통사고</button>
        <button class="showChartsButton">사고유형별 교통사고</button>
        <button class="showChartsButton">사고종류별 교통사고</button>
        <button class="showChartsButton">구별 교통사고</button>
        <button class="showChartsButton">연도별 기상사고(구)</button>
        <button class="showChartsButton">연도별 부상자 수 추이(기상상태)</button>
        <button class="showChartsButton">구별 기상상태와 부상자 수</button>
    </div>
    
    <!-- 차트 컨테이너 -->
    <div id="chartsContainer" class="chart-container">
        <div class="chart-box">
            <canvas id="comparisonChart"></canvas>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
