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
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    <script src="${CP}/resources/js/main/main_occur_detail.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>
<script>
    
var map;
var markers = []; // 모든 마커를 저장할 배열
var currentInfoWindow = null; // 현재 열려 있는 인포윈도우

function loadKakaoMapScript(callback) {
    var script = document.createElement('script');
    script.onload = callback;
    script.src = "https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900&autoload=false";
    document.head.appendChild(script);
}

function initKakaoMap() {
    kakao.maps.load(function() {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.564214, 127.001699),
            level: 8
        };
        map = new kakao.maps.Map(container, options);

        // 지도에 추가할 컨트롤들 초기화
        var mapTypeControl = new kakao.maps.MapTypeControl();
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

        // 모든 마커를 지도에 추가
        var positions = [
            <c:forEach var='occur' items='${item}' varStatus='status'>
            {
                latlng: new kakao.maps.LatLng(${occur.latitude}, ${occur.longitude}),
                imageSrc: '${CP}/resources/img/map/occur_warning.png',
                info: "${occur.type}'
            }<c:if test='${status.last}'></c:if>
            </c:forEach>
        ];


        var imageSize = new kakao.maps.Size(24, 35);
        positions.forEach(function(pos) {
            var markerImage = new kakao.maps.MarkerImage(pos.imageSrc, imageSize);
            var marker = new kakao.maps.Marker({
                map: map,
                position: pos.latlng,
                image: markerImage
            });
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px; font-size:12px; color:white; background-color:black;">' + pos.info + '</div>'
            });

         // 마커에 마우스오버 이벤트를 등록합니다
            kakao.maps.event.addListener(marker, 'mouseover', function() {
              // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
                infowindow.open(map, marker);
            });

            // 마커에 마우스아웃 이벤트를 등록합니다
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
                infowindow.close();
            });

            // 마커와 인포윈도우 객체를 배열에 저장합니다
            markers.push({
                marker: marker,
                infoWindow: infowindow,
                latlng: pos.latlng
            });
        });

        // 맵에 마우스 드래그 이벤트를 추가하여 인포윈도우를 닫습니다
         kakao.maps.event.addListener(map, 'dragend', function() {
            if (currentInfoWindow) {
                currentInfoWindow.close();
                currentInfoWindow = null;
            }
        }); 
    });
    

    console.log(markers);
    console.log(currentInfoWindow);
}



function moveToMarker(lat, lng) {
	console.log("moveTomarker()");
	console.log("latitude : " + lat);
	console.log("longitude : " + lng);
	
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

// 외부에서 돌발정보 클릭 시 인포윈도우 열기
function onInfoClick(lat, lng) {
    moveToMarker(lat, lng);
}

// 초기화 스크립트 로딩
loadKakaoMapScript(initKakaoMap);
</script>
</body>
</html>
	    