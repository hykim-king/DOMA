	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="${CP}/resources/css/main/main_emergency_info.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div style="display : flex">
		<jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
	    <div id="subMap" style="height : 815px; diplay : inline-block">
			<section id="mapContainer">
				<div class="aside" style="height:820px; width: 350px; overflow : scroll; diplay : inline-block" >
					<h2 style="font-wight : bold; text-align : center; border: 3px solid black">사고다발</h2>
					<c:forEach var="occur" items="${pointData }">
					<ul class="info_ul">
						<li>
							<table class="info_table">
								<colgroup>
									<col>
									<col>
								</colgroup>
								<tbody>
									<tr>
										<input type="button" onclick="detailSelect(this.value)" id="occur_year${occur.year}" name="occur_year${occur.year}" value="${occur.year}" style="background-color:white; width:331px;font-wight : bold; text-align : center; border: 3px solid black;">
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;" >사고</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${occur.accident}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">사망</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${occur.dead}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">중상</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${occur.seriously}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">경상</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${occur.ordinary}건</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black;">사건접수</th>
										<td style="border: 1px solid black; text-align : center; width : 230px;">${occur.report}건</td>
									</tr>
								</tbody>
							</table>
						</li>
					</ul>
					</c:forEach>
				</div>
			</section>
   			</div>
   			<jsp:include page="/WEB-INF/views/main/main_point_detail.jsp"></jsp:include>
       		<jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
	</div>
<script src="${CP}/resources/js/main/main_occur_detail.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	
	mapOption = { 
	    center: new kakao.maps.LatLng(37.564214, 127.001699), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	    
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	 map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
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
</script>
<script>

var map; // 전역 변수로 선언
var markers = []; // 마커들을 저장할 배열
var currentInfoWindow = null; // 현재 열려 있는 인포윈도우

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
            
         	// 지도에 마커 생성
            data.forEach(function(item) {
                var latlng = new kakao.maps.LatLng(parseFloat(item.latitude), parseFloat(item.longitude));
                
                var imageSrc = "/doma/resources/img/map/occur_warning.png";
                var imageSize = new kakao.maps.Size(24, 35); 
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: latlng,
                    title: item.accPoint
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: `<div style="padding:5px;">${item.accPoint}</div>`
                });

                // 마커 클릭 시 인포윈도우를 열도록 설정
                kakao.maps.event.addListener(marker, 'click', function() {
                    if (currentInfoWindow) {
                        currentInfoWindow.close(); // 현재 열린 인포윈도우 닫기
                    }
                    infowindow.open(map, marker); // 새로운 인포윈도우 열기
                    currentInfoWindow = infowindow;
                });

                // 마커 객체와 인포윈도우를 배열에 저장
                markers.push({
                    marker: marker,
                    latlng: latlng,
                    infoWindow: infowindow
                });
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
                    listItem.innerHTML = '
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
                
	            error: function(response) {
	                console.log("Error:", response);
	                console.log("yearH2.value : " + yearH2);
	                console.log("selectedValue.value : " + selectedValue);
	            }
	        });
   						
           }
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>
	    