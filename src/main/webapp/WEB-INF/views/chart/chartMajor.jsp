<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOMA</title>
<!-- bootstrap css -->
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

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        function drawChart() {
            fetch('${CP}/chart/chartDataMajor.do')
                .then(response => response.json())
                .then(data => {
                    // 데이터 정리
                    const accidentTypes = [];
                    const deaths = [];
                    const casualties = [];
                    const seriously = [];

                    data.majorDead.forEach((item, index) => {
                        accidentTypes.push(item.MAJOR_NAME);
                        deaths.push(item.TOTAL_DEATHS);
                        casualties.push(data.majorCasualties[index].TOTAL_CASUALTIES);
                        seriously.push(data.majorSeriously[index].TOTAL_SERIOUSLY);
                    });

                    // Highcharts 차트 생성
                    Highcharts.chart('comboChart', {
                        chart: {
                            type: 'column', // 기본 타입
                            animation: {
                                duration: 1000
                            },
                            events: {
                                load: function() {
                                    // 차트 클릭 이벤트 핸들러
                                    this.series.forEach(series => {
                                        series.points.forEach(point => {
                                            point.update({ events: { click: function() {
                                                alert(this.category + '이 선택되었습니다.');
                                            }}});
                                        });
                                    });
                                }
                            }
                        },
                        title: {
                            text: '사고 유형별 사망자 수, 부상자 수 및 중상자 수'
                        },
                        xAxis: {
                            categories: accidentTypes,
                            title: {
                                text: '사고 유형'
                            }
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: '수'
                            }
                        },
                        series: [
                            {
                                name: '사망자 수',
                                data: deaths,
                                color: '#FF0000',
                                type: 'column'
                            },
                            {
                                name: '부상자 수',
                                data: casualties,
                                color: '#FFD700',
                                type: 'column'
                            },
                            {
                                name: '중상자 수',
                                data: seriously,
                                color: '#0000FF',
                                type: 'line'
                            }
                        ],
                        legend: {
                            layout: 'horizontal',
                            align: 'center',
                            verticalAlign: 'bottom'
                        },
                        tooltip: {
                            shared: true,
                            useHTML: true
                        }
                    });
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        }

        drawChart(); // 차트 그리기 함수 호출
    });
</script>

 
</head>
<body>

    <div class="center-content">
        <h1>사고 유형별 사망자 수 및 부상자 수</h1>
    </div>
    
    <!-- 버튼 컨테이너 -->
<!-- 버튼 컨테이너 -->
<%@ include file="/WEB-INF/views/chart/chart_btn.jsp" %> 
    
    <!-- 콤보 차트 컨테이너 -->
    <div id="comboChart" style="width: 100%; height: 500px; margin: 0 auto;"></div>

</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
