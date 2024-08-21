<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOMA</title>
<!-- Google Charts Loader -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
     <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            fetch('${CP}/chart/chartDataGname.do')
                .then(response => response.json())
                .then(data => {
                    // Prepare data for each chart
                    const gnameData = {
                        categories: data.gnameDead.map(item => item.GNAME),
                        deathData: data.gnameDead.map(item => item.TOTAL_DEATHS),
                        casualtiesData: data.gnameCasualties.map(item => item.TOTAL_CASUALTIES),
                        seriouslyData: data.gnameSeriously.map(item => item.TOTAL_SERIOUSLY)
                    };

                    // Calculate total for each category
                    const totalData = gnameData.categories.map((category, index) => ({
                        name: category,
                        total: gnameData.deathData[index] + gnameData.casualtiesData[index] + gnameData.seriouslyData[index],
                        death: gnameData.deathData[index],
                        casualties: gnameData.casualtiesData[index],
                        seriously: gnameData.seriouslyData[index]
                    }));

                    // Sort categories by total value in descending order
                    totalData.sort((a, b) => b.total - a.total);

                    // Extract sorted data
                    const sortedCategories = totalData.map(item => item.name);
                    const sortedDeathData = totalData.map(item => item.death);
                    const sortedCasualtiesData = totalData.map(item => item.casualties);
                    const sortedSeriouslyData = totalData.map(item => item.seriously);

                    Highcharts.chart('chartContainer', {
                        chart: {
                            type: 'bar',
                            marginRight: 150
                        },
                        xAxis: {
                            categories: sortedCategories,
                            title: {
                                text: '지역'
                            }
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: '수',
                                align: 'high'
                            },
                            stackLabels: {
                                enabled: true
                            }
                        },
                        legend: {
                            align: 'right',
                            verticalAlign: 'top',
                            layout: 'vertical',
                            x: -10,
                            y: 20,
                            floating: true,
                            backgroundColor: Highcharts.defaultOptions.legend.backgroundColor || 'white',
                            borderColor: '#CCC',
                            borderWidth: 1,
                            shadow: false
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
                            name: '사망자 수',
                            data: sortedDeathData,
                            color: '#ff4e50'
                        }, {
                            name: '부상자 수',
                            data: sortedCasualtiesData,
                            color: '#f9d423'
                        }, {
                            name: '중상자 수',
                            data: sortedSeriouslyData,
                            color: '#fc913a'
                        }]
                    });
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        });
    </script>

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
			    gap: 10px; /* 버튼 간의 간격을 10px로 설정 */
			    width: 100%;
			    max-width: 1200px;
			    margin-left: auto;
			    margin-right: auto;
			}
			
			.button-row {
			    display: flex;
			    justify-content: center;
			    gap: 10px; /* 버튼 간의 간격을 10px로 설정 */
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
			
			.chart-container {
			    display: flex;
			    justify-content: center; /* Align charts to the center */
			    flex-wrap: nowrap; /* Arrange charts horizontally */
			    margin: 10px; /* Add margin around the container */
			    height: calc(100vh - 80px); /* Adjust height to fit viewport minus footer height (예: 80px) */
			    overflow: auto; /* Add scrollbars if content overflows */
			    gap: 20px; /* Add space between chart boxes */
			}
			
			.chart-box {
			    width: 30%; /* Set width of each chart box */
			    box-sizing: border-box; /* Ensure padding and border are included in width */
			}
			
			/* Remove margin from the last chart box */
			.chart-box:last-child {
			    margin-right: 0;
			}
			
			.chart-box canvas {
			    width: 100% !important; /* Make canvas fill the chart box width */
			    height: auto !important; /* Maintain aspect ratio */
			}



</style>
</head>
<body>

    <div class="center-content">
        <h1>지역별 총 사망자 수 및 부상자 수</h1>
    </div>
    <!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
	<!-- 차트 컨테이너 -->
<div id="chartContainer" style="height: 500px; margin: 0 auto;"></div>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</body> 
</html>
