<%--
/**
    Class Name:
    Description:
    Author : user
    Modification information
    
    수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 8. 20        최초작성 
    
    DOMA 개발팀
    since 2024.07.18
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DOMA</title>
<link rel="stylesheet" href="${CP}/resources/css/guide/guide.css">  <!-- guide.css -->
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
</head>
<body>
    <div class="container"> <!-- 컨테이너 추가 -->
        <section>
            <div class="row">
                <h2>이용안내</h2>
            </div>
        </section>
        
<div class="icon_container">
    <h3>지도 아이콘 안내</h3>
    <div class="icon_row">
        <div class="info_item">
            <div class="info_icon">
                <img src="${CP}/resources/img/map/A04.png" alt="공사 아이콘">
            </div>
            <div class="info_contents">
                <h4 class="info_title bold_font">공사지점 아이콘</h4>
                <p class="info_content">공사가 진행되어 혼잡한 지점을 표시합니다.</p>
            </div>
        </div>
        <div class="info_item">
            <div class="info_icon">
                <img src="${CP}/resources/img/map/A10.png" alt="집회 아이콘">
            </div>
            <div class="info_contents">
                <h4 class="info_title bold_font">집회/행사 아이콘</h4>
                <p class="info_content">집회/행사로 인한 혼잡한 지점을 표시합니다.</p>
            </div>
        </div>
    </div>
    <div class="icon_row">
        <div class="info_item">
            <div class="info_icon">
                <img src="${CP}/resources/img/map/A01.png" alt="사고 아이콘">
            </div>
            <div class="info_contents">
                <h4 class="info_title bold_font">사고지점 아이콘</h4>
                <p class="info_content">사고가 발생하여 혼잡한 지점을 표시합니다.</p>
            </div>
        </div>
        <div class="info_item">
            <div class="info_icon">
                <img src="${CP}/resources/img/map/A11.png" alt="통제 아이콘">
            </div>
            <div class="info_contents">
                <h4 class="info_title bold_font">교통통제 아이콘</h4>
                <p class="info_content">교통이 통제되고 있는 지점을 표시합니다.</p>
            </div>
        </div>
    </div>
    <div class="icon_row">
        <div class="info_item">
            <div class="info_icon">
                <img src="${CP}/resources/img/map/A09.png" alt="기상 아이콘">
            </div>
            <div class="info_contents">
                <h4 class="info_title bold_font">기상지점 아이콘</h4>
                <p class="info_content">기상문제가 발생하여 혼잡한 지점을 표시합니다.</p>
            </div>
        </div>
        <div class="info_item">
            <div class="info_contents">
                <p class="info_content">그 외에 혼잡 정보를 제공하는 다양한 아이콘이 있습니다.</p>
            </div>
        </div>
    </div>
</div>
 <!-- icon_container 종료 -->

<div class="page_container"> <!-- page_container  -->
    <section> 
        <div>
            <h3>페이지 기능 안내</h3>
        </div>
        <div>
            <h4>- 메인 페이지의 사이드 버튼</h4>
			<div class="flex flex_space">
			    <p class="info_content" style="list-style: none; padding: 0; margin: 0;">지도에는 돌발, 결빙, 사고다발 정보를 표시합니다.</p>
			</div>
            <div class="page_row">
                <div class="page_item">
                    <div class="info_contents">
                        <h4 class="info_title bold_font">돌발</h4>
                        <p class="info_content">
                            서울 시 내 돌발 정보를 실시간으로 제공합니다.<br>리스트의 상단 바를 클릭 시 해당 위치를 중심으로 지도가 반영됩니다.
                        </p>
                    </div>
                </div>
                <div class="page_item">
                    <div class="info_contents">
                        <h4 class="info_title bold_font">결빙</h4>
                        <p class="info_content">
                            초기에는 전체 년도의 결빙 정보가 표시됩니다.<br>
                            전체 선택을 해제한 후 각 년도를 클릭할 시 해당 년도의 결빙 정보의 위치가 폴리곤으로 표시됩니다.<br>
                            폴리곤을 클릭할 시 해당 위치의 사고 정보를 제공합니다.
                        </p>
                    </div>
                </div>
            </div>
            <div class="page_row">
                <div class="page_item">
                    <div class="info_contents">
                        <h4 class="info_title bold_font">사고 다발</h4>
                        <p class="info_content">
                            각 년도의 사고 위험 지역을 표시합니다.<br>
                            년도를 선택 후, 지역을 선택하고 조회를 할 시<br>위험도에 따른 마커를 표시합니다.<br>
                            위험도는 1~5로 해당 년도의 사고 발생 건수의 백분위를<br>5구간으로 나눈 정보입니다.
                        </p>
                    </div>
                </div>
                <div class="page_item">
                    <!-- 여기에 추가 항목을 삽입할 수 있습니다. -->
                </div>
            </div>
        </div>
        <div>
            <h4>- 상황별 안전 정보</h4>
            <div class="page_row">
                <div class="page_item">
                    <div class="info_contents">
                        <h4 class="info_title bold_font">상황별 안전 정보</h4>
                        <p class="info_content">
                            다양한 상황에서 안전을 지키기 위한 정보를 제공합니다.
                        </p>
                    </div>
                </div>
                <div class="page_item">
                    <div class="info_contents">
                        <h4 class="info_title bold_font">위급상황 대처방법</h4>
                        <p class="info_content">
                            긴급한 상황에서 효과적으로 대처하는 방법을 안내합니다.
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <h4>- 커뮤니티</h4>
            <div class="page_row">
                <div class="page_item">
                    <div class="info_contents">
                        <h4 class="info_title bold_font">게시판</h4>
                        <p class="info_content">
                            이용자가 현재 돌발 정보를 게시합니다.<br>지역별로 현재 상황을 공유하고 소통하며 위험에 대비합니다.
                        </p>
                    </div>
                </div>
                <div class="page_item">
                    <div class="info_contents">
                        <h4 class="info_title bold_font">공지사항</h4>
                        <p class="info_content">
                            공지사항은 뭐라 쓰지...
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div> <!-- page_container 종료 -->
        
    </div> <!-- 컨테이너 종료 -->
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
