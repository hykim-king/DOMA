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
    <link rel="icon" href="${CP}/resources/img/pcon.png" type="image/x-icon">
    
    <script src="${CP }/resources/js/user/header.js"></script>
</head>

<body>
    <header>
    <!-- Header Container -->
    <div class="header-container" style="display : inline-block; width: 100%;">
    	<div>
            <a class="navbar-brand" href="/doma/main/main.do">
                <img src="${CP}/resources/img/logoo.png" alt="Logo"  style="width: 100px; height:100px;">
            </a>
        </div>
        <div class="main-nav">
            <table class="menu-align">
            	<tr>
	                <td class="dropdown">
	                    <a style="width:200px;"aria-current="page" href="${CP}/safe/safePage.do">상황별 안전 정보</a>
	                </td>
	                <td class="dropdown">
	                    <a style="width:200px; aria-current="page" href="${CP}/board/doDelete.do">데이터 시각화</a>
	                </td>
	                <td class="dropdown">
	                    <a style="width:200px; aria-current="page" href="${CP }/template/list.do">공지사항</a>
	                </td>
	                <td class="dropdown">
	                    <a style="width:200px; aria-current="page" href="${CP}/board/doRetrieve.do?div=10">커뮤니티</a>
	                </td>
                </tr>
            </table>
            <table class="menu-align" style="margin-left : 30%;">
		         <tr>
		             <td><a id="main_page" style="margin-right : 20px;">Home</a></td>
		             <td><a id="register_page"  style="margin-right : 20px;">Join</a></td>
		             <td><a id="login_page"  style="margin-right : 20px;">Login</a></td>
		         </tr>
	        </table>
        </div>
     </div>
     </header>
</body>
</html>