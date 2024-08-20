<%@page import="com.acorn.doma.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

<%
    User outVO = (User)session.getAttribute("user");
    String userId = null;
    if (outVO != null) {
        userId = outVO.getUserId();
    } else {
        out.println("User session attribute is null"); // Debugging output
    }
%>

<c:set var="CP" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%-- favicon --%>
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">

<%-- Google Fonts --%>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script>

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<%-- Additional CSS --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">


<style>
    .table-content {
        font-family: 'Nanum Gothic', sans-serif !important;
        margin-top: 100px;
        margin-bottom: 100px;
        text-align: center; /* Center-aligns the header and table content */
    }

    .table {
        font-family: 'Nanum Gothic', sans-serif !important;
        margin: 20px auto;
        width: 80%; /* Adjust table width to fit the container */
        max-width: 1200px; /* Prevent the table from becoming too wide */
    }

    .table thead th, .table tbody td {
        font-family: 'Nanum Gothic', sans-serif !important;
        text-align: center; /* Center-aligns the table content */
    }

    .table table-hover {
        font-family: 'Nanum Gothic', sans-serif;
    }
</style>

<script>
document.addEventListener("DOMContentLoaded", function() {
    console.log("DOMContentLoaded");

    let popupWindow = null;

    function updateBoard(seq) { 
        console.log("updateBoard called with seq:", seq);
        const url = "/doma/mypage/mpBoardSelectOne.do?seq=" + seq + "&div=10"; 
        popupWindow = window.open(url, "popupWindow", "width=800,height=600,scrollbars=yes,resizable=yes");
    }

    window.onfocus = function() {
        if (popupWindow && popupWindow.closed) {
            window.location.reload();
        }
    };

    function deleteBoard(seq, userId) { 
        console.log("deleteBoard called with seq:", seq, "and userId:", userId);

        if (!seq) {
            alert('seq를 확인 하세요.');
            return;
        }

        if (!confirm("삭제 하시겠습니까?")) return;

        let type = "GET";
        let url = "/doma/board/doDelete.do";
        let async = "true";
        let dataType = "html";
        let params = {
            "seq": seq,
            "userId": userId
        };

        console.log("Sending AJAX request with params:", params);

        PClass.pAjax(url, params, dataType, type, async, function(data) {
            console.log("AJAX response received:", data);
            if (data) {
                try {
                    const message = JSON.parse(data);
                    if (message && message.messageId === 1) {
                        alert(message.messageContents);
                        location.reload();
                    }  
                } catch (e) {
                    location.reload();
                }
            }
        });
    }

    document.querySelectorAll(".updateBoardBtn").forEach(function(button) {
        button.addEventListener("click", function(event) {
            const seq = button.getAttribute("data-seq");
            updateBoard(seq);
        });
    });

    document.querySelectorAll(".deleteBoardBtn").forEach(function(button) {
        button.addEventListener("click", function(event) {
            const seq = button.getAttribute("data-seq");
            const userId = button.getAttribute("data-userId");
            deleteBoard(seq, userId);
        });
    });
});
</script>

<title>DOMA</title> 
</head> 
<body> 
    <div class="table-content">
        <h2>게시글 목록</h2>
        <table class="table table-hover"> 
            <thead>
                <tr class="table-secondary">
                    <th>seq</th>
                    <th>제목</th>
                    <th>수정자</th>
                    <th>코멘트</th>
                    <th>지역</th>
                    <th>조회수</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${list.size() > 0}">
                        <c:forEach var="vo" items="${list}">
                            <tr>
                                <td class="text-center"><c:out value="${vo.seq}"></c:out></td>
                                <td class="text-center"><c:out value="${vo.title}"></c:out></td>
                                <td class="text-center"><c:out value="${vo.modId}"></c:out></td>
                                <td class="text-center"><c:out value="${vo.content}"></c:out></td>
                                <td class="text-center"><c:out value="${vo.gname}"></c:out></td>
                                <td class="text-center"><c:out value="${vo.views}"></c:out></td>
                                <td>
                                    <button type="button" class="btn btn-outline-secondary updateBoardBtn" data-seq="${vo.seq}">
                                        수정
                                    </button>
                                    <button type="button" class="btn btn-outline-danger deleteBoardBtn" data-seq="${vo.seq}" data-userId="${vo.userId}">
                                        삭제
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td class="text-center" colspan="99">No data found!</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div> 

    <%@ include file="/WEB-INF/views/template/footer.jsp" %>
</body>
</html>
