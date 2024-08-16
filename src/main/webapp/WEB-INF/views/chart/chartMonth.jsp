<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<script src="${CP }/resources/js/common.js"></script>
<script src="${CP }/resources/js/jquery_3_7_1.js"></script>

<head>

    <title>월별 사망자 수 및 부상자 수 차트</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(() => {
            document.querySelectorAll('.showChartsButton').forEach(button => {
                button.addEventListener('click', drawCharts);
            });
        });

        function drawCharts() {
            fetch('http://localhost:8080/doma/chart/chartData1.do')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('네트워크 오류');
                    }
                    return response.json();
                })
                .then(data => {
                    // 차트 생성 함수
                    function createChart(containerId, chartData, options) {
                        const dataTable = new google.visualization.DataTable();
                        dataTable.addColumn('string', '월');
                        dataTable.addColumn('number', options.title);
                        dataTable.addRows(chartData);

                        const chart = new google.visualization.BarChart(document.getElementById(containerId));
                        chart.draw(dataTable, options);
                    }

                    // 차트 데이터 준비
                    const deathData = data.map(item => [item.MONTH, item.TOTAL_DEATHS]);
                    const casualtiesData = data.map(item => [item.MONTH, item.TOTAL_CASUALTIES]);
                    const seriouslyData = data.map(item => [item.MONTH, item.TOTAL_SERIOUSLY]);

                    // 차트 옵션 설정
                    const commonOptions = {
                        hAxis: {
                            title: '월',
                            titleTextStyle: {color: '#333'}
                        },
                        vAxis: {
                            minValue: 0
                        },
                        chartArea: {width: '70%', height: '70%'},
                        bars: 'vertical' , 
                        animation: {
                            startup: true,
                            duration: 1000,
                            easing: 'out'
                        }
                    };

                    // 차트 생성
                    createChart('deathChart', deathData, { ...commonOptions, title: '총 사망자 수' });
                    createChart('casualtiesChart', casualtiesData, { ...commonOptions, title: '총 부상자 수' });
                    createChart('seriouslyChart', seriouslyData, { ...commonOptions, title: '총 중상자 수' });

                    // 차트 표시
                    document.getElementById('chartsContainer').style.display = 'flex';
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        }
    </script>

    <style>
        .chart-container {
            display: none; /* 처음에는 차트를 숨김 */
            display: flex;
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
        <h1>월별 총 사망자 수 및 부상자 수</h1>
    </div>
    
    <!-- 버튼 컨테이너 -->
    <div class="button-container">
        <button class="showChartsButton">차트 표시 1</button>
        <button class="showChartsButton">차트 표시 2</button>
        <button class="showChartsButton">차트 표시 3</button>
        <button class="showChartsButton">차트 표시 4</button>
        <button class="showChartsButton">차트 표시 5</button>
        <button class="showChartsButton">차트 표시 6</button>
        <button class="showChartsButton">차트 표시 7</button>
        <button class="showChartsButton">차트 표시 8</button>
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
