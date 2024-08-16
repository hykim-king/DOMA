<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>월별 사망자 수 및 부상자 수 차트</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawCharts);

        function drawCharts() {
            fetch('http://localhost:8080/doma/chart/chartData.do')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('네트워크 오류');
                    }
                    return response.json();
                })
                .then(data => {
                    const deathData = data.map(item => [item.MONTH, item.TOTAL_DEATHS]);
                    const casualtiesData = data.map(item => [item.MONTH, item.TOTAL_CASUALTIES]);
                    const seriouslyData = data.map(item => [item.MONTH, item.TOTAL_SERIOUSLY]);
                    
                    // DataTable 생성 - 사망자 수
                    const deathDataTable = new google.visualization.DataTable();
                    deathDataTable.addColumn('string', '월');
                    deathDataTable.addColumn('number', '총 사망자 수');
                    deathDataTable.addRows(deathData);

                    // DataTable 생성 - 부상자 수
                    const casualtiesDataTable = new google.visualization.DataTable();
                    casualtiesDataTable.addColumn('string', '월');
                    casualtiesDataTable.addColumn('number', '총 부상자 수');
                    casualtiesDataTable.addRows(casualtiesData);
                    
                    const seriouslyDataTable = new google.visualization.DataTable();
                    seriouslyDataTable.addColumn('string', '월');
                    seriouslyDataTable.addColumn('number', '총 중상자 수');
                    seriouslyDataTable.addRows(seriouslyData);

                    // 차트 옵션 설정 - 사망자 수
                    const deathOptions = {
                        title: '월별 총 사망자 수',
                        hAxis: {
                            title: '월',
                            titleTextStyle: {color: '#333'}
                        },
                        vAxis: {
                            title: '총 사망자 수',
                            minValue: 0
                        },
                        chartArea: {width: '70%', height: '70%'},
                        bars: 'vertical',
                        animation: {
                            startup: true,
                            duration: 1000,
                            easing: 'out'
                        }
                    };

                    // 차트 옵션 설정 - 부상자 수
                    const casualtiesOptions = {
                        title: '월별 총 부상자 수',
                        hAxis: {
                            title: '월',
                            titleTextStyle: {color: '#333'}
                        },
                        vAxis: {
                            title: '총 부상자 수',
                            minValue: 0
                        },
                        chartArea: {width: '70%', height: '70%'},
                        bars: 'vertical',
                        animation: {
                            startup: true,
                            duration: 1000,
                            easing: 'out'
                        }
                    };
                    
                    const seriouslyOptions = {
                            title: '월별 총 중상자 수',
                            hAxis: {
                                title: '월',
                                titleTextStyle: {color: '#333'}
                            },
                            vAxis: {
                                title: '총 중상자 수',
                                minValue: 0
                            },
                            chartArea: {width: '70%', height: '70%'},
                            bars: 'vertical',
                            animation: {
                                startup: true,
                                duration: 1000,
                                easing: 'out'
                            }
                        };

                    // 차트 렌더링 - 사망자 수
                    const deathChart = new google.visualization.BarChart(document.getElementById('deathChart'));
                    deathChart.draw(deathDataTable, deathOptions);

                    // 차트 렌더링 - 부상자 수
                    const casualtiesChart = new google.visualization.BarChart(document.getElementById('casualtiesChart'));
                    casualtiesChart.draw(casualtiesDataTable, casualtiesOptions);
                    
                    const seriouslyChart = new google.visualization.BarChart(document.getElementById('seriouslyChart'));
                    seriouslyChart.draw(seriouslyDataTable, seriouslyOptions);
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        }
    </script>
    <style>
        .chart-container {
            display: flex;
            justify-content: space-between;
        }
        .chart-box {
            width: 33%;
        }
    </style>
</head>
<body>
    <h1>월별 총 사망자 수 및 부상자 수</h1>
    
    <div class="chart-container">
        <!-- 사망자 수 차트 -->
        <div id="deathChart" class="chart-box" style="height: 400px;"></div>
        
        <!-- 부상자 수 차트 -->
        <div id="casualtiesChart" class="chart-box" style="height: 400px;"></div>
        
        <!-- 중상자 수 차트 -->
        <div id="seriouslyChart" class="chart-box" style="height: 400px;"></div>
    </div>
</body>
</html>
