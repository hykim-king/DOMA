<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사이드바 예제</title>
    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .map-fn-l-box {
            display: inline-block; /* 사이드바를 인라인 블록으로 표시 */
            width: 105px; /* 사이드바의 너비 */
            padding: 7px; /* 내부 여백 */
            border: 1px solid #ddd; /* 테두리 */
            //border-radius: 8px; /* 모서리 둥글게 */
            background-color: #ffffff; /* 배경색 */
            box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.35); /* 그림자 효과 */
        }
		.map-fn-l-box .fn-alert, .map-fn-l-box .fn-road, .map-fn-l-box .fn-freezing {
		    display: inline-block;
		    width: 93px;
		    height: 39px;
		}
        .map-fn-l-box a {
            display: flex; /* 링크 내부의 아이콘과 텍스트를 가로로 정렬 */
            align-items: center; /* 세로 정렬 */
            margin-bottom: 10px; /* 각 링크 간 간격 */
            color: #333; /* 링크 텍스트 색상 */
            text-decoration: none; /* 밑줄 제거 */
            font-size: 16px; /* 텍스트 크기 */
        }

        .map-fn-l-box a:hover {
            background-color: #c3c3c338; /* 마우스 오버 시 배경색 */
            border-radius: 15px; /* 오버 시 테두리 둥글게 */
            padding: 1px; /* 오버 시 패딩 추가 */
        }

        .map-fn-l-box i {
            font-size: 20px; /* 아이콘 크기 조정 */
            margin-right: 2px; /* 아이콘과 텍스트 간격 */
        }

        .risk-title {
            display: flex; /* 제목과 아이콘을 가로로 정렬 */
            align-items: center; /* 세로 정렬 */
            margin-bottom: 20px; /* 제목과 링크 간 간격 */
            padding-bottom: 10px; /* 구분선과 링크 사이의 여백 */
            border-bottom: 1px solid #ababa9; /* 구분선 */
        }
    </style>
</head>
<body>
    <div class="map-fn-l-box">
        <!-- 주요 위험 요소 아이콘과 구분선 -->
        <div class="risk-title">
            <i class="bi bi-sort-down"></i>
        </div>

        <!-- 돌발 링크에 아이콘 추가 -->
        <a href="/doma/main/main.do" class="fn-alert" title="돌발">
            <i class="bi bi-exclamation-circle"></i>
            <span>돌발</span>
        </a>

        <!-- 결빙 링크에 아이콘 추가 -->
        <a href="/doma/freezing/freezing.do" class="fn-freezing" title="결빙">
            <i class="bi bi-cloud-snow"></i>
            <span>결빙</span>
        </a>

        <!-- 사고다발 링크에 아이콘 추가 -->
        <a href="/doma/point/point.do" class="fn-freezing" title="사고다발">
            <i class="bi bi-sign-stop"></i>
            <span>사고다발</span>
        </a>
    </div>
</body>
</html>
