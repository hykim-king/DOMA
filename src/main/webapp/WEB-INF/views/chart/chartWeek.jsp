<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOMA</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        fetch('${CP}/chart/chartData2.do')
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 오류');
                }
                return response.json();
            })
            .then(data => {
                console.log('Fetched data:', data); // 데이터 구조 확인

                const dataTable = new google.visualization.DataTable();
                dataTable.addColumn('string', '요일');
                dataTable.addColumn('number', '사망자 수');
                dataTable.addColumn('number', '부상자 수');
                dataTable.addColumn('number', '중상자 수');

                data.forEach(item => {
                    dataTable.addRow([item.DAY_WEEK, item.TOTAL_DEATHS, item.TOTAL_CASUALTIES, item.TOTAL_SERIOUSLY]);
                });

                const options = {
                    title: '요일별 사망자 수, 부상자 수 및 중상자 수',
                    hAxis: {
                        title: '요일',
                        titleTextStyle: { color: '#333' }
                    },
                    vAxis: {
                        minValue: 0
                    },
                    chartArea: { width: '70%', height: '70%' },
                    colors: ['#FF0000', '#FFFF00', '#FFA500'],
                    curveType: 'function',
                    legend: { position: 'bottom' },
                    animation: {
                        startup: true,
                        duration: 1000,
                        easing: 'out'
                    }
                };

                const chart = new google.visualization.LineChart(document.getElementById('chartContainer'));
                chart.draw(dataTable, options);
            })
            .catch(error => console.error('차트 데이터 가져오기 오류:', error)); 
    }
</script>
  
</head>
<body>

<div class="center-content">
    <h1>요일별 사망자 수 및 부상자 수</h1>
</div>

<!-- 버튼 컨테이너 -->
<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
<!-- 차트 컨테이너 -->
<div id="chartContainer" class="chart-container" style="height: 500px;"></div>

<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</body>
</html>
