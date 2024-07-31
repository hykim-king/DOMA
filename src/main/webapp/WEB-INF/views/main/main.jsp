<%--
/**
    Class Name: main.jsp
    Description:
    Author: acorn
    Modification information
    
    수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 7. 31        최초작성 
    
    DOMA 개발팀
    since 2020.11.23
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script> 

<style>
    body, html {
        height: 100%;
        margin: 0;
        display: flex;
        flex-direction: column;
    }
    #map {
        width: 800px;
        height: 700px;
        margin: 0 auto;
    }
</style>

<title>main</title>
</head>
<body>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

    <div style="flex: 1; display: flex; justify-content: center; align-items: center;">
        <div id="map" style="width:700px;height:400px;"></div>
    </div>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>
    <script>
        window.onload = function() {
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567),
                level: 4
            };
            var map = new kakao.maps.Map(container, options);
            
            // 교통 혼잡도 표시
            map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
            
            // 다각형을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 다각형을 표시합니다
            var polygonPath = [
                new kakao.maps.LatLng(37.566968133550304, 126.97742409773512),
                new kakao.maps.LatLng(37.56690087032515, 126.97911631874376),
                new kakao.maps.LatLng(37.565990821166096, 126.97887321579489),
                new kakao.maps.LatLng(37.56613043481272, 126.97864679733107),
                new kakao.maps.LatLng(37.56614823271141, 126.97745264256177) 
            ];

            // 지도에 표시할 다각형을 생성합니다
            var polygon = new kakao.maps.Polygon({
                path: polygonPath, // 그려질 다각형의 좌표 배열입니다
                strokeWeight: 3, // 선의 두께입니다
                strokeColor: '#39DE2A', // 선의 색깔입니다
                strokeOpacity: 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'longdash', // 선의 스타일입니다
                fillColor: '#A2FF99', // 채우기 색깔입니다
                fillOpacity: 0.7 // 채우기 불투명도 입니다
            });

            // 지도에 다각형을 표시합니다
            polygon.setMap(map);
            
            // 마커가 표시될 위치입니다 
            var markerPosition  = new kakao.maps.LatLng(37.565337286306466, 126.97719255385478); 

            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });

            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);
            
           // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
            var mapTypeControl = new kakao.maps.MapTypeControl();

            // 지도 타입 컨트롤을 지도에 표시합니다
            map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            
           // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
           // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
           map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

           // 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성합니다
           var zoomControl = new kakao.maps.ZoomControl();
           map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
        };
    </script>
  
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
<!-- Bootstrap JS -->
<script src="${CP}/resources/js/bootstrap.bundle.js"></script>    
</body>
</html>
