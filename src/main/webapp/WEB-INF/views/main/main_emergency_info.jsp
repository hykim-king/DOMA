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
    <div id="subMap" style="width:909px; height : 815px;">
        <section id="mapContainer">
            <div class="aside" style="height:1000px; width: 350px; overflow : scroll">
                <h2 style="font-weight : bold; text-align : center; border: 3px solid black">돌발정보</h2>
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
                                    <td colspan="2" style="font-weight: bold; text-align: center; border: 1px solid black; background-color: #868e96"
                                        onclick="fetchAccidentInfo('${acc.accId}', ${acc.latitude}, ${acc.longitude})">${acc.accName} : ${acc.accDName}</td>
                                </tr>
                                <tr>
                                    <th class="info_th" style="background-color: #FFDF00; border: 1px solid black;">기간</th>
                                    <td>${acc.occrDate} ${acc.occrTime} ~ <br>${acc.endDate} ${acc.endTime}</td>
                                </tr>
                                <tr>
                                    <th class="info_th" style="background-color: #FFDF00; border: 1px solid black;">돌발유형</th>
                                    <td>${acc.accDName}</td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="background-color: #868e96; border: 1px solid black;">${acc.info}</td>
                                </tr>
                            </tbody>
                        </table>
                    </li>
                </ul>
                </c:forEach>
            </div>
        </section>
    </div>
    <div id="accidentInfo" style="margin-left: 20px;">
            <!-- 사고 정보가 여기에 동적으로 표시됩니다 -->
    </div>
    <jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
</div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
<!-- 	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>
 --><script>
 var map;
 var marker;

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
             level: 7
         };
         map = new kakao.maps.Map(container, options);

         // 마커 초기화
         marker = new kakao.maps.Marker({
             map: map,
             position: options.center
         });

         // 지도에 추가할 컨트롤들 초기화
         var mapTypeControl = new kakao.maps.MapTypeControl();
         map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

         var zoomControl = new kakao.maps.ZoomControl();
         map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
     });
 }

 loadKakaoMapScript(initKakaoMap);

 function fetchAccidentInfo(accId, lat, lng) {
     // 지도 객체가 정상적으로 초기화되었는지 확인
     if (!map) {
         console.error('Error: Kakao map is not initialized.');
         return;
     }

     $.ajax({
         url: `${CP}/accIdSelect.do`,
         type: 'GET',
         data: { accId: accId },
         success: function(data) {
             // 사고 정보 표시
             $('#accidentInfo').html(data);

             // 지도 및 마커 위치 이동
             var moveLatLon = new kakao.maps.LatLng(lat, lng);
             map.setCenter(moveLatLon);
             marker.setPosition(moveLatLon);
         },
         error: function(xhr, status, error) {
             console.error('Error:', error);
         }
     });
 }

</script>
</body>
</html>
	    