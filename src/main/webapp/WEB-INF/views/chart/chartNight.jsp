<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주간 및 야간 사망자 수 및 부상자 수 차트</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<%-- Chart.js 라이브러리 --%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', () => {
    	drawCharts();
	});
    function drawCharts() {
        fetch('${CP}/chart/chartData4.do')
            .then(response => response.json())
            .then(data => {
                const nightDeadData = data.nightDead.map(item => item.TOTAL_DEATHS);
                const nightCasualtiesData = data.nightCasualties.map(item => item.TOTAL_CASUALTIES);
                const nightSeriouslyData = data.nightSeriously.map(item => item.TOTAL_SERIOUSLY);
                const labels = data.nightDead.map(item => item.DAY_NIGHT);

                function createPieChart(ctx, chartData, title) {
                    new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: labels,
                            datasets: [{
                                data: chartData,
                                backgroundColor: ['#F4D72F', '#36A2EB'],
                                hoverBackgroundColor: ['#F4D72F', '#36A2EB']
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: title
                                },
                                animation: {
                                    animateScale: true,
                                    animateRotate: true
                                }
                            }
                        }
                    });
                }

                const deathCtx = document.getElementById('deathChart').getContext('2d');
                createPieChart(deathCtx, nightDeadData, '총 사망자 수');

                const casualtiesCtx = document.getElementById('casualtiesChart').getContext('2d');
                createPieChart(casualtiesCtx, nightCasualtiesData, '총 부상자 수');

                const seriouslyCtx = document.getElementById('seriouslyChart').getContext('2d');
                createPieChart(seriouslyCtx, nightSeriouslyData, '총 중상자 수');
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
</script>
<style>
    .chart-container {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        margin: 20px;
    }
    .chart-box {
        width: 30%; /* 차트의 너비를 설정 */
        margin: 10px; /* 차트 사이의 여백 */
        position: relative;
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
        <button class="showChartsButton">시군구별 교통사고</button>
        <button class="showChartsButton">이건 걍만든버튼</button>
    </div>
    
    <!-- 차트 컨테이너 -->
    <div id="chartsContainer" class="chart-container">
        <!-- 사망자 수 차트 -->
        <div class="chart-box">
            <canvas id="deathChart"></canvas>
        </div>
        
        <!-- 사상자 수 차트 -->
        <div class="chart-box">
            <canvas id="casualtiesChart"></canvas>
        </div>
        
        <!-- 중상자 수 차트 -->
        <div class="chart-box">
            <canvas id="seriouslyChart"></canvas>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
