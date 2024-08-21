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
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<link rel="stylesheet" href="${CP}/resources/css/chart/chart.css"> 
<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        fetch('${CP}/chart/chartData3.do')
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 오류');
                }
                return response.json();
            })
            .then(data => {
                const dataTable = new google.visualization.DataTable();
                dataTable.addColumn('string', '시간대');
                dataTable.addColumn('number', '사망자 수');
                dataTable.addColumn('number', '부상자 수');
                dataTable.addColumn('number', '중상자 수');

                data.forEach(item => {
                    dataTable.addRow([item.HOUR_RANGE, item.TOTAL_DEATHS || 0, item.TOTAL_CASUALTIES || 0, item.TOTAL_SERIOUSLY || 0]);
                });

                const options = {
                    title: '시간별 사망자 수, 부상자 수 및 중상자 수',
                    hAxis: {
                        title: '시간대',
                        titleTextStyle: {color: '#333'}
                    },
                    vAxis: {
                        minValue: 0
                    },
                    chartArea: {width: '70%', height: '70%'},
                    colors: ['#FF0000', '#FFFF00', '#0000FF'], // 각 데이터 시리즈의 색상 설정
                    curveType: 'function', // 부드러운 곡선으로 표시
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
        <h1>시간별 총 사망자 수 및 부상자 수</h1>
    </div>
    
    <!-- 버튼 컨테이너 -->
<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
    
    <!-- 차트 컨테이너 -->
    <div id="chartContainer" style="height: 500px; margin: 0 auto;"></div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
