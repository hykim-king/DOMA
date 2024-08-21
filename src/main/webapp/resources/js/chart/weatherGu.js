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
		    if (selectedGu.length < 3) {
		        alert('최소 3개 구를 선택해야 합니다.');
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
		    // 기상 상태를 기준으로 데이터를 분리
		    const weatherConditions = ['안개', '눈', '비', '흐림'];
		    const chartContainers = ['chartContainer1', 'chartContainer2', 'chartContainer3', 'chartContainer4'];
		    const colors = {
		        '안개': '#D3D3D3', // 연한 회색
		        '눈': '#ADD8E6',  // 연한 파란색
		        '비': '#4682B4',  // 강한 파란색
		        '흐림': '#B0C4DE'  // 연한 파란색
		    };
		    const conditionData = {};
		
		    // 기상 상태별로 초기화
		    weatherConditions.forEach(condition => {
		        conditionData[condition] = gname.map(gu => ({
		            name: gu,
		            value: 0,
		            color: colors[condition] // 색상 추가
		        }));
		    });
		
		    // 데이터를 기상 상태별로 구분하여 부상자 수를 집계
		    data.forEach(function (item) {
		        if (gname.includes(item.GNAME) && weatherConditions.includes(item.WEATHER_CONDITION)) {
		            const guIndex = gname.indexOf(item.GNAME);
		            conditionData[item.WEATHER_CONDITION][guIndex].value = item.TOTAL_INJURY;
		        }
		    });
		
		    // 각 기상 상태별로 트리맵 차트 생성
		    weatherConditions.forEach((condition, index) => {
		        Highcharts.chart(chartContainers[index], {
		            chart: {
		                type: 'treemap',
		                height: null,  // 컨테이너의 높이에 맞추기 위해 null 설정
		                width: null,   // 컨테이너의 너비에 맞추기 위해 null 설정
		            },
		            title: {
		                text: condition,
		                style: {
		                    fontSize: '16px', // 제목 글자 크기 조정
		                    color: '#333333'   // 제목 색상
		                }
		            },
		            series: [{
		                layoutAlgorithm: 'squarified',
		                data: conditionData[condition],
		                colorByPoint: true // 포인트별 색상 사용
		            }],
		            plotOptions: {
		                treemap: {
		                    dataLabels: {
		                        enabled: true,
		                        format: '{point.name}: {point.value}',
		                        style: {
		                            fontSize: '12px', // 글자 크기 설정
		                            color: '#000000'  // 글자 색상 설정
		                        }
		                    }
		                }
		            },
		            credits: {
		                enabled: false // 차트 하단의 Highcharts 로고 제거
		            },
		        });
		    });
		}