<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<body>
    <div class="pageDiv">
        <h2 class="pageH2">위급상황 대처방법</h2>
        <hr>
        <c:forEach var="acting" items="${list40}">
            <ul class="ui_section">
                <li id="acting_seq_${acting.seq}" style="display: none; border: 0;" data-value="${acting.seq}"></li>
                <li class="img_section">
                    <img src="${CP }/resources/img/board_img/${acting.imgLink}" style="width:100%; height:100%;">
                </li>
                <li class="title_section">${acting.title}</li>
            </ul>
        </c:forEach>
    </div>
</body>
	