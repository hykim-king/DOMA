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
					<h2 style="font-wight : bold; text-align : center; border: 3px solid black">결빙정보</h2>
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
										<th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;" >년도</th>
                                        <td style="border: 1px solid black; text-align : center; width : 230px;">${freezingData.year}년</td>
									</tr>
									<tr>
                                        <th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;" >사고</th>
                                        <td style="border: 1px solid black; text-align : center; width : 230px;">${freezingData.accdient}건</td>
                                    </tr>
                                    <tr>
                                        <th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">사망</th>
                                        <td style="border: 1px solid black; text-align : center; width : 230px;">${freezingData.dead}건</td>
                                    </tr>
                                    <tr>
                                        <th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">중상</th>
                                        <td style="border: 1px solid black; text-align : center; width : 230px;">${freezingData.seriously}건</td>
                                    </tr>
                                    <tr>
                                        <th class="info_th" style="background-color: #FFDF00; border: 1px solid black; width : 100px;">경상</th>
                                        <td style="border: 1px solid black; text-align : center; width : 230px;">${freezingData.ordinary}건</td>
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
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>
<script>
    window.onload = function() {
        var container = document.getElementById('map');
        var options = {
        	center: new kakao.maps.LatLng(37.564214, 127.001699),
            level: 8
        };
        var map = new kakao.maps.Map(container, options);
        
        // 교통 혼잡도 표시
        map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
        


    
        
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
	    