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
</head>
<body>
    <!-- Footer -->
    <footer>
        <img class="footer-logo" src="${CP}/resources/img/footerlogo.png" alt="Footer Logo">
        <div class="footer-copyright">
            <p>&copy; 2024 DOMA. All rights reserved.</p>
        </div>
        <a id="top-button" href="#">
            <img src="${CP}/resources/img/top.png" alt="Top Button">
        </a>
    </footer>

    <!-- Include your JavaScript file -->
    <script src="${CP}/resources/js/script.js"></script>
    <script src="${CP}/resources/js/bootstrap.bundle.js"></script>    
</body>
</html>