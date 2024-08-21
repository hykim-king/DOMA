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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
    <style>
		 .center-content {
		    text-align: center;
		    margin: 20px 0;
		}
		
		.button-container {
		    display: flex;
		    justify-content: center;
		    flex-wrap: wrap;
		    margin: 20px 0;
		    gap: 5px; /* 버튼 간의 간격을 5px로 줄임 */
		    width: 100%;
		    max-width: 1200px;
		    margin-left: auto;
		    margin-right: auto;
		}
		
		.button-row {
		    display: flex;
		    justify-content: center;
		    gap: 10px;
		    margin-bottom: 10px;
		    flex-wrap: wrap;
		    width: 100%;
		}
		
		.showChartsButton {
		    padding: 0 20px; /* 패딩을 상하 0, 좌우 20px로 설정 */
		    font-size: 14px;
		    width: 220px; /* 버튼 너비를 220px로 설정 */
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

		/* 마우스 호버 시 스타일 */
		.showChartsButton:hover {
		    background-color: #f0f0f0; /* 호버 시 배경색 */
		    color: #333333; /* 호버 시 텍스트 색상 */
		    border-color: #999999; /* 호버 시 테두리 색상 */
		}
		
		#chartContainer {
		    width: 100%;
		    height: 500px;
		    margin-top: 20px;
		    margin-left: 100px; /* 왼쪽 마진 */
		    margin-right: 100px; /* 오른쪽 마진 */
		    margin-bottom: 40px; /* 아래쪽 마진 */
		}

    </style>
<body>

    <div class="center-content">
        <h1>연도별 기상사고</h1>
    </div>
    <!-- 버튼 컨테이너 -->
    <div class="button-container">
          <div class="button-row">
        <button class="showChartsButton">월별 교통사고</button>
        <button class="showChartsButton">요일별 교통사고</button>
        <button class="showChartsButton">시간대별 교통사고</button>
        <button class="showChartsButton">주야별 교통사고</button>
        <button class="showChartsButton">사고유형별 교통사고</button>
    </div>
    <div class="button-row">
        <button class="showChartsButton">사고종류별 교통사고</button>
        <button class="showChartsButton">구별 교통사고</button>
        <button class="showChartsButton">연도별 기상사고(구)</button>
        <button class="showChartsButton">연도별 기상상태와 부상자 수</button>
        <button class="showChartsButton">구별 기상상태와 부상자 수</button>
    </div>
    </div>
    <!-- 연도 선택 버튼 컨테이너 -->
<div class="year-button-container">
    <c:forEach var="year" begin="2005" end="2023">
        <button class="year-button" data-year="${year}">${year}</button>
    </c:forEach>
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
            google.charts.load('current', { 'packages': ['corechart'] });
            google.charts.setOnLoadCallback(function () {
                // 구별로 부상자 수 합산을 위한 객체
                var regionInjuryCount = {};

                // 데이터를 순회하며 각 구별로 부상자 수를 합산
                data.forEach(function (item) {
                    if (regionInjuryCount[item.REGION]) {
                        regionInjuryCount[item.REGION] += item.INJURYCOUNT;
                    } else {
                        regionInjuryCount[item.REGION] = item.INJURYCOUNT;
                    }
                });

                // 차트 데이터 배열 생성
                var chartDataArray = [];

                // 첫 번째 행에 헤더를 추가합니다 (구 이름, 부상자 수)
                chartDataArray.push(['Region', 'Injury Count']);

                // 구별로 합산된 데이터를 배열에 추가
                for (var region in regionInjuryCount) {
                    chartDataArray.push([region, regionInjuryCount[region]]);
                }

                // 데이터 오름차순으로 정렬 (부상자 수 기준)
                chartDataArray.sort(function(a, b) {
                    return b[1] - a[1]; // 내림차순 정렬
                });

                // 구글 차트 데이터 테이블로 변환
                var chartData = google.visualization.arrayToDataTable(chartDataArray);

                // 차트 옵션 설정
                var options = {
                    title: 'Total Injury Count by Region',
                    legend: { position: 'none' },
                    hAxis: {
                        title: 'Injury Count',
                        slantedText: true,  // x축 텍스트 기울이기
                        slantedTextAngle: 45 // 텍스트 기울기 각도
                    },
                    vAxis: {
                        title: 'Region',
                        textStyle: {
                            fontSize: 12
                        },
                        viewWindow: {
                            min: 0
                        }
                    },
                    bars: 'horizontal',  // 세로 막대 그래프
                    chartArea: { width: '70%' },  // 차트 영역 너비
                };

                // 차트 그리기
                var chart = new google.visualization.BarChart(document.getElementById('chartContainer'));
                chart.draw(chartData, options);
            });
        }
    });
</script>

</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>