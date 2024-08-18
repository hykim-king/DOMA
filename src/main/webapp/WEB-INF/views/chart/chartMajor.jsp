<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사고 유형별 사망자 수 및 부상자 수 차트</title>
<!-- bootstrap css -->
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawCharts);

    function drawCharts() {
        fetch('${CP}/chart/chartDataMajor.do')
            .then(response => response.json())
            .then(data => {
                const majorDeadData = [['Accident Type', 'Total Deaths']].concat(
                    data.majorDead.map(item => [item.MAJOR_NAME, item.TOTAL_DEATHS])
                );
                const majorCasualtiesData = [['Accident Type', 'Total Casualties']].concat(
                    data.majorCasualties.map(item => [item.MAJOR_NAME, item.TOTAL_CASUALTIES])
                );
                const majorSeriouslyData = [['Accident Type', 'Total Seriously Injured']].concat(
                    data.majorSeriously.map(item => [item.MAJOR_NAME, item.TOTAL_SERIOUSLY])
                );

                function createColumnChart(containerId, chartData, title) {
                    const dataTable = google.visualization.arrayToDataTable(chartData);
                    const options = {
                        title: title,
                        chartArea: {width: '70%', height: '70%'},
                        hAxis: {
                            title: '사고 유형',
                            titleTextStyle: {color: '#333'}
                        },
                        vAxis: {
                            minValue: 0
                        },
                        animation: {
                            startup: true,
                            duration: 1000,
                            easing: 'out'
                        },
                        tooltip: { isHtml: true },
                        legend: { position: 'none' }
                    };
                    const chart = new google.visualization.ColumnChart(document.getElementById(containerId));
                    chart.draw(dataTable, options);

                    // 추가: 차트 클릭 이벤트 핸들러
                    google.visualization.events.addListener(chart, 'select', function() {
                        const selectedItem = chart.getSelection()[0];
                        if (selectedItem) {
                            const accidentType = dataTable.getValue(selectedItem.row, 0);
                            alert(accidentType + '이 선택되었습니다.');
                        }
                    });
                }

                createColumnChart('deathChart', majorDeadData, '사고 유형별 총 사망자 수');
                createColumnChart('casualtiesChart', majorCasualtiesData, '사고 유형별 총 부상자 수');
                createColumnChart('seriouslyChart', majorSeriouslyData, '사고 유형별 총 중상자 수');

                // 차트 컨테이너 표시
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
        <h1>사고 유형별 총 사망자 수 및 부상자 수</h1>
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
        <div id="deathChart" class="chart-box" style="height: 400px;"></div>
        
        <!-- 부상자 수 차트 -->
        <div id="casualtiesChart" class="chart-box" style="height: 400px;"></div>
        
        <!-- 중상자 수 차트 -->
        <div id="seriouslyChart" class="chart-box" style="height: 400px;"></div>
    </div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
