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
var buttonColors = {}; // 버튼 색상 상태를 저장할 객체
var colorPalette = {
    '2018': 'rgba(114, 53, 255, 1)', // 연한 어두운 빨강
    '2019': 'rgba(28, 75, 255, 1)', // 연한 어두운 파랑
    '2020': 'rgba(0, 195, 53, 1)', // 연한 어두운 초록
    '2021': 'rgba(255, 229, 0, 1)', // 연한 어두운 주황
    '2022': 'rgba(255, 166, 27, 1)', // 연한 어두운 보라
    '2023': 'rgba(255, 27, 27, 1)'  // 연한 어두운 청록
};

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

        // 전체 선택 체크박스 초기화
        document.getElementById('showAllCheckbox').checked = true;
        loadAllPolygons();
        setButtonColors(); // 전체 보기 체크시 버튼 색상 재설정

        // 체크박스 이벤트 핸들러
        document.getElementById('showAllCheckbox').addEventListener('change', function () {
            if (this.checked) {
                loadAllPolygons();
                setButtonColors(); // 전체 보기 체크시 버튼 색상 재설정
            } else {
                removeAllPolygons();
                resetButtonColors(); // 전체 보기를 해제할 때 버튼 색상 초기화
            }
        });
     // 버튼 상태 초기화 (옵션: 모든 버튼의 상태를 기본값으로 설정)
        document.querySelectorAll('.year-button').forEach(function(button) {
            var year = button.id.split('-')[1];
            buttonStates[year] = false; // 모든 버튼의 상태를 비활성화로 초기화
        });
        setButtonColors(); // 전체 보기 체크시 버튼 색상 재설정
    });
});
function setButtonColors() {
    document.querySelectorAll('.year-button').forEach(function(button) {
        var year = button.id.split('-')[1];
        button.style.backgroundColor = getPolygonColor(year);
        button.style.color = '#FFFFFF'; // 글자색 흰색으로 설정
    });
}

function resetButtonColors() {
    document.querySelectorAll('.year-button').forEach(function(button) {
        var year = button.id.split('-')[1];
        button.style.backgroundColor = ''; // 기본 색상으로 초기화
        button.style.color = ''; // 기본 글자색으로 초기화
    });
}

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
    Object.keys(polygons).forEach(function (year) {
        if (polygons[year]) {
            polygons[year].forEach(function (polygon) {
                polygon.setMap(null);
            });
            polygons[year] = [];
        }
    });
}
var buttonStates = {}; // 버튼의 선택 상태를 저장하는 객체
function handleYearButtonClick(year) {
	console.log('Button clicked for year:', year); // 버튼 클릭 확인 로그
    var button = document.getElementById('btn-' + year);
    var span = button.querySelector('.color-indicator');
    if (document.getElementById('showAllCheckbox').checked) {
        alert("해당 년도를 보기 전, 전체보기를 해제해주세요.");
        return;
    }
    console.log('Button states:', buttonStates); // 버튼 상태 확인 로그
    if (buttonStates[year]) {
        // 버튼이 선택된 상태라면 폴리곤 제거 및 색상 초기화
        removeYearPolygons(year);
        button.style.backgroundColor = ''; // 버튼 색상 초기화
        button.style.color = ''; // 버튼 글자 색상 초기화
        span.style.backgroundColor = ''; // span 색상 초기화
        buttonStates[year] = false; // 상태를 해제
    } else {
        // 버튼이 선택되지 않은 상태라면 폴리곤 로드 및 색상 변경
        loadYearPolygons(year);
        var color = getPolygonColor(year);
        button.style.backgroundColor = color; // 버튼 색상 변경
        button.style.color = '#FFFFFF'; // 버튼 글자 색상 설정
        span.style.backgroundColor = color; // span 색상 변경
        buttonStates[year] = true; // 상태를 활성화
    }
}
function loadYearPolygons(year) {
	console.log('Loading polygons for year:', year); // 로드 시작 로그
    $.ajax({
        url: "/doma/freezing/yearSelect.do",
        type: 'GET',
        data: { year: year },
        dataType: "json",
        success: function (response) {
            if (response.length > 0) {
                // 현재 폴리곤을 제거하고 새로 로드
                removeYearPolygons(year);
                response.forEach(function (freezing) {
                    try {
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
                    } catch (e) {
                        console.error("Error parsing polygon data:", e);
                    }
                });
            } else {
                console.error("No polygon data available for freezing:", freezing);
            }
        },
        error: function (error) {
            console.error("Error:", error);
        }
    });
}

function removeYearPolygons(year) {
    if (polygons[year]) {
        polygons[year].forEach(function (polygon) {
            polygon.setMap(null);
        });
        polygons[year] = [];
    }
}

function getPolygonColor(year) {
    return colorPalette[year] || '#FFFFFF'; // 기본 색상은 흰색
}

</script>
</head>
<body>
     <div id="container" style="display : flex">
    <jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
    <div id="subMap" style="height: 815px;">
        <section id="mapContainer">
            <div class="aside" style="height:800px; width: 500px; overflow : scroll">
                    <h2>결빙정보</h2>
                    <div style="margin: 10px;">
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
										    <button type="button" class="year-button" id="btn-${freezing.year}" onclick="handleYearButtonClick('${freezing.year}')">
										        ${freezing.year}
										        <span class="color-indicator" style="background-color: ${buttonColors[freezing.year] || '#FFFFFF'}; color: #FFF;"></span>
										    </button>
										</td>
                                        <td  style="text-align: center;">${freezing.accident}건</td>
                                        <td  style="text-align: center;">${freezing.casualties}명</td>
                                        <td  style="text-align: center;">${freezing.dead}명</td>
                                        <td  style="text-align: center;">${freezing.seriously}명</td>
                                        <td style="text-align: center;">${freezing.ordinary}명</td>
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
