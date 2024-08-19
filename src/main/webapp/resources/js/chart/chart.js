
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.showChartsButton').forEach((button, index) => {
            button.addEventListener('click', () => {
                switch (index) {
                    case 0:
                        window.location.href = '/doma/chart/chartMonth.do';
                        break;
                    case 1:
                        window.location.href = '/doma/chart/chartWeek.do';
                        break;
                    case 2:
                        window.location.href = '/doma/chart/chartHour.do';
                        break;
                    case 3:
                        window.location.href = '/doma/chart/chartNight.do'; // 예시 URL
                        break;
                    case 4:
                        window.location.href = '/doma/chart/chartMajor.do'; // 예시 URL
                        break;
                    case 5:
                        window.location.href = '/doma/chart/chartMedium.do'; // 예시 URL
                        break;
                    case 6:
                        window.location.href = '/doma/chart/chartGname.do'; // 예시 URL
                        break;
                    case 7:
                        window.location.href = '/doma/chart/chartWeatherYear.do'; // 예시 URL
                        break;
                    case 8:
                        window.location.href = '/doma/chart/chartWeatherFreq.do'; // 예시 URL
                        break;
                    case 9:
                        window.location.href = '/doma/chart/chartWeatherGuSelect.do'; // 예시 URL
                        break;
                }
            });
        });
    });
