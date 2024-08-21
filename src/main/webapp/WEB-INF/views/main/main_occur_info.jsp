<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>
<script src="${CP}/resources/js/main/main_occur_info.js"></script>
<script>
let selectedRisk = []; // 초기에는 빈 배열로 설정합니다.

document.addEventListener("DOMContentLoaded", function () {
    // Initialize map
    const container = document.getElementById('map');
    const options = {
        center: new kakao.maps.LatLng(37.564214, 127.001699),
        level: 8
    };
    map = new kakao.maps.Map(container, options);
    const mapTypeControl = new kakao.maps.MapTypeControl();
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
    const zoomControl = new kakao.maps.ZoomControl();
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

    // Set default year
    document.getElementById('yearDropdown').value = '2022';

    // Set default risk buttons and fetch initial markers
    initializeRiskButtons();
});

function initializeRiskButtons() {
    // Get all risk buttons
    const riskButtons = document.querySelectorAll('.risk-button');

    // Set all buttons as selected and initialize selectedRisk array
    riskButtons.forEach(button => {
        button.classList.add('selected');
        selectedRisk.push(parseInt(button.id));
    });

    // Ensure risk section is visible
    document.querySelector('.risk-section').style.display = 'block'; // 위험도 버튼이 포함된 섹션을 표시합니다.

    // Fetch markers for the default year with all risk levels
    fetchMarkersForYear(document.getElementById('yearDropdown').value);
}

// Function to handle button click and update selectedRisk
function selectRisk(riskLevel) {
    const riskButton = document.getElementById(riskLevel.toString());

    if (riskButton.classList.contains('selected')) {
        // Button is selected, remove it from the selectedRisk array
        riskButton.classList.remove('selected');
        selectedRisk = selectedRisk.filter(level => level !== riskLevel);
    } else {
        // Button is not selected, add it to the selectedRisk array
        riskButton.classList.add('selected');
        selectedRisk = [...new Set([...selectedRisk, riskLevel])]; // Avoid duplicates
    }

    if (selectedRisk.length === 0) {
        alert("최소 1개의 위험도를 선택해야 합니다.");
        // Add the button back if no risk level is selected
        riskButton.classList.add('selected');
        selectedRisk.push(riskLevel);
    }

    console.log('Selected Risk Levels:', selectedRisk);

    // Fetch data based on updated risk levels
    fetchMarkersForYear(document.getElementById('yearDropdown').value);
}

function selectYear(year) {
    if (year) {
        fetchMarkersForYear(year); // Fetch markers for selected year
    }
}

function fetchMarkersForYear(year) {
    let localRiskLevels = [...new Set(selectedRisk)]; // Remove duplicates
    console.log('Selected Year:', year);
    console.log('Selected Risk Levels:', localRiskLevels);
    removeExistingMarkers();
    if (year && localRiskLevels.length > 0) {
        loadYearGuMarkers(year, localRiskLevels);
    } else {
        // Avoid alert on initial load
        if (year && localRiskLevels.length === 0) {
            alert("위험도를 선택해주세요.");
        }
    }
}


// Function to add markers to the map
function addMarkersToMap(data) {
    data.forEach(item => {
        let imageSrc = "";
        switch (item.accFrequency) {
            case 1:
                imageSrc = "/doma/resources/img/map/icon_green.png";
                break;
            case 2:
                imageSrc = "/doma/resources/img/map/icon_blue.png";
                break;
            case 3:
                imageSrc = "/doma/resources/img/map/icon_yellow.png";
                break;
            case 4:
                imageSrc = "/doma/resources/img/map/icon_red.png";
                break;
            case 5:
                imageSrc = "/doma/resources/img/map/icon_purple.png";
                break;
        }

        const imageOption = { offset: new kakao.maps.Point(15, 35) };
        const markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 32), imageOption);

        const marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(item.latitude, item.longitude),
            image: markerImage
        });

        // Debugging: Verify infowindow content
        const content = '<div class="info" style="background-color: #ffffff; padding: 15px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); width: 240px; font-family: Arial, sans-serif; font-size: 14px;">' +
    '<div class="title" style="font-weight: bold; font-size: 16px; color: #333; margin-bottom: 12px; text-align: center;">' + item.gname + '</div>' +
    '<div class="details" style="color: #555;">' +
    '<div style="margin-bottom: 8px;"><b>사고 건수:</b> ' + item.accident + '</div>' +
    '<div style="margin-bottom: 8px;"><b>사망자 수:</b> ' + item.dead + '</div>' +
    '<div style="margin-bottom: 8px;"><b>중상자 수:</b> ' + item.seriously + '</div>' +
    '<div style="margin-bottom: 8px;"><b>경상자 수:</b> ' + item.ordinary + '</div>' +
    '<div style="font-size: 12px; color: #777;"><b>법규 위반:</b> ' + item.pointType + '</div>' +
    '</div>' +
    '</div>';

        const infowindow = new kakao.maps.InfoWindow({
            content: content
        });

        kakao.maps.event.addListener(marker, 'mouseover', function() {
            infowindow.open(map, marker);
        });

        kakao.maps.event.addListener(marker, 'mouseout', function() {
            infowindow.close();
        });

        marker.setMap(map);
        markers.push(marker);
    });
}

// Function to remove existing markers
let markers = [];
function removeExistingMarkers() {
    markers.forEach(marker => marker.setMap(null));
    markers = [];
}

</script>
<title>DOMA</title>
</head>
<div id="container" style="display : flex">
    <jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
    <div id="subMap" style="height: 815px;">
        <section id="mapContainer">
            <div class="aside" style="height:800px; width: 200px; overflow : scroll">
                <!-- 기본적으로 "년도 선택" 드롭다운 -->
                <div class="year-selection" style="text-align: center; margin-bottom: 20px;">
                    <select id="yearDropdown" onchange="selectYear(this.value)" style="width: 150px; height: 35px; font-weight: bold; text-align: center; border: 2px solid black;">
                        <option value="" disabled selected>년도 선택</option>
                        <option value="2018">2018</option>
                        <option value="2019">2019</option>
                        <option value="2020">2020</option>
                        <option value="2021">2021</option>
                        <option value="2022">2022</option>
                    </select>
                </div>

                <!-- 사고 위험도 버튼 -->
				<div class="risk-section">
				    <h4>사고 위험도</h4>
				    <div id="riskButtons">
				       <div id="1" class="risk-button risk-green" onclick="selectRisk(1)">1</div>
                        <div id="2" class="risk-button risk-blue" onclick="selectRisk(2)">2</div>
                        <div id="3" class="risk-button risk-yellow" onclick="selectRisk(3)">3</div>
                        <div id="4" class="risk-button risk-red" onclick="selectRisk(4)">4</div>
                        <div id="5" class="risk-button risk-purple" onclick="selectRisk(5)">5</div>
				    </div>
				</div>
			</div>
		</section>
    </div>            
            <jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
    </div>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
</body>
</html>
