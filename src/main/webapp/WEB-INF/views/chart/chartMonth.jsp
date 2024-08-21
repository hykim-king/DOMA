<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>월별 사망자 수 및 부상자 수 차트</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<style>
        /* 차트 컨테이너 스타일링 */
        #chartContainer {
            width: 60%;
            height: 100%;
            min-height: 400px; /* 최소 높이 설정 */
            box-sizing: border-box; /* 패딩을 포함하여 너비와 높이 계산 */
        }
        /* 전체 화면에 맞게 조정 */
        html, body {
            height: 100%;
            margin: 0;
        }
    </style>


    <title>DOMA</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    
    fetch('${CP}/chart/chartData1.do')
        .then(response => response.json())
        .then(data => {
            // 데이터를 Highcharts 형식에 맞게 변환
            const categories = [];
            const totalDeaths = [];
            const totalCasualties = [];
            const totalSeriously = [];

            data.forEach(item => {
                categories.push(item.MONTH);
                totalDeaths.push(item.TOTAL_DEATHS);
                totalCasualties.push(item.TOTAL_CASUALTIES);
                totalSeriously.push(item.TOTAL_SERIOUSLY);
            });

            // Highcharts 차트 생성
            Highcharts.chart('chartContainer', {
                chart: {
                    type: 'line',
                    animation: {
                        duration: 1000
                    }
                },
                title: {
                    text: '월별 총 사망자 수 및 부상자 수'
                },
                xAxis: {
                    categories: categories,
                    title: {
                        text: '월'
                    }
                },
                yAxis: {
                    title: {
                        text: '수'
                    },
                    min: 0
                },
                series: [
                    {
                        name: '총 사망자 수',
                        data: totalDeaths,
                        color: '#FF0000' // 빨강
                    },
                    {
                        name: '총 부상자 수',
                        data: totalCasualties,
                        color: '#4caf50' // 초록
                    },
                    {
                        name: '총 중상자 수',
                        data: totalSeriously,
                        color: '#FFA500' // 주황
                    }
                ],
                legend: {
                    align: 'center',
                    verticalAlign: 'bottom'
                },
                plotOptions: {
                    line: {
                        dataLabels: {
                            enabled: true
                        },
                        enableMouseTracking: true
                    }
                }
            });
        })
        .catch(error => console.error('차트 데이터 가져오기 오류:', error));
</script>   
 
<body>

<div class="center-content">
    <h1>월별 총 사망자 수 및 부상자 수</h1>
</div>

<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 

<!-- 차트 컨테이너 -->
<div id="chartContainer" style="height: 500px; margin: 0 auto;"></div>

</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
