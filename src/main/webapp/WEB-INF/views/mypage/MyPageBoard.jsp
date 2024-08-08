<%--
/**
    Class Name:
    Author : acorn
    Description:
    Modification information

    수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 7. 25        최초작성 

    D-O-M-A 개발팀
    since 2020.11.23
    Copyright (C) by KandJang All right reserved.
*/
--%>
<%@page import="com.acorn.doma.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
    User outVO = (User)session.getAttribute("user");
    String userId = null;
    if (outVO != null) {
        userId = outVO.getUserId();
        out.println("User ID: " + userId); // Debugging output
    } else {
        out.println("User session attribute is null"); // Debugging output
    }
%>

<c:set var="CP"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%-- favicon  --%>
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script>

<%-- google Nanum+Gothic --%>
<link rel="stylesheet"  href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css">
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<title>게시판</title>
<script>
    document.addEventListener("DOMContentLoaded", function(){
        console.log("<%= userId %>");
        console.log("DOMContentLoaded");
    });
</script>

</head>
<body> 
     <!-- <p>${user}</p> -->
    ${list} 
    
    <h2>게시글</h2> 
            	<div class="table-content">
            	<table  class="table table-hover">
                <thead>
                    <tr class="table-secondary">
      				<!-- <th scope="row">Warning</th> -->
     				<th>순번</th>
      				<th>제목</th>
      				<th>지역</th>
     			    <th>추천수</th>
     			    <th>***</th>
    				</tr>
    				</thead>
    			<tbody>
		          <c:choose>
		            <c:when test="${list.size() > 0 }">
		              <c:forEach var="vo" items="${list }">
    				
					<tr> 
					<td class="text-center" ><c:out value="${vo.title }"></c:out></td>
					<td class="text-center" ><c:out value="${vo.gname }"></c:out></td>
					<td class="text-center" ><c:out value="${vo.views }"></c:out></td>
					<th><button type="button" class="btn btn-outline-secondary" >수정</button>
						<button type="button" class="btn btn-outline-danger" >삭제</button></th>
					  
					</tr>
					 </c:forEach>
		            </c:when>
		            <c:otherwise>
		                <tr><td class="text-center" colspan="99" >No data found!</td></tr>
		            </c:otherwise>
		          </c:choose>
                
                    <!-- 실제 데이터는 서버에서 가져와서 여기에 추가 -->
                </tbody>
            	</table>
            	 
            	
    </div>
    </div>
    
    
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %>
</html>
