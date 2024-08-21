<%--
/**
	Class Name:
	Description:
	Author : user
	Modification information
	
	수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 8. 19        최초작성 
    
    author eclass 개발팀
    since 2024.07.18
*/
 --%>
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

<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<link rel="stylesheet" href="${CP}/resources/css/chart/chart.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/chart/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
</head>
 
<body>

    <div class="center-content">
        <h1>연도별 기상사고</h1>
    </div> 
<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
    <!-- 연도 선택 버튼 컨테이너 -->
<div class="container mt-4">
        <div class="btn-group" role="group" aria-label="Year Buttons">
            <c:forEach var="year" begin="2005" end="2023">
                <button type="button" class="btn btn-primary year-button" data-year="${year}">
                    ${year}
                </button>
            </c:forEach>
        </div>
    </div>

<!-- 차트 컨테이너 -->
<div id="chartContainer" style="height: 500px; margin: 0 auto;"></div>

<script>
        $(document).ready(function() {
            // 연도 버튼 클릭 이벤트
            $('.year-button').on('click', function() {
                var selectedYear = $(this).data('year');
                // 선택한 연도를 사용하여 차트를 갱신하거나 데이터 요청
                loadChartForYear(selectedYear);
            });

            function loadChartForYear(year) {
                // 예시: AJAX 요청으로 연도별 데이터를 가져와 차트 갱신
                $.ajax({
                    url: '${CP}/chart/weatherByYear.do', // 데이터 요청 URL
                    method: 'GET',
                    data: { year: year },
                    success: function(response) {
                        console.log(response);
                        // 차트 데이터를 업데이트하는 로직 추가
                        drawChart(response);
                    },
                    error: function() {
                        alert('데이터를 가져오는 데 실패했습니다.');
                    }
                });
            }

            function drawChart(data) {
                // 구별로 부상자 수 합산을 위한 객체
                var regionInjuryCount = {};

                // 데이터를 순회하며 각 구별로 부상자 수를 합산
                data.forEach(function(item) {
                    if (regionInjuryCount[item.REGION]) {
                        regionInjuryCount[item.REGION] += item.INJURYCOUNT;
                    } else {
                        regionInjuryCount[item.REGION] = item.INJURYCOUNT;
                    }
                });

                // 차트 데이터 배열 생성
                var chartData = [];

                // 구별로 합산된 데이터를 배열에 추가
                for (var region in regionInjuryCount) {
                    chartData.push([region, regionInjuryCount[region]]);
                }

                // 데이터 오름차순으로 정렬 (부상자 수 기준)
                chartData.sort(function(a, b) {
                    return b[1] - a[1]; // 내림차순 정렬
                });

                Highcharts.chart('chartContainer', {
                    chart: {
                        type: 'bar',
                        marginRight: 150
                    },
                    title: {
                    	text: null // 제목 비활성화
                    },
                    xAxis: {
                        categories: chartData.map(item => item[0]),
                        title: {
                            text: 'Region'
                        },
                        labels: {
                            rotation: -45
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: '부상자 수',
                            align: 'high'
                        },
                        stackLabels: {
                            enabled: true
                        }
                    },
                    legend: {
                        enabled: false // 범례 비활성화
                    },
                    tooltip: {
                        headerFormat: '<b>{point.x}</b><br/>',
                        pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
                    },
                    plotOptions: {
                        bar: {
                            stacking: 'normal'
                        }
                    },
                    series: [{
                        name: '부상자 수',
                        data: chartData.map(item => item[1]),
                        color: '#2196f3'
                    }]
                });
            }
        });
    </script>

</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>