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

 
<style>
    .table-content {
        margin-top: 50px;
        margin-bottom:50px;
    }
     

	.table {
		margin: 20px;
    	width: 1000px; /* 테이블 너비를 부모 컨테이너에 맞게 조정 */
    	 
	}

	.table thead th, .table tbody td {
    	text-align: center; /* 가운데 정렬 */
	}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");

    // Update Board function
    function updateComment(seq) {  
    	//http://localhost:8080/doma/main/boardInfo.do?seq=1&div=10
    	const url = "/doma/main/boardInfo.do?seq=" + seq +"&div=10"; 
    	popupWindow = window.open(url, "popupWindow", "width=800,height=600,scrollbars=yes,resizable=yes");
    }
    
    window.onfocus = function() {
        if (popupWindow && popupWindow.closed) {
            window.location.reload();
        }
    };
 

    // Attach event listeners to each button after the page is loaded
    document.querySelectorAll(".updateCommentBtn").forEach(function(button){
        button.addEventListener("click", function(event){
            const seq = button.getAttribute("data-seq"); 
            updateComment(seq);
        });
    });

    

});
</script>
<title>comment</title>
</head>
<body> 
     <!-- <p>${user}</p> -->
    
     <div class="table-content text-center d-flex justify-content-center">
    <div>
    <h2>코멘트</h2> 
            	<div class="table-content">
            	<table  class="table table-hover">
                <thead>
                    <tr class="table-secondary">
      				<!-- <th scope="row">Warning</th> -->
     				<th>순번</th>
      				<th>코멘트</th>
      				<th>MODID</th>
      				<th>작성날짜</th>
     			    <th>수정날짜</th>
     			    <th>관리</th>
    				</tr>
    				</thead>
    			<tbody>
		          <c:choose>
		            <c:when test="${list.size() > 0 }">
		              <c:forEach var="vo" items="${list }">
    				
					<tr>  
					<td class="text-center" ><c:out value="${vo.seq }"></c:out></td>
					<td class="text-center" ><c:out value="${vo.comments }"></c:out></td>
					<td class="text-center" ><c:out value="${vo.modId }"></c:out></td>
					<td class="text-center" ><c:out value="${vo.regDt }"></c:out></td>
					<td class="text-center" ><c:out value="${vo.modDt }"></c:out></td>
					<th>
    					<button type="button" class="btn btn-outline-secondary updateCommentBtn" data-seq="${vo.seq}"  >
       			 				바로가기  </button>
    					 
				</th>
					 </c:forEach>
		            </c:when>
		            <c:otherwise>
		                 <tr><td class="text-center" colspan="99">No data found!</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    </div>
    
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %>
</html>
