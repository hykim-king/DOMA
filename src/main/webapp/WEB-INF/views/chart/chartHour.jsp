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
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script type="text/javascript">
        fetch('${CP}/chart/chartData3.do')
            .then(response => response.json())
        	.then(data => {
            console.log('Fetched data:', data); // 데이터 구조 확인
	         // 데이터를 Highcharts 형식으로 변환
	            const categories = [];
	            const totalDeaths = [];
	            const totalCasualties = [];
	            const totalSeriously = [];
                data.forEach(item => {
                	categories.push(item.HOUR_RANGE);
                	 totalDeaths.push(item.TOTAL_DEATHS);
                     totalCasualties.push(item.TOTAL_CASUALTIES);
                     totalSeriously.push(item.TOTAL_SERIOUSLY);
                });
                Highcharts.chart('chartContainer', {
                    chart: {
                        type: 'line',
                        animation: {
                            duration: 1000
                        }
                    },
                    title: {
                        text: '시간별 사망자 수, 부상자 수 및 중상자 수'
                    },
                    xAxis: {
                        categories: categories,
                        title: {
                            text: '시간대'
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
                            name: '사망자 수',
                            data: totalDeaths,
                            color: '#FF0000' // 빨강
                        },
                        {
                            name: '부상자 수',
                            data: totalCasualties,
                            color: '#4caf50' // 초록
                        },
                        {
                            name: '중상자 수',
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
                    },
                    // 애니메이션 및 스타일링
                    credits: {
                        enabled: false
                    }
                });
            })
            .catch(error => console.error('차트 데이터 가져오기 오류:', error));
                
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
