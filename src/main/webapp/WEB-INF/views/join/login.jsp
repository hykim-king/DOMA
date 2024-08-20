<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="stylesheet" href="${CP}/resources/css/user/loginPage.css">
    <script src="${CP }/resources/js/user/login.js"></script>
    <script src="${CP }/resources/js/common.js"></script>
	<script src="${CP }/resources/js/jquery_3_7_1.js"></script>
<title>DOMA</title>
</head>
<body>
	 
	<div>
		<form>
			<h1 id="litheader">DOMA</h1>
			<div class="inset">
				<p><input type="text" name="userId" id="userId" placeholder="id"></p>
				<p><input type="password" name="password" id="password" placeholder="password"></p>
				<div style="text-align: center;">
					<div class="checkboxouter">
						<input type="checkbox" name="rememberme" id="remember" value="Remember">
						<label class="checkbox"></label>
					</div>
					<label for="remember">회원정보 기억하기</label>
				</div>
				<input class="loginLoginValue" type="hidden" name="service" value="login" />
			</div>
			<p class="p-container"><input type="button" id="login" value="로그인"></p>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>