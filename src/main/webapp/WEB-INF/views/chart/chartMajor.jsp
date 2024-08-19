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
<script src="${CP}/resources/js/chart/chart.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        fetch('${CP}/chart/chartDataMajor.do')
            .then(response => response.json())
            .then(data => {
                const dataTable = new google.visualization.DataTable();
                dataTable.addColumn('string', '사고 유형');
                dataTable.addColumn('number', '사망자 수');
                dataTable.addColumn('number', '부상자 수');
                dataTable.addColumn('number', '중상자 수');

                data.majorDead.forEach((item, index) => {
                    const accidentType = item.MAJOR_NAME;
                    const deaths = item.TOTAL_DEATHS;
                    const casualties = data.majorCasualties[index].TOTAL_CASUALTIES;
                    const seriously = data.majorSeriously[index].TOTAL_SERIOUSLY;
                    dataTable.addRow([accidentType, deaths, casualties, seriously]);
                });

                const options = {
                    title: '사고 유형별 사망자 수, 부상자 수 및 중상자 수',
                    chartArea: {width: '70%', height: '70%'},
                    hAxis: {
                        title: '사고 유형',
                        titleTextStyle: {color: '#333'}
                    },
                    vAxis: {
                        minValue: 0
                    },
                    seriesType: 'bars',
                    series: {
                        0: {type: 'bars', color: '#FF0000'},  // 사망자 수 - 빨간색 막대
                        1: {type: 'bars', color: '#FFFF00'},  // 부상자 수 - 노란색 막대
                        2: {type: 'line', color: '#0000FF'}   // 중상자 수 - 파란색 선
                    },
                    animation: {
                        startup: true,
                        duration: 1000,
                        easing: 'out'
                    },
                    tooltip: {isHtml: true},
                    legend: {position: 'bottom'}
                };

                const chart = new google.visualization.ComboChart(document.getElementById('comboChart'));
                chart.draw(dataTable, options);

                // 차트 클릭 이벤트 핸들러
                google.visualization.events.addListener(chart, 'select', function() {
                    const selectedItem = chart.getSelection()[0];
                    if (selectedItem) {
                        const accidentType = dataTable.getValue(selectedItem.row, 0);
                        alert(accidentType + '이 선택되었습니다.');
                    }
                });
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
        <h1>사고 유형별 사망자 수 및 부상자 수</h1>
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
        <button class="showChartsButton">연도별 기상사고</button>
        <button class="showChartsButton">연도별 기상사고 발생 빈도</button>
        <button class="showChartsButton">연도별 부상자 상위 5개 구</button>
        <button class="showChartsButton">시군구별 기상상태와 부상자 수</button>
    </div>
    
    <!-- 콤보 차트 컨테이너 -->
    <div id="comboChart" style="width: 100%; height: 500px; margin: 0 auto;"></div>

</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
