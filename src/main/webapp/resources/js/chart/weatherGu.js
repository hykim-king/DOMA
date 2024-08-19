// Function to load chart data
function loadChartData() {
    const selectedGu = gname; // 선택된 구 이름 배열
    
    // 파라미터 객체 생성
    const params = {
        gname: selectedGu
    };

    // 쿼리 문자열 생성
    const queryString = buildQueryParams(params);
    
    // 데이터 요청 URL
    const url = `/doma/chart/weatherConditionForGnames.do?${queryString}`;

    // Validate number of selected regions
    if (selectedGu.length < 3 || selectedGu.length > 10) {
        alert('최소 3개, 최대 10개의 구를 선택해야 합니다.');
        return;
    }

    $.ajax({
        url: url, // 데이터 요청 URL
        method: 'GET',
        success: function(response) {
            console.log('Response:', response); // Data for debugging
            drawChart(response);
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error);
            alert('데이터를 가져오는 데 실패했습니다.');
        }
    });
}

function buildQueryParams(params) {
    return Object.keys(params)
        .map(key => {
            if (Array.isArray(params[key])) {
                return params[key]
                    .map(value => `${encodeURIComponent(key)}=${encodeURIComponent(value)}`)
                    .join('&');
            } else {
                return `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`;
            }
        })
        .join('&');
}

function drawChart(data) {
    google.charts.setOnLoadCallback(function () {
        // 데이터 형식을 변환하여 2차원 배열 생성
        var chartDataArray1 = []; // For low-frequency weather conditions
        var chartDataArray2 = []; // For high-frequency weather conditions

        // 첫 번째 행: 헤더 추가 (기상 상태와 선택된 구들)
        const header = ['Weather Condition'];
        gname.forEach(gu => header.push(gu));
        
        // 기상 상태별로 부상자 수를 모은 객체 초기화
        const weatherConditions1 = ['안개', '기타/불명', '눈'];
        const weatherConditions2 = ['비', '흐림'];
        
        const conditionData1 = {};
        const conditionData2 = {};
        
        weatherConditions1.forEach(condition => {
            conditionData1[condition] = gname.map(() => 0); // 구별로 0으로 초기화된 배열
        });
        
        weatherConditions2.forEach(condition => {
            conditionData2[condition] = gname.map(() => 0); // 구별로 0으로 초기화된 배열
        });
        
        // 데이터를 기상 상태별로 구분하여 부상자 수를 집계
        data.forEach(function (item) {
            if (gname.includes(item.GNAME)) {
                const guIndex = gname.indexOf(item.GNAME);
                if (weatherConditions1.includes(item.WEATHER_CONDITION)) {
                    conditionData1[item.WEATHER_CONDITION][guIndex] = item.TOTAL_INJURY;
                } else if (weatherConditions2.includes(item.WEATHER_CONDITION)) {
                    conditionData2[item.WEATHER_CONDITION][guIndex] = item.TOTAL_INJURY;
                }
            }
        });
        
        // 조건별로 데이터를 2차원 배열에 추가
        weatherConditions1.forEach(condition => {
            const row = [condition];
            row.push(...conditionData1[condition]);
            chartDataArray1.push(row);
        });
        
        weatherConditions2.forEach(condition => {
            const row = [condition];
            row.push(...conditionData2[condition]);
            chartDataArray2.push(row);
        });
        
        console.log('2D Array for Chart 1:', chartDataArray1); // Low-frequency conditions
        console.log('2D Array for Chart 2:', chartDataArray2); // High-frequency conditions
        
        // 구글 차트를 그리기 위한 데이터 테이블 생성
        var dataTable1 = google.visualization.arrayToDataTable([header].concat(chartDataArray1));
        var dataTable2 = google.visualization.arrayToDataTable([header].concat(chartDataArray2));

        // 차트 옵션 설정
        var options = {
            title: '기상 상태에 따른 부상자 수',
            isStacked: true,
            hAxis: { title: '총 부상자 수' },
            vAxis: { title: '기상 상태' },
            legend: { position: 'top', maxLines: 3 }
        };
        
        // 차트 그리기
        var chart1 = new google.visualization.BarChart(document.getElementById('chartContainer1'));
        var chart2 = new google.visualization.BarChart(document.getElementById('chartContainer2'));

        chart1.draw(dataTable1, options);
        chart2.draw(dataTable2, options);
    });
}
