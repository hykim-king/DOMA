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
	    <div id="subMap" style="height : 815px;">
			<section id="mapContainer">
				<div class="aside" style="height:800px; width: 350px; overflow : scroll">
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
										<td style="border: 1px solid black; text-align : center; width : 230px;">${occur.accdient}건</td>
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
       		       <div id="map" style="width:100%;height:800px"></div>
	</div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    <script src="${CP}/resources/js/main/main_occur_detail.js"></script>
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
</body>
</html>
	    