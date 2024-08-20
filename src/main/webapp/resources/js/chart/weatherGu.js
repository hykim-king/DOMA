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
        // 기상 상태를 기준으로 데이터를 분리
        const weatherConditions = ['안개', '눈', '비', '흐림'];
        const chartContainers = ['chartContainer1', 'chartContainer2', 'chartContainer3', 'chartContainer4'];

        const conditionData = {};

        // 기상 상태별로 초기화
        weatherConditions.forEach(condition => {
            conditionData[condition] = gname.map(() => 0); // 구별로 0으로 초기화된 배열
        });

        // 데이터를 기상 상태별로 구분하여 부상자 수를 집계
        data.forEach(function (item) {
            if (gname.includes(item.GNAME) && weatherConditions.includes(item.WEATHER_CONDITION)) {
                const guIndex = gname.indexOf(item.GNAME);
                conditionData[item.WEATHER_CONDITION][guIndex] = item.TOTAL_INJURY;
            }
        });

        // 각 기상 상태별로 파이차트 생성
        weatherConditions.forEach((condition, index) => {
            const chartDataArray = [['구 이름', '부상자 수']];
            gname.forEach((gu, i) => {
                chartDataArray.push([gu, conditionData[condition][i]]);
            });

            const dataTable = google.visualization.arrayToDataTable(chartDataArray);

            // 가장 큰 값 찾기
            const maxInjury = Math.max(...chartDataArray.slice(1).map(row => row[1]));

            // 최대값을 가진 모든 인덱스 찾기
            const maxIndices = chartDataArray.slice(1).reduce((indices, row, idx) => {
                if (row[1] === maxInjury) indices.push(idx);
                return indices;
            }, []);

            // slices 옵션 생성: 최대값을 가진 슬라이스 강조
            const slices = {};
            maxIndices.forEach(idx => {
                slices[idx] = { offset: 0.1 };
            });

            // 옵션 설정
            const options = {
                title: condition + '에 따른 부상자 수',
                pieSliceText: 'value',
                slices: slices,  // 강조할 슬라이스 설정
                legend: { position: 'right' },
            };

            // 차트 그리기
            const chart = new google.visualization.PieChart(document.getElementById(chartContainers[index]));
            chart.draw(dataTable, options);
        });
    });
}