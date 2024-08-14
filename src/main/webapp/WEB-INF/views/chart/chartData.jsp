<!DOCTYPE html>
<html>
<head>
    <title>월별 사망자 수 차트</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>월별 총 사망자 수</h1>
    <canvas id="myChart" width="800" height="400"></canvas>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            fetch('http://localhost:8080/doma/chart/chartData.do') // 데이터 엔드포인트 URL
                .then(response => {
                    if (!response.ok) {
                        throw new Error('네트워크 응답이 올바르지 않습니다');
                    }
                    return response.json();
                })
                .then(data => {
                    // JSON 데이터 확인
                    console.log(data);

                    // Chart.js 차트 데이터 포맷 준비
                    const labels = data.map(item => item.MONTH);
                    const values = data.map(item => item.TOTAL_DEATHS);

                    // 차트 데이터 및 옵션 설정
                    const chartData = {
                        labels: labels,
                        datasets: [{
                            label: '총 사망자 수',
                            data: values,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    };

                    const chartOptions = {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: '총 사망자 수'
                                }
                            },
                            x: {
                                title: {
                                    display: true,
                                    text: '월'
                                }
                            }
                        }
                    };

                    // Chart.js 차트 인스턴스 생성 및 렌더링
                    new Chart(document.getElementById('myChart').getContext('2d'), {
                        type: 'bar',
                        data: chartData,
                        options: chartOptions
                    });
                })
                .catch(error => console.error('차트 데이터 가져오기 오류:', error));
        });
    </script>
</body>
</html>
