<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>DOMA</title>
    <link rel="stylesheet" type="text/css" href="${CP}/resources/css/styles.css">
    <script src="${CP }/resources/js/user/header.js"></script>
</head>

<body>
    <header>
        <div class="logo">
            <img src="${CP}/resources/img/logoo.png" alt="Logo">
        </div>
        <nav>
            <div class="back color-3">
                <div class="row columns">
                    <ul class="menu-align">
                        <li><a id="main_page">Home</a></li>
                        <li><a id="register_page">Join</a></li>
                        <li><a id="login_page">Login</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <!-- Header Container -->
    <div class="header-container">
        <nav class="main-nav">
            <ul>
                <li class="dropdown">
                    <a aria-current="page" href="${CP}/user/doRetrieve.do">상황별 안전 정보(공사중)</a>
                </li>
                <li class="dropdown">
                    <a aria-current="page" href="${CP}/board/doDelete.do">데이터 시각화(공사중)</a>
                </li>
                <li class="dropdown">
                    <a aria-current="page" href="${CP }/template/list.do">공지사항(공사중)</a>
                </li>
                <li class="dropdown">
                    <a aria-current="page" href="${CP }/community/community.do">커뮤니티</a>
                </li>
            </ul>
            <!-- 전체 서브메뉴 박스 -->
            <div class="dropdown-menu-container">
                <!-- 첫 번째 행 -->
                <div class="dropdown-menu">
                    <ul>
                        <li><a href="#">Submenu 1-1</a></li>
                        <li><a href="#">Submenu 2-1</a></li>
                        <li><a href="#">Submenu 3-1</a></li>
                        <li><a href="#">Submenu 4-1</a></li>
                    </ul>
                </div>
                <!-- 두 번째 행 -->
                <div class="dropdown-menu">
                    <ul>
                        <li><a href="#">Submenu 1-2</a></li>
                        <li><a href="#">Submenu 2-2</a></li>
                        <li><a href="#">Submenu 3-2</a></li>
                        <li><a href="#">Submenu 4-2</a></li>
                    </ul>
                </div>
                <!-- 세 번째 행 -->
                <div class="dropdown-menu">
                    <ul>
                        <li><a href="#">Submenu 1-3</a></li>
                        <li><a href="#">Submenu 2-3</a></li>
                        <li><a href="#">Submenu 3-3</a></li>
                        <li><a href="#">Submenu 4-3</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</body>
</html>
