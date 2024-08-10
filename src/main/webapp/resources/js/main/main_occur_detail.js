function detailSelect(input) {
    console.log("detailSelect()");
    console.log("input : " + input);
    
    // 'yearH2' 요소와 'detailInfo' 요소 가져오기
    const yearSelect = input;
    const detailInfo = document.querySelector('#detailInfo');
    const yearH2 = document.querySelector('#yearH2');
    const gnameDiv = document.querySelector('#gnameDiv');
    
    // 'detailInfo' 요소 표시
    if (detailInfo.style.display == 'none') {
        detailInfo.style.display = 'block';
    }

    
    // 'yearH2'에 연도 표시
    yearH2.textContent = yearSelect;

    // Ajax 요청
    $.ajax({
        type: "POST",
        url: "/doma/point/guListLoad.do",
        async: true, // 'async'로 수정
        dataType: "html",
        data: {
            "year": input
        },
        success: function(response) {
            console.log("success response:" + response);
            
            // JSON 데이터로 파싱
            const data = JSON.parse(response);
            console.log("Parsed data:" + data);

            // 기존의 select 박스 초기화
            gnameDiv.innerHTML = '<option value="">전체</option>';
            
            // 받아온 데이터로 select 박스 옵션 추가
            data.forEach(function(gu) {
                const option = document.createElement('option');
                option.value = gu;
                option.text = gu;
                gnameDiv.appendChild(option);
            });
        },
        error: function(response) {
            console.log("error:" + response);
        }
    });
     
}

// 외부에서 돌발정보 클릭 시 인포윈도우 열기
function onInfoClick(lat, lng) {
    moveToMarker(lat, lng);
}

document.getElementById('gnameDiv').addEventListener('change', function() {
    const selectedValue = this.value;
    const yearH2 = document.querySelector('#yearH2').innerText;
    const detailInfo = document.querySelector('#detail_info');
    console.log("Selected Value:", selectedValue);
    console.log("yearH2 :", yearH2);

    if (selectedValue) { 
        $.ajax({
            type: "POST",
            url: "/doma/point/pointDetail.do", 
            data:{
		        "year": yearH2,
		        "gname": selectedValue
		    },
            success: function(response) {
                console.log("통신 성공 :", response);
                const data = JSON.parse(response);
	
                // 기존의 <ul> 요소 비우기
                detailInfo.innerHTML = '';

                // 데이터 배열이 있다고 가정하고 각 항목을 li로 추가
                data.forEach(function(item) {
                    const listItem = document.createElement('ul');
                    listItem.innerHTML = `
                        <table class="info_table">
								<colgroup>
									<col>
									<col>
								</colgroup>
								<tbody>
									item : ${item}
                                    <tr>
										<input type="text" value="${item.accPoint}" onclick="moveToMarker(${item.latitude},${item.longitude})" style="background-color:white; width:331px;font-wight : bold; text-align : center; border: 3px solid black;">
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;" >사고</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.pointType}건</td>
									</tr>
                                    <tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">사망</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.accident}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">사망</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.dead}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">중상</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.seriously}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">경상</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.ordinary}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black;">사건접수</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${item.report}건</td>
									</tr>
								</tbody>
							</table>
                    `;
                    detailInfo.appendChild(listItem);
                });
                
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
			    
			    mapOption = { 
			        center: new kakao.maps.LatLng(37.564214, 127.001699), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			        
			    };
			
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				 
				// 마커를 표시할 위치와 title 객체 배열입니다 
				
				var positions = data.map(function(item) {
                    return {
                        latlng: new kakao.maps.LatLng(parseFloat(item.latitude), parseFloat(item.longitude)), // 숫자로 변환
                        imageSrc: "/doma/resources/img/map/occur_warning.png"
                        
                    };
                    
                });
				
				// 마커 이미지의 이미지 주소입니다
				var imageSrc = "/doma/resources/img/map/occur_warning.png"; 
					
				for (var i = 0; i < positions.length; i ++) {
					
					// 마커 이미지의 이미지 크기 입니다
					var imageSize = new kakao.maps.Size(24, 35); 
					
					console.log(positions[i]);	
					// 마커 이미지를 생성합니다    
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						map: map, // 마커를 표시할 지도
						position: positions[i].latlng, // 마커를 표시할 위치
						title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						image : markerImage // 마커 이미지 
					});
				}
            },
            error: function(response) {
                console.log("Error:", response);
                console.log("yearH2.value : " + yearH2);
                console.log("selectedValue.value : " + selectedValue);
            }
        });
    }
});

function moveToMarker(lat, lng) {
    var moveLatLon = new kakao.maps.LatLng(lat, lng);
    map.setCenter(moveLatLon);

    // 클릭된 위치와 일치하는 마커를 찾습니다
    markers.forEach(function(item) {
        var markerLatLng = item.latlng;
        if (Math.abs(markerLatLng.getLat() - lat) < 0.0001 && Math.abs(markerLatLng.getLng() - lng) < 0.0001) {
            // 마커의 인포윈도우를 엽니다
            if (currentInfoWindow && currentInfoWindow !== item.infoWindow) {
                currentInfoWindow.close(); // 이전 인포윈도우 닫기
            }
            item.infoWindow.open(map, item.marker);
            currentInfoWindow = item.infoWindow; // 현재 열려 있는 인포윈도우 업데이트
        }
    });
}

