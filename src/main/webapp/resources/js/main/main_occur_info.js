function loadYearGuMarkers(year, riskLevels) {
    // 배열을 쿼리 매개변수로 변환

    const fqParams = riskLevels.map(fq => `accFrequencyList=${encodeURIComponent(fq)}`).join('&');                
    
    $.ajax({
        url: `/doma/point/yearguSelect.do?year=${encodeURIComponent(year)}&${fqParams}`,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            removeExistingMarkers();
            // 지도에 마커 추가
            addMarkersToMap(response);            
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error);
        }
    });
}
