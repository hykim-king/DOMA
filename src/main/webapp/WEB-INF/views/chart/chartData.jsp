<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ìë³ ì¬ë§ì ì ì°¨í¸</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>ìë³ ì´ ì¬ë§ì ì</h1>
    <canvas id="myChart" width="800" height="400"></canvas>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            fetch('http://localhost:8080/doma/chart/chartData.do') // ë°ì´í° ìëí¬ì¸í¸ URL
                .then(response => {
                    if (!response.ok) {
                        throw new Error('ë¤í¸ìí¬ ìëµì´ ì¬ë°ë¥´ì§ ììµëë¤');
                    }
                    return response.json();
                })
                .then(data => {
                    // JSON ë°ì´í° íì¸
                    

                    const convertedData = data.map(item => [item.MONTH, item.TOTAL_DEATHS]);

	                 // 차트 레이블과 값 추출
	                 const labels = convertedData.map(item => item[0]);
	                 const values = convertedData.map(item => item[1]);
	                 console.log(labels);
	                 console.log(values);
                    // ì°¨í¸ ë°ì´í° ë° ìµì ì¤ì 
                    const chartData = {
                        labels: labels,
                        datasets: [{
                            label: 'ì´ ì¬ë§ì ì',
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
                                    text: 'ì´ ì¬ë§ì ì'
                                }
                            },
                            x: {
                                title: {
                                    display: true,
                                    text: 'ì'
                                }
                            }
                        }
                    };

                    // Chart.js ì°¨í¸ ì¸ì¤í´ì¤ ìì± ë° ë ëë§
                    new Chart(document.getElementById('myChart').getContext('2d'), {
                        type: 'bar',
                        data: chartData,
                        options: chartOptions
                    });
                })
                .catch(error => console.error('ì°¨í¸ ë°ì´í° ê°ì ¸ì¤ê¸° ì¤ë¥:', error));
        });
    </script>
</body>
</html>
