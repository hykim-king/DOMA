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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap">
</head>
</head>
<body>
    <header>
    <!-- Header Container -->
    <div class="header-container" style="display : inline-block; width: 100%;">
        <div>
            <a class="navbar-brand" href="/doma/main/main.do">
                <img src="${CP}/resources/img/logoo.png" alt="Logo"  style="width: 135px; height: auto;">
            </a>
        </div>
        <div class="main-nav">
            <table class="menu-list">
                <tr>
                    <td class="dropdown">
                        <a aria-current="page" href="${CP}/main/guide.do">이용안내</a>
                    </td>
                    <td class="dropdown">
                        <a aria-current="page" href="${CP}/safe/safePage.do">상황별 안전정보</a>
                    </td>
                    <td class="dropdown">
                        <a aria-current="page" href="${CP}/chart/chartMonth.do">데이터 시각화</a>
                    </td>
                    <td class="dropdown">
                        <a aria-current="page" href="${CP }/board/doRetrieveAn.do?=20">공지사항</a>
                    </td>
                    <td class="dropdown">
                        <a aria-current="page" href="${CP}/board/doRetrieve.do?div=10">커뮤니티</a>
                    </td>
                </tr>
            </table>
            <table class="menu-align" style="margin-left : 25%;">
                 <tr>
                     <c:choose>
                        <c:when test="${user ne null}">
                            <c:choose>
                                <c:when test="${user.grade == 0}">
                                    <td><a id="main_page" style="margin-right : 20px;" href="${CP }/main/main.do">Home</a></td>
                                    <td><a id="my_page"  style="margin-right : 20px;" href="${CP }/mypage/myPage.do">MyPage</a></td>
                                    <td><a id="admin_page" style="margin-right : 20px;" href="${CP }/admin/adminnotice.do">AdminPage</a></td>
                                    <td><a id="logout" style="margin-right : 20px;" href="${CP }/user/logout.do">logout</a></td>
                                </c:when>
                                <c:when test="${user.grade == 1}">
                                    <td><a id="main_page" style="margin-right : 20px;" href="${CP }/main/main.do">Home</a></td>
                                    <td><a id="my_page"  style="margin-right : 20px;" href="${CP }/mypage/myPage.do">MyPage</a></td>
                                    <td><a id="logout" style="margin-right : 20px;" href="${CP }/user/logout.do">logout</a></td>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <td><a id="main_page" style="margin-right : 20px;" href="${CP }/main/main.do">Home</a></td>
                            <td><a id="register_page"  style="margin-right : 20px;" href="${CP }/user/RegisterPage.do">Join</a></td>
                            <td><a id="login_page"  style="margin-right : 20px;" href="${CP }/user/loginPage.do">Login</a></td>
                        </c:otherwise>
                    </c:choose>
                 </tr>
            </table>
        </div>
     </div>
     </header>
</body>
</html>