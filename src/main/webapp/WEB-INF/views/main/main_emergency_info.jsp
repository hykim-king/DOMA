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
<link rel="stylesheet" href="${CP}/resources/css/main/main_emergency_info.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div style="display : flex">
		<jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
	    <div id="subMap" style="height : 815px;">
			<section id="mapContainer">
				<div class="aside" style="height:1000px; width: 350px; overflow : scroll">
					<h2 style="font-wight : bold; text-align : center; border: 3px solid black">돌발정보</h2>
					<c:forEach var="acc" items="${accList }">
					<ul class="info_ul">
						<li>
							<table class="info_table">
								<colgroup>
									<col>
									<col>
								</colgroup>
								<tbody>
									<tr>
										<td colspan="2" style="font-weight : bold; text-align : center; border: 1px solid black; background-color: #868e96 ">${acc.accName } : ${acc.accDName}</td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black;">기간</th>
										<td>${acc.occrDate } ${acc.occrTime } ~ <br>${acc.endDate } ${acc.endTime } </td>
									</tr>
									<tr>
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black;" >돌발유형</th>
										<td>${acc.accDName}</td>
									</tr>
									<tr>
										<td colspan="2" style="background-color: #868e96; border: 1px solid black;">${acc.info }</td>
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
<!-- 	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>
 --><script>
    // Kakao 지도 API 스크립트를 동적으로 추가
    function loadKakaoMapScript(callback) {
        var script = document.createElement('script');
        script.onload = callback;
        script.src = "https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900&autoload=false";
        document.head.appendChild(script);
    }

    // Kakao 지도 API 스크립트가 로드되면 호출될 함수
    function initKakaoMap() {
        kakao.maps.load(function() {
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.564214, 127.001699),
                level: 7
            };
            var map = new kakao.maps.Map(container, options);

            // 교통 혼잡도 표시
            map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
            // 서버에서 전달된 사고 데이터
            var positions = [
                <c:forEach var="A01" items="${A01List}" varStatus="A01Status">
                    {
                        title: "${A01.info}",
                        latlng: new kakao.maps.LatLng("${A01.latitude}", "${A01.longitude}"),
                        imageSrc: "${CP}/resources/img/map/A01.png"//돌발정보
                    }<c:if test="${!A01Status.last}">,</c:if>
                </c:forEach>,
                <c:forEach var="A02" items="${A02List}" varStatus="A02Status">
                {
                    title: "${A02.info}",
                    latlng: new kakao.maps.LatLng("${A02.latitude}", "${A02.longitude}"),
                    imageSrc: "${CP}/resources/img/map/A02.png"//돌발정보
                }<c:if test="${!A02Status.last}">,</c:if>
                </c:forEach>,
                <c:forEach var="A04" items="${A04List}" varStatus="A04Status">
                {
                	title:  "${A04.info}",
                    latlng: new kakao.maps.LatLng("${A04.latitude}", "${A04.longitude}"),
                    imageSrc: "${CP}/resources/img/map/A04.png" //사고정보
                }<c:if test="${!A04Status.last}">,</c:if>
                </c:forEach>,
                <c:forEach var="A11" items="${A11List}" varStatus="A11Status">
                {
                    title: "${A11.info}",
                    latlng: new kakao.maps.LatLng("${A11.latitude}", "${A11.longitude}"),
                    imageSrc: "${CP}/resources/img/map/A11.png"//돌발정보
                }<c:if test="${!A11Status.last}">,</c:if>
            </c:forEach>
            ];
            
            // 마커 이미지의 이미지 주소입니다
             var imageSize = new kakao.maps.Size(24, 35);
            for (var i = 0; i < positions.length; i ++) {
            	var pos = positions[i];
                if (pos && pos.latlng && pos.imageSrc) { // Check if all necessary fields are defined
                    var markerImage = new kakao.maps.MarkerImage(pos.imageSrc, imageSize);

                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: pos.latlng,
                        title: pos.title,
                        image: markerImage
                    });
                } else {
                    console.warn('Position or imageSrc is undefined at index: ' + i);
                }
            }

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
        });
    }

    // 스크립트를 동적으로 로드하고 초기화 함수 호출
    loadKakaoMapScript(initKakaoMap);
</script>
</body>
</html>
	    