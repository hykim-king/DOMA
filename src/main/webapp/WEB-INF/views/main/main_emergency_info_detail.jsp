    <%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    <c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="${CP}/resources/css/main/main_emergency_info.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
</head>
<div>
    <h3>사고 정보</h3>
    <table class="info_table">
        <colgroup>
            <col style="width: 30%;">
            <col style="width: 70%;">
        </colgroup>
        <tbody>
            <tr>
                <th>사고 이름</th>
                <td>${accIdSelect.accName}</td>
            </tr>
            <tr>
                <th>사고 유형</th>
                <td>${accIdSelect.accDName}</td>
            </tr>
            <tr>
                <th>기간</th>
                <td>${accIdSelect.occrDate} ${accIdSelect.occrTime} ~ <br>${accIdSelect.endDate} ${accIdSelect.endTime}</td>
            </tr>
            <tr>
                <th>정보</th>
                <td>${accIdSelect.info}</td>
            </tr>
        </tbody>
    </table>
</div>
</html>
