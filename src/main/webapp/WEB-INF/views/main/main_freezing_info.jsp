<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
   <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900&autoload=false"></script>
<script>
var map;
var infowindow;
var customOverlay;
var polygons = {}; // 각 년도별 폴리곤 저장 객체
//색상 배열 정의
var colorPalette = [
	'#BF2D2D', // 어두운 빨강
    '#2D4CBF', // 어두운 파랑
    '#2DBF2D', // 어두운 초록
    '#BF6D2D', // 어두운 주황
    '#6D2DBF', // 어두운 보라
    '#2D6DBF'  // 어두운 청록
];
var polygonColors = {}; 
var currentInfoWindow; // 현재 열린 인포윈도우 추적 변수

document.addEventListener("DOMContentLoaded", function () {
    kakao.maps.load(function () {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.564214, 127.001699),
            level: 6
        };
        map = new kakao.maps.Map(container, options);

        var mapTypeControl = new kakao.maps.MapTypeControl();
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

        infowindow = new kakao.maps.InfoWindow({
            removable: false,
            zIndex: 1,
        });

        customOverlay = new kakao.maps.CustomOverlay({
            zIndex: 2,
            clickable: false,
            removable: false
        });

        if (document.getElementById('showAllCheckbox').checked) {
            loadAllPolygons();
        }

        document.getElementById('showAllCheckbox').addEventListener('change', function () {
            if (this.checked) {
                loadAllPolygons();
            } else {
                removeAllPolygons();
            }
        });
    });
});

function loadAllPolygons() {
    $.ajax({
        url: "/doma/freezing/allYearsSelect.do",
        type: 'GET',
        dataType: "json",
        success: function (response) {
            response.forEach(function (freezing) {
                if (freezing.polygon) {
                    var polygonData = JSON.parse(freezing.polygon);

                    if (polygonData.type !== 'Polygon' || !polygonData.coordinates) {
                        console.error("Invalid polygon data format:", polygonData);
                        return;
                    }

                    var coordinates = polygonData.coordinates[0];
                    var polygonPath = coordinates.map(function (coord) {
                        return new kakao.maps.LatLng(coord[1], coord[0]);
                    });

                    // 특정 년도에 따라 색상 설정
                    var color = getPolygonColor(freezing.year);

                    var polygon = new kakao.maps.Polygon({
                        path: polygonPath,
                        strokeWeight: 3,
                        strokeColor: color,
                        strokeOpacity: 0.8,
                        strokeStyle: 'longdash',
                        fillColor: color,
                        fillOpacity: 0.4
                    });

                    polygon.setMap(map);
                    polygons[freezing.year] = polygons[freezing.year] || [];
                    polygons[freezing.year].push(polygon);

                    kakao.maps.event.addListener(polygon, 'mouseover', function (mouseEvent) {
                        var position = mouseEvent.latLng;
                        var offset = new kakao.maps.LatLng(position.getLat() + 0.003, position.getLng());
                        var content = '<div class="info" style="background-color: #ffffff; padding: 15px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2); width: 220px; font-family: Arial, sans-serif;">' +
                        '<div class="title" style="font-weight: bold; font-size: 16px; color: #333; margin-bottom: 10px; text-align: center;">' + freezing.gname + '</div>' +
                        '<div class="details" style="font-size: 14px; color: #555;">' +
                        '<div style="margin-bottom: 8px;"><b>동:</b> ' + freezing.dname + '</div>' +
                        '<div style="margin-bottom: 8px;"><b>년도:</b> ' + freezing.year + '</div>' +
                        '<div style="margin-bottom: 8px;"><b>사고 건수:</b> ' + freezing.accident + '</div>' +
                        '<div style="margin-bottom: 8px;"><b>사상자 수:</b> ' + freezing.casualties + '</div>' +
                        '<div style="margin-bottom: 8px;"><b>사망자 수:</b> ' + freezing.dead + '</div>' +
                        '<div style="margin-bottom: 8px;"><b>중상자 수:</b> ' + freezing.seriously + '</div>' +
                        '<div><b>경상자 수:</b> ' + freezing.ordinary + '</div>' +
                        '</div>';
                        infowindow.setPosition(offset);
                        infowindow.setContent(content);
                        infowindow.open(map);
                    });

                    kakao.maps.event.addListener(polygon, 'mousemove', function (mouseEvent) {
                        customOverlay.setPosition(mouseEvent.latLng);
                    });
                    kakao.maps.event.addListener(polygon, 'mouseout', function () {
                        infowindow.close();
                        customOverlay.setMap(null);
                    });
                }
            });
        },
        error: function (error) {
            console.error("Error loading all polygons:", error);
        }
    });
}


function removeAllPolygons() {
    if (polygons) {
        Object.keys(polygons).forEach(function (year) {
            if (polygons[year]) {
                polygons[year].forEach(function (polygon) {
                    polygon.setMap(null);
                });
            }
        });
        polygons = {};
    }
}

function polyData(year) {
    if (document.getElementById('showAllCheckbox').checked) {
        alert("해당 년도를 보기 전, 전체보기를 해제해주세요.");
        return;
    }

    if (polygons[year] && polygons[year].length > 0) {
        polygons[year].forEach(function (polygon) {
            polygon.setMap(null);
        });
        polygons[year] = [];
    } else {
        $.ajax({
            url: "/doma/freezing/yearSelect.do",
            type: 'GET',
            data: { year: year },
            dataType: "json",
            success: function (response) {
                response.forEach(function (freezing) {
                    if (freezing.polygon) {
                        try {
                            var polygonData = JSON.parse(freezing.polygon);

                            if (polygonData.type !== 'Polygon' || !polygonData.coordinates) {
                                console.error("Invalid polygon data format:", polygonData);
                                return;
                            }

                            var coordinates = polygonData.coordinates[0];
                            var polygonPath = coordinates.map(function (coord) {
                                if (Array.isArray(coord) && coord.length === 2) {
                                    return new kakao.maps.LatLng(coord[1], coord[0]);
                                } else {
                                    console.error("Invalid coordinate format:", coord);
                                    return null;
                                }
                            }).filter(function (latLng) { return latLng !== null; });

                            var color = getPolygonColor(year); // 특정 년도에 맞는 색상 가져오기

                            var polygon = new kakao.maps.Polygon({
                                path: polygonPath,
                                strokeWeight: 3,
                                strokeColor: color,
                                strokeOpacity: 0.8,
                                strokeStyle: 'longdash',
                                fillColor: color,
                                fillOpacity: 0.7
                            });

                            polygon.setMap(map);
                            polygons[year] = polygons[year] || [];
                            polygons[year].push(polygon);

                            kakao.maps.event.addListener(polygon, 'mouseover', function (mouseEvent) {
                                var position = mouseEvent.latLng;
                                var offset = new kakao.maps.LatLng(position.getLat() + 0.003, position.getLng());
                                var content = '<div class="info" style="background-color: #ffffff; padding: 15px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2); width: 220px; font-family: Arial, sans-serif;">' +
                                '<div class="title" style="font-weight: bold; font-size: 16px; color: #333; margin-bottom: 10px; text-align: center;">' + freezing.gname + '</div>' +
                                '<div class="details" style="font-size: 14px; color: #555;">' +
                                '<div style="margin-bottom: 8px;"><b>동:</b> ' + freezing.dname + '</div>' +
                                '<div style="margin-bottom: 8px;"><b>년도:</b> ' + freezing.year + '</div>' +
                                '<div style="margin-bottom: 8px;"><b>사고 건수:</b> ' + freezing.accident + '</div>' +
                                '<div style="margin-bottom: 8px;"><b>사상자 수:</b> ' + freezing.casualties + '</div>' +
                                '<div style="margin-bottom: 8px;"><b>사망자 수:</b> ' + freezing.dead + '</div>' +
                                '<div style="margin-bottom: 8px;"><b>중상자 수:</b> ' + freezing.seriously + '</div>' +
                                '<div><b>경상자 수:</b> ' + freezing.ordinary + '</div>' +
                                '</div>';
                                infowindow.setPosition(offset);
                                infowindow.setContent(content);
                                infowindow.open(map);
                            });

                            kakao.maps.event.addListener(polygon, 'mousemove', function (mouseEvent) {
                                customOverlay.setPosition(mouseEvent.latLng);
                            });
                            kakao.maps.event.addListener(polygon, 'mouseout', function () {
                                infowindow.close();
                                customOverlay.setMap(null);
                            });

                        } catch (e) {
                            console.error("Error parsing polygon data:", e);
                        }
                    } else {
                        console.error("No polygon data available for freezing:", freezing);
                    }
                });
            },
            error: function (error) {
                console.error("Error:", error);
            }
        });
    }
}




// 특정 년도에 대해 색상 선택
function getPolygonColor(year) {
    if (!polygonColors[year]) {
        // 색상 팔레트에서 색상 선택
        var colorIndex = Object.keys(polygonColors).length % colorPalette.length;
        polygonColors[year] = colorPalette[colorIndex];
    }
    return polygonColors[year];
}

</script>
</head>
<body>
     <div id="container" style="display : flex">
    <jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
    <div id="subMap" style="height: 815px;">
        <section id="mapContainer">
            <div class="aside" style="height:800px; width: 350px; overflow : scroll">
                    <h2 style="font-weight: bold; text-align: center; border: 3px solid black;">결빙정보</h2>
                    <div>
                        <label>
                            <input type="checkbox" id="showAllCheckbox" checked>
                            전체 보기
                        </label>
                    </div>
                    <!-- 테이블 추가 -->
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>년도</th>
                                    <th>발생 건수</th>
                                    <th>사상자 수</th>
                                    <th>사망자 수</th>
                                    <th>중상자 수</th>
                                    <th>경상자 수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="freezing" items="${allData}">
                                    <tr>
                                        <td>
                                            <button type="button" onclick="polyData('${freezing.year}')">
                                                ${freezing.year}
                                                <span style="background-color: ${polygonColors[freezing.year] || '#FFFFFF'}; color: #FFF; padding: 0 4px;"></span>
                                            </button>
                                        </td>
                                        <td>${freezing.accident}건</td>
                                        <td>${freezing.casualties}명</td>
                                        <td>${freezing.dead}명</td>
                                        <td>${freezing.seriously}명</td>
                                        <td>${freezing.ordinary}명</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </div>            
        <jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>
