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
    <link rel="stylesheet" href="${CP}/resources/css/main/main_emergency_info.css">
    <script src="${CP}/resources/js/jquery_3_7_1.js"></script>
    <script src="${CP}/resources/js/common.js"></script>    
    <style>
        #map { width: 100%; height: 800px; }
        .area { background: #fff; padding: 5px; border: 1px solid #333; }
        .info { background: #fff; padding: 5px; border: 1px solid #333; }
        .details div { margin-bottom: 5px; }
        .table-container { margin-top: 20px; }
    </style>
   <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900&autoload=false"></script>
<script>
var map;
var infowindow;
var customOverlay;
var polygons = {}; // 각 년도별 폴리곤 저장 객체
var polygonColors = {}; // 년도별 색상 객체
document.addEventListener("DOMContentLoaded", function () {
    kakao.maps.load(function () {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.564214, 127.001699),
            level: 8
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

                    var color = polygonColors[freezing.year] || getRandomColor();
                    polygonColors[freezing.year] = color;

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

                        infowindow.setPosition(offset);
                        infowindow.setContent('<div style="background: black; color: white; padding: 10px; border-radius: 5px;">' + freezing.accPoint + '</div>');
                        infowindow.open(map);
                    });

                    kakao.maps.event.addListener(polygon, 'mousemove', function (mouseEvent) {
                        customOverlay.setPosition(mouseEvent.latLng);
                    });

                    kakao.maps.event.addListener(polygon, 'mouseout', function () {
                        infowindow.close();
                        customOverlay.setMap(null);
                    });

                    kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) {
                    	infowindow.close(); // Click 시 infowindow 닫기
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

                            var color = polygonColors[year] || getRandomColor();
                            polygonColors[year] = color;

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

                                infowindow.setPosition(offset);
                                infowindow.setContent('<div style="background: black; color: white; padding: 10px; border-radius: 5px;">' + freezing.accPoint + '</div>');
                                infowindow.open(map);
                            });

                            kakao.maps.event.addListener(polygon, 'mousemove', function (mouseEvent) {
                                customOverlay.setPosition(mouseEvent.latLng);
                            });

                            kakao.maps.event.addListener(polygon, 'mouseout', function () {
                                infowindow.close();
                                customOverlay.setMap(null);
                            });

                            kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) {
                                onPolygonClick(freezing.fid, mouseEvent);
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
function onPolygonClick(fid, mouseEvent) {
    $.ajax({
        url: "/doma/freezing/idSelect.do",
        type: 'GET',
        data: { fid: fid },
        dataType: "json",
        success: function(response) {
            console.log(response);
            var content = '<div class="info" style="background-color: white; padding: 10px; border-radius: 5px;">' +
            '   <div class="title" style="font-weight: bold; font-size: 14px; color: #333;">' + response.gname + '</div>' +
            '   <div class="details" style="margin-top: 5px; font-size: 12px; color: #555;">' +
            '       <div><b>동:</b> ' + response.dname + '</div>' +
            '       <div><b>년도:</b> ' + response.year + '</div>' +
            '       <div><b>사고 건수:</b> ' + response.accident + '</div>' +
            '       <div><b>사상자 수:</b> ' + response.casualties + '</div>' +
            '       <div><b>사망자 수:</b> ' + response.dead + '</div>' +
            '       <div><b>중상자 수:</b> ' + response.seriously + '</div>' +
            '       <div><b>경상자 수:</b> ' + response.ordinary + '</div>' +
            '   </div>' +
            '</div>';

            infowindow.setContent(content);
            infowindow.setPosition(mouseEvent.latLng);
            infowindow.open(map);
            kakao.maps.event.addListener(map, 'click', function () {
                infowindow.close();
            });
        },
        error: function(error) {
            console.error("Error fetching freezing data:", error);
        }
    });
}
function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}
</script>
</head>
<body>
    <div style="display: flex;">
        <jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
        <div id="subMap" style="height: 815px;">
            <section id="mapContainer">
                <div class="aside" style="height:800px; width: 350px; overflow: scroll;">
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
        <div id="map"></div> <!-- 지도 표시 영역 -->
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>
