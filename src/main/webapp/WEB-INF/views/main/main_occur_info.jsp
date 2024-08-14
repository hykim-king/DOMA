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
<script src="${CP}/resources/js/main/main_occur_info.js"></script>
<link rel="stylesheet" href="${CP}/resources/css/main/main_occur_info.css">
<style>
    select option {
        padding: 10px;
    }
    .selected-option {
        background-color: lightblue !important;
        color: black !important;
    }
    .risk-button {
        display: inline-block;
        width: 50px;
        height: 30px;
        margin: 5px;
        text-align: center;
        line-height: 30px;
        border: 1px solid #ccc;
        cursor: pointer;
        font-weight: bold;
    }
    .risk-button:hover {
        background-color: #e0e0e0;
    }
    .selected {
        background-color: #4caf50;
        color: white;
    }
    .gu-selection {
        text-align: center;
        margin-bottom: 20px;
        position: relative;
    }
    #guDropdown {
        display: none;
        width: 150px;
        height: 150px;
        font-weight: bold;
        text-align: center;
        border: 2px solid black;
    }
    #showGuList {
        cursor: pointer;
        width: 150px;
        height: 35px;
        font-weight: bold;
        text-align: center;
        border: 2px solid black;
        background-color: #f0f0f0;
        margin: 0 auto;
        line-height: 35px;
    }
    .risk-section {
        display: none;
        text-align: center;
        margin-bottom: 20px;
    }
</style>
<script>
let selectedRisk=[];
document.addEventListener("DOMContentLoaded", function () {

	 window.selectRisk = function(riskLevel) {
         const riskButton = document.getElementById(riskLevel.toString());

         if (riskButton.classList.contains('selected')) {
             riskButton.classList.remove('selected');
             // 배열에서 선택된 위험도 제거
             selectedRisk = selectedRisk.filter(level => level !== riskLevel);
         } else {
             riskButton.classList.add('selected');
             // 배열에 선택된 위험도 추가
             selectedRisk.push(riskLevel);
         }

         console.log('Selected Risk Levels:', selectedRisk);
     }
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

    // 기본적으로 사고 위험도 버튼들이 모두 선택된 상태로 설정
    const riskButtons = document.querySelectorAll('.risk-button');
    riskButtons.forEach(button => {
        button.classList.add('selected');
        selectedRisk.push(parseInt(button.id)); // 선택된 위험도를 배열에 추가
    });
    console.log('Initial Selected Risk Levels:', selectedRisk); // 초기 선택된 위험도 로그
 // 기본적으로 구 선택과 연도 선택 초기화
    document.getElementById('yearDropdown').value = ''; // 기본값 설정
    document.getElementById('guDropdown').selectedIndex = -1; // 기본값 설정
    document.querySelector('.risk-section').style.display = 'none'; // 기본적으로 숨김
});

let selectedGuList = [];
let isAllSelected = false; // 전체 선택 상태를 추적하는 변수

// 년도 선택 시 구 선택 드롭다운을 보이도록 설정
function selectYear(year) {
    if (year) {
        document.getElementById('guSelection').style.display = 'block';
        console.log('Selected year:', year);
    }
}

// 구 선택 시 선택된 구 리스트의 스타일을 변경하고, guList 배열을 업데이트
function updateGuSelection() {
    const guDropdown = document.getElementById('guDropdown');
    const options = Array.from(guDropdown.options);
    selectedGuList = []; // 선택된 구 리스트 초기화

    options.forEach(option => {
        if (option.selected) {
            if (!option.classList.contains('selected-option')) {
                option.classList.add('selected-option');
            }
            selectedGuList.push(option.value);
        } else {
            if (option.classList.contains('selected-option')) {
                option.classList.remove('selected-option');
            }
        }
    });

    console.log('Selected Gu List:', selectedGuList);

    // 구 선택 시 사고 위험도 섹션 보이기
    if (selectedGuList.length > 0) {
        document.querySelector('.risk-section').style.display = 'block';
    } else {
        document.querySelector('.risk-section').style.display = 'none';
    }
}

//전체 선택 또는 전체 취소
function toggleGuDropdown() {
    const guDropdown = document.getElementById('guDropdown');
    const showGuListButton = document.getElementById('showGuList');
    
    if (guDropdown.style.display === 'none') {
        guDropdown.style.display = 'block';
        selectAllGu(); // 드롭다운이 보일 때 전체 선택
        showGuListButton.innerText = '전체 취소'; // 버튼 텍스트 변경
    } else {
        guDropdown.style.display = 'none';
        showGuListButton.innerText = '전체 선택'; // 버튼 텍스트 변경
        deselectAllGu(); // 드롭다운이 숨겨질 때 전체 취소
    }

    // 전체 선택 후 사고 위험도 섹션 보이기
    if (selectedGuList.length > 0) {
        document.querySelector('.risk-section').style.display = 'block';
    } else {
        document.querySelector('.risk-section').style.display = 'none';
    }
}

function selectAllGu() {
    const guDropdown = document.getElementById('guDropdown');
    const options = Array.from(guDropdown.options);

    options.forEach(option => {
        if (option.value !== '전체선택') {
            option.selected = true;
            if (!option.classList.contains('selected-option')) {
                option.classList.add('selected-option');
                selectedGuList.push(option.value);
            }
        }
    });

    isAllSelected = true; // 전체 선택 상태로 변경
    console.log('Selected Gu List:', selectedGuList);

    

    console.log('Selected Risk Levels:', selectedRisk);
}

//전체 취소
function deselectAllGu() {
    const guDropdown = document.getElementById('guDropdown');
    const options = Array.from(guDropdown.options);

    options.forEach(option => {
        option.selected = false;
        if (option.classList.contains('selected-option')) {
            option.classList.remove('selected-option');
        }
    });

    selectedGuList = []; // 선택된 구 리스트 초기화
    isAllSelected = false; // 전체 선택 상태로 변경
    console.log('Selected Gu List:', selectedGuList);
}
// 조회 버튼 클릭 시 데이터 로드
function fetchData() {
	let localRiskLevels = [...selectedRisk];
    const selectedYear = document.getElementById('yearDropdown').value;
    const guDropdown = document.getElementById('guDropdown');
    const selectedGu = Array.from(guDropdown.selectedOptions).map(option => option.value);
    console.log('Selected Year:', selectedYear);
    console.log('Selected Gu List:', selectedGu);
    console.log('Selected Risk Levels:', localRiskLevels);
    if (selectedYear && selectedGu.length > 0 && localRiskLevels.length > 0) { // selectedRisk가 있는지 확인
        loadYearGuMarkers(selectedYear, selectedGu, localRiskLevels);
    } else {
        console.warn('Please select a year, at least one Gu, and a risk level.');
    }
}

// 기존의 모든 마커를 제거하는 함수 (선택 사항)
let markers = [];
function removeExistingMarkers() {
    markers.forEach(marker => marker.setMap(null));
    markers = [];
}

// 응답 데이터로 마커를 지도에 추가하는 함수
function addMarkersToMap(data) {
    data.forEach(item => {
        let imageSrc = "";
        let imageSize = new kakao.maps.Size(24, 32); // 기본 크기

        // accFrequency 값에 따른 이미지 경로 및 크기 설정
        switch (item.accFrequency) {
            case 1:
                imageSrc = "/doma/resources/img/map/location_green.png";
                break;
            case 2:
                imageSrc = "/doma/resources/img/map/location_blue.png";
                break;
            case 3:
                imageSrc = "/doma/resources/img/map/location_orange.png";
                break;
            case 4:
                imageSrc = "/doma/resources/img/map/location_red.png";
                break;
            case 5:
                imageSrc = "/doma/resources/img/map/location_purple.png";
                break;
        }

        const imageOption = { offset: new kakao.maps.Point(12, 35) };
        const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        const marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(item.latitude, item.longitude),
            image: markerImage
        });

        const infowindow = new kakao.maps.InfoWindow({
            content: '<div style="padding:5px;"><br>사고: ' + item.accident + 
                     '<br>중상: ' + item.seriously + 
                     '<br>경상: ' + item.ordinary + '</div>'
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


</script>
<title>DOMA</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <div style="display: flex">
        <jsp:include page="/WEB-INF/views/main/main_sidebar.jsp"></jsp:include>
        <div id="subMap" style="height: 815px; display: inline-block;">
            <section id="mapContainer">

                <!-- 기본적으로 "년도 선택" 드롭다운 -->
                <div class="year-selection" style="text-align: center; margin-bottom: 20px;">
                    <h3>년도 선택</h3>
                    <select id="yearDropdown" onchange="selectYear(this.value)" style="width: 150px; height: 35px; font-weight: bold; text-align: center; border: 2px solid black;">
                        <option value="" disabled selected>년도 선택</option>
                        <option value="2018">2018</option>
                        <option value="2019">2019</option>
                        <option value="2020">2020</option>
                        <option value="2021">2021</option>
                        <option value="2022">2022</option>
                    </select>
                </div>

                <!-- 전체 선택 버튼 및 구 선택 드롭다운 -->
                <div class="gu-selection" id="guSelection" style="display: none;">
                    <h3>구 선택</h3>
                    <div id="showGuList" onclick="toggleGuDropdown()">전체 선택</div>
                    <select id="guDropdown" multiple="multiple" onchange="updateGuSelection()">
                        <option value="강남구">강남구</option>
                        <option value="강동구">강동구</option>
                        <option value="강북구">강북구</option>
                        <option value="강서구">강서구</option>
                        <option value="관악구">관악구</option>
                        <option value="광진구">광진구</option>
                        <option value="구로구">구로구</option>
                        <option value="금천구">금천구</option>
                        <option value="노원구">노원구</option>
                        <option value="도봉구">도봉구</option>
                        <option value="동대문구">동대문구</option>
                        <option value="동작구">동작구</option>
                        <option value="마포구">마포구</option>
                        <option value="서대문구">서대문구</option>
                        <option value="서초구">서초구</option>
                        <option value="성동구">성동구</option>
                        <option value="성북구">성북구</option>
                        <option value="송파구">송파구</option>
                        <option value="양천구">양천구</option>
                        <option value="영등포구">영등포구</option>
                        <option value="용산구">용산구</option>
                        <option value="은평구">은평구</option>
                        <option value="종로구">종로구</option>
                        <option value="중구">중구</option>
                        <option value="중랑구">중랑구</option>
                    </select>
                </div>

                <!-- 사고 위험도 버튼 -->
                <div class="risk-section">
                    <h3>사고 위험도 선택</h3>
                    <div id="riskButtons">
                        <div id="1" class="risk-button" onclick="selectRisk(1)">1</div>
                        <div id="2" class="risk-button" onclick="selectRisk(2)">2</div>
                        <div id="3" class="risk-button" onclick="selectRisk(3)">3</div>
                        <div id="4" class="risk-button" onclick="selectRisk(4)">4</div>
                        <div id="5" class="risk-button" onclick="selectRisk(5)">5</div>
                    </div>
                </div>
                    
                <!-- 조회 버튼 -->
                <div style="text-align: center; margin-bottom: 20px;">
                    <button onclick="fetchData()" style="width: 150px; height: 35px; font-weight: bold; text-align: center; border: 2px solid black;">조회</button>
                </div>

                <!-- 조회 결과 표시 영역 -->
                <div class="aside" id="resultContainer" style="height: 820px; width: 350px; overflow: scroll; display: none;">
                    <!-- 서버로부터 받아온 데이터가 이곳에 삽입됩니다 -->
                </div>

            </section>
        </div>
        <jsp:include page="/WEB-INF/views/main/main_point_detail.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/views/main/main_emergency_map.jsp"></jsp:include>
    </div>

    <!-- 스크립트 -->
>
    <script src="${CP}/resources/js/main/main_occur_detail.js"></script>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=697612f7482b0b832f526a2e125de900"></script>

    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
   
</body>
</html>
