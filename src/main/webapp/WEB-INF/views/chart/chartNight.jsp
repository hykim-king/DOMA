<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOMA</title>
<!-- bootstrap css -->
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
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
			/* 중앙 콘텐츠 */
.center-content {
    text-align: center;
    margin: 20px 0; /* 위아래 여백 20px */
}

/* 버튼 컨테이너 */
.button-container {
    display: flex;
    flex-direction: column; /* 버튼을 세로 방향으로 배치 */
    align-items: center; /* 버튼을 중앙에 배치 */
    margin: 40px 0; /* 위아래 여백 40px */
    gap: 10px; /* 버튼 간의 간격을 10px로 설정 */
    width: 100%;
    max-width: 1200px; /* 최대 너비 설정 */
    margin-left: auto;
    margin-right: auto;
}

/* 버튼 행 */
.button-row {
    display: flex;
    justify-content: center;
    gap: 10px; /* 버튼 간의 간격을 10px로 설정 */
    margin-bottom: 10px; /* 버튼 행 아래 여백 */
    flex-wrap: wrap;
    width: 100%;
}

/* 버튼 스타일 */
.showChartsButton {
    padding: 0 20px; /* 패딩을 상하 0, 좌우 20px로 설정 */
    font-size: 14px;
    width: 200px; /* 버튼 너비를 200px로 설정 */
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

/* 마우스 호버 시 버튼 스타일 */
.showChartsButton:hover {
    background-color: #f0f0f0; /* 호버 시 배경색 */
    color: #333333; /* 호버 시 텍스트 색상 */
    border-color: #999999; /* 호버 시 테두리 색상 */
}

/* 차트 컨테이너 */
#chartsContainer {
    display: flex;
    justify-content: center; /* 중앙 정렬 */
    align-items: center; /* 수직 정렬 */
    width: 90%; /* 컨테이너 너비를 90%로 설정 */
    max-width: 1200px; /* 최대 너비 설정 */
    height: 500px; /* 차트 컨테이너의 높이 조정 */
    margin: 40px auto; /* 위아래 여백 40px, 좌우 중앙 정렬 */
}

/* 차트 박스 */
.chart-box {
    width: 100%; /* 차트 박스의 너비를 100%로 설정 */
    box-sizing: border-box; /* 패딩과 보더를 포함하여 너비 계산 */
}

/* 차트 캔버스 */
.chart-box canvas {
    width: 100% !important; /* 차트의 캔버스를 박스 너비에 맞게 조정 */
    height: auto !important; /* 비율을 유지하면서 높이 자동 조정 */
}


</style>
</head>
<body>

    <div class="center-content">
        <h1>주간 및 야간 총 사망자 수 및 부상자 수</h1>
    </div>
    
    <!-- 버튼 컨테이너 -->
    <!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
 
    
    <!-- 차트 컨테이너 -->
    <div id="chartsContainer" class="chart-container">
        <div class="chart-box">
            <canvas id="comparisonChart"></canvas>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
