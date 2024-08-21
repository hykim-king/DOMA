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
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>  
</head>
 
<body>
	<div class="center-content">
<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
    
    <!-- 차트 컨테이너 -->
    <div id="chartContainer" style="height: 500px; margin: 0 auto;"></div>

    <script>
        $(document).ready(function() {
            // 페이지 로드 후 바로 데이터 요청
            loadChartData();

            function loadChartData() {
                $.ajax({
                    url: '${CP}/chart/freqByYear.do', // 데이터 요청 URL
                    method: 'GET',
                    success: function(response) {
                        console.log(response); // 데이터 확인용
                        drawChart(response); // 차트 그리기
                    },
                    error: function() {
                        alert('데이터를 가져오는 데 실패했습니다.');
                    }
                });
            }

            function drawChart(data) {
                // 연도별로 기상 상태를 기준으로 부상자 수를 집계
                var yearData = {};

                data.forEach(function(item) {
                    if (!yearData[item.YEAR]) {
                        yearData[item.YEAR] = { '눈': 0, '비': 0, '안개': 0, '흐림': 0 };
                    }
                    yearData[item.YEAR][item.CONDITION] = item.INJURY;
                });

                // 연도별 데이터 배열 생성
                var seriesData = {
                    '눈': [],
                    '비': [],
                    '안개': [],
                    '흐림': []
                };

                for (var year in yearData) {
                    seriesData['눈'].push([year, yearData[year]['눈']]);
                    seriesData['비'].push([year, yearData[year]['비']]);
                    seriesData['안개'].push([year, yearData[year]['안개']]);
                    seriesData['흐림'].push([year, yearData[year]['흐림']]);
                }

                // Highcharts 차트 설정
                Highcharts.chart('chartContainer', {
                    chart: {
                        type: 'line'
                    },
                    title: {
                        text: null // 제목 비활성화
                    },
                    xAxis: {
                        categories: Object.keys(yearData), // 연도
                        title: {
                            text: '연도'
                        }
                    },
                    yAxis: {
                        title: {
                            text: '부상자수'
                        },
                        type: 'logarithmic' // 로그 스케일 적용
                    },
                    series: [{
                        name: '눈',
                        data: seriesData['눈'],
                        color: '#ADD8E6'
                    }, {
                        name: '비',
                        data: seriesData['비'],
                        color: '#4682B4'
                    }, {
                        name: '안개',
                        data: seriesData['안개'],
                        color: '#D3D3D3'
                    }, {
                        name: '흐림',
                        data: seriesData['흐림'],
                        color: '#B0C4DE'
                    }],
                    legend: {
                        enabled: true, // 범례 활성화
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    },
                    tooltip: {
                        shared: true,
                        useHTML: true,
                        headerFormat: '<b>{point.key}</b><br/>',
                        pointFormat: '{series.name}: {point.y}<br/>'
                    }
                });
            }
        });
    </script>
</div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
