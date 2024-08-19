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
        margin-top: 100px;
        margin-bottom: 100px;
    }
     

	.table {
		margin: 20px;
    	width: 800px; /* 테이블 너비를 부모 컨테이너에 맞게 조정 */
    	 
	}

	.table thead th, .table tbody td {
    	text-align: center; /* 가운데 정렬 */
	}
</style>



<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");

    const seqInput = document.querySelector("#seq");
    const userIdInput = document.querySelector("#userId");

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

        if (isEmpty(seq)) {
            alert('seq를 확인 하세요.');
            return;
        }

        if (confirm("삭제 하시겠습니까?") === false) return;

        let type = "GET";
        let url = "/doma/board/doDelete.do";
        let async = "true";
        let dataType = "html";
        let params = {
            "seq": seq,
            "userId": userId
        };

        console.log("Sending AJAX request with params:", params);

        PClass.pAjax(url, params, dataType, type, async, function(data){
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

    document.querySelectorAll(".updateBoardBtn").forEach(function(button){
        button.addEventListener("click", function(event){
            const seq = button.getAttribute("data-seq");
            updateBoard(seq);
        });
    });

    document.querySelectorAll(".deleteBoardBtn").forEach(function(button){
        button.addEventListener("click", function(event){
            const seq = button.getAttribute("data-seq");
            const userId = button.getAttribute("data-userId");
            // Get userId from hidden input or embedded variable
            deleteBoard(seq, userId);
        });
    });
});

</script>

<title>게시판</title> 
  
</head> 
<body> 
    <div class="table-content text-center d-flex justify-content-center">
    <!-- Hidden input to hold the seq value -->
    <input type="hidden" id="seq" value="">
    <!-- Your table and other content -->
    <table class="table table-hover"> 
        <div>
            <h2>게시글 목록</h2> 
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
                 <th>
    					<button type="button" class="btn btn-outline-secondary updateBoardBtn" data-seq="${vo.seq}"  >
       			 				수정  </button>
    					<button type="button" class="btn btn-outline-danger deleteBoardBtn" data-seq="${vo.seq}" data-userId="${vo.userId}" >삭제</button>
        						  </button>
				</th>
				
				
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td class="text-center" colspan="99">No data found!</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
                </div>
            </table>
            
        </div> 

    <%@ include file="/WEB-INF/views/template/footer.jsp" %>
</body>
</html>