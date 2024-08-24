<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="${CP}/resources/css/main/main_info.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/main/main_emergency_info.js"></script>
<title>DOMA</title>
</head>
<body>
    <div id="container" style="display : flex">
    <jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
    <div id="subMap" style="height: 815px;">
        <section id="mapContainer">
            <div class="aside" style="height:800px; width: 305px; overflow : scroll">
                <h2>돌발정보</h2>
                <c:forEach var="acc" items="${accList}">
                <ul class="info_ul">
                    <li>
                        <table class="info_table">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <td colspan="2" style="cursor: pointer; box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);"
                                        onclick="moveToMarker('${acc.latitude}', '${acc.longitude}')">${acc.accName} : ${acc.accDName}</td>
                                </tr>
                                <tr>
                                    <th class="info_th">기간</th>
                                    <td style="background-color: #F4F4F4; border: 1px solid #ffffff; font-weight: normal;">${acc.occrDate} ${acc.occrTime} ~ <br>${acc.endDate} ${acc.endTime}</td>
                                </tr>
                                <tr>
                                    <th class="info_th">돌발유형</th>
                                    <td style="background-color: #F4F4F4; border: 1px solid #ffffff; font-weight: normal;">${acc.accDName}</td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="background-color: #FFFACF; border: 1px solid white; font-weight: normal;">${acc.info}</td>
                                </tr>
                            </tbody>
                        </table>
                    </li>
                </ul>
                </c:forEach>
            </div>
        </section>
    </div>            
            <jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    </body>
<script>
var map;
var markers = []; // 모든 마커를 저장할 배열
var currentInfoWindow = null; // 현재 열려 있는 인포윈도우

function loadKakaoMapScript(callback) {
    var script = document.createElement('script');
    script.onload = callback;
    script.src = "https://dapi.kakao.com/v2/maps/sdk.js?appkey=940c61b2edb65a3a454f86781d95d116&autoload=false";
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
        // 교통 혼잡도 표시
        map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
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
                info: "${A01.info}",
                accId: "${A01.accId}"
            }<c:if test="${!A01Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A02" items="${A02List}" varStatus="A02Status">
            {
                latlng: new kakao.maps.LatLng('${A02.latitude}', '${A02.longitude}'),
                imageSrc: "${CP}/resources/img/map/A02.png",
                info: "${A02.info}",
                accId: "${A02.accId}"
            }<c:if test="${!A02Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A03" items="${A03List}" varStatus="A03Status">
            {
                latlng: new kakao.maps.LatLng('${A03.latitude}', '${A03.longitude}'),
                imageSrc: "${CP}/resources/img/map/A03.png",
                info: "${A03.info}",
                accId: "${A03.accId}"
            }<c:if test="${!A03Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A04" items="${A04List}" varStatus="A04Status">
            {                 
                latlng: new kakao.maps.LatLng('${A04.latitude}', '${A04.longitude}'),
                imageSrc: "${CP}/resources/img/map/A04.png",
                info: "${A04.info}",
                accId: "${A04.accId}" 
            }<c:if test="${!A04Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A05" items="${A05List}" varStatus="A05Status">
            {                 
                latlng: new kakao.maps.LatLng('${A05.latitude}', '${A05.longitude}'),
                imageSrc: "${CP}/resources/img/map/A05.png",
                info: "${A05.info}",
                accId: "${A05.accId}"
            }<c:if test="${!A05Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A06" items="${A06List}" varStatus="A06Status">
            {                 
                latlng: new kakao.maps.LatLng('${A06.latitude}', '${A06.longitude}'),
                imageSrc: "${CP}/resources/img/map/A06.png",
                info: "${A06.info}",
                accId: "${A05.accId}"
            }<c:if test="${!A06Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A07" items="${A07List}" varStatus="A07Status">
            {                 
                latlng: new kakao.maps.LatLng('${A07.latitude}', '${A07.longitude}'),
                imageSrc: "${CP}/resources/img/map/A07.png",
                info: "${A07.info}",
                accId: "${A07.accId}"
            }<c:if test="${!A07Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A08" items="${A08List}" varStatus="A08Status">
            {                 
                latlng: new kakao.maps.LatLng('${A08.latitude}', '${A08.longitude}'),
                imageSrc: "${CP}/resources/img/map/A08.png",
                info: "${A08.info}",
                accId: "${A08.accId}"
            }<c:if test="${!A08Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A09" items="${A09List}" varStatus="A09Status">
            {                 
                latlng: new kakao.maps.LatLng('${A09.latitude}', '${A09.longitude}'),
                imageSrc: "${CP}/resources/img/map/A09.png",
                info: "${A09.info}",
                accId: "${A09.accId}"
            }<c:if test="${!A09Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A10" items="${A10List}" varStatus="A10Status">
            {                 
                latlng: new kakao.maps.LatLng('${A10.latitude}', '${A10.longitude}'),
                imageSrc: "${CP}/resources/img/map/A10.png",
                info: "${A10.info}",
                accId: "${A10.accId}"
            }<c:if test="${!A10Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A11" items="${A11List}" varStatus="A11Status">
            {                 
                latlng: new kakao.maps.LatLng('${A11.latitude}', '${A11.longitude}'),
                imageSrc: "${CP}/resources/img/map/A11.png",
                info: "${A11.info}",
                accId: "${A11.accId}"
            }<c:if test="${!A11Status.last}">,</c:if>
            </c:forEach>,
            <c:forEach var="A12" items="${A12List}" varStatus="A12Status">
            {                 
                latlng: new kakao.maps.LatLng('${A12.latitude}', '${A12.longitude}'),
                imageSrc: "${CP}/resources/img/map/A12.png",
                info: "${A12.info}",
                accId: "${A12.accId}"
            }<c:if test="${!A12Status.last}">,</c:if>
            </c:forEach>
        ];

        var imageSize = new kakao.maps.Size(26, 26);
        positions.forEach(function(pos) {
        	var accId = pos.accId;
            var markerImage = new kakao.maps.MarkerImage(pos.imageSrc, imageSize);
            var marker = new kakao.maps.Marker({
                map: map,
                position: pos.latlng,
                image: markerImage
            });
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:10px; font-size:12px; color:white; background-color:black; width: 200px; white-space: normal; word-break: break-word;">' + pos.info + '</div>'
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

         // 마커에 마우스아웃 이벤트를 등록합니다
            kakao.maps.event.addListener(marker, 'click', function() {                
                infowindow.close();
                cctvInfo(accId);
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
</html>