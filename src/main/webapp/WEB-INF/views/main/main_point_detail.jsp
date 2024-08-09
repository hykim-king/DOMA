<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<body>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="${CP}/resources/css/main/main_emergency_info.css">
<div id="detailInfo" style="width : 520px; height:800px; display:none; overflow:scroll">
	<h2 id="yearH2" style="width:300px; font-wight : bold; text-align : center; border: 3px solid black;"></h2>
	<select name="gnameDiv" class="form-select" id="gnameDiv" style="width:300px;">
        <option value="">전체</option>
	</select>
	<ul id="detail_info" class="info_ul">
	</ul>
</div>
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
            <c:forEach var="A01" items="${A01List}" varStatus="A01Status">
            {
                latlng: new kakao.maps.LatLng('${A01.latitude}', '${A01.longitude}'),
                imageSrc: "${CP}/resources/img/map/A01.png",
                info: "${A01.info}"
            }<c:if test="${!A01Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A02" items="${A02List}" varStatus="A02Status">
            {
                latlng: new kakao.maps.LatLng('${A02.latitude}', '${A02.longitude}'),
                imageSrc: "${CP}/resources/img/map/A02.png",
                info: "${A02.info}"
            }<c:if test="${!A02Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A04" items="${A04List}" varStatus="A04Status">
            {                 
                latlng: new kakao.maps.LatLng('${A04.latitude}', '${A04.longitude}'),
                imageSrc: "${CP}/resources/img/map/A04.png",
                info: "${A04.info}",
            }<c:if test="${!A04Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A10" items="${A10List}" varStatus="A10Status">
            {                 
                latlng: new kakao.maps.LatLng('${A10.latitude}', '${A10.longitude}'),
                imageSrc: "${CP}/resources/img/map/A10.png",
                info: "${A10.info}",
            }<c:if test="${!A10Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A11" items="${A11List}" varStatus="A11Status">
            {                 
                latlng: new kakao.maps.LatLng('${A11.latitude}', '${A11.longitude}'),
                imageSrc: "${CP}/resources/img/map/A11.png",
                info: "${A11.info}"
            }<c:if test="${!A11Status.last}">,</c:if>
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