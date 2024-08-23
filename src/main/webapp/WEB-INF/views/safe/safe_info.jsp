\<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/header.jsp" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script> 
<title>DOMA</title>

</head>
<style>
button {
  width: 60px;
  padding: 0;
  margin: 10px 20px 10px 0;
  font-weight: 600;
  text-align: center;
  line-height: 50px;
  color: #FFF;
  border : 0px;
  border-radius: 5px;
  transition: all 0.2s ;
}
.btnGray {
  background: #495057;
}
.btnFade.btnGray:hover {
  background: #343a40;
}
.pageDiv{
	width : 750px;
	height : auto;
	margin : 0px 0px 2% 7%;
}
.pageH2{
	padding : 5px;
	font-weight : bold;
}
.ui_section{
	list-style : none;
	width:30%;
	display : inline-block;
	margin : 5px 5px 15px 10px;
}
.ui_section:hover { 
    transform: scale(1.05);
}
.img_section {
    height: 150px;
    border-radius: 20px 20px 0 0;
    //border: 2px solid #495057;
    margin: 0;
    padding: 0;
    overflow: hidden;
    box-shadow: 6px 0 10px rgba(0, 0, 0, 0.2);
}

.title_section {
    height: 35px;
    border-radius: 0 0 20px 20px;
    //border: 2px solid #c5c5c5;
    border-top: 1px solid #ababab; 
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #ffffff;
    color: #333333; 
    display: flex; 
    align-items: center;
    justify-content: center; 
    font-size: 14px; 
    font-weight: bold;
    /* font-family: Arial, sans-serif; */
    box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.2);
}




.token-link {
    position: relative;
    display: inline-block;
    color: #2c3e50;
    border-radius: 24px;
    text-decoration: none;
    font-size: 1.2rem;
    font-weight: bold;
    padding: 8px 16px 10px;
    margin-left:10px;
    margin-right:10px;
}
.token-link:hover {
  z-index: 2;
  border-radius: 24px;
  color: white;
  text-decoration: none;
  background-color: #2c3e50;
  border-color: #dee2e6;
}
.token.active .token-link {
  z-index: 3;
  color: #fff;
  background-color: #2c3e50;
}
.token:first-child .token-link {
  
}

.token:last-child .token-link {
  
}
</style>
<body>
 <div style="margin : 1% 0px 15px 80%;">
	<c:choose>
		<c:when test="${user ne null}">
			<c:choose>
				<c:when test="${user.grade == 0}">
				<button class="button btnFade btnGray" onclick="saveBtn()">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
				  		<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
				  		<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
					</svg>
				</button>
				</c:when>
			</c:choose>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
 </div>
 <div style="display:flex">
 	 <jsp:include page="/WEB-INF/views/safe/info_by_situation.jsp"></jsp:include>
 	 <jsp:include page="/WEB-INF/views/safe/acting_by_situation.jsp"></jsp:include>
 </div>
  <!-- 페이지네이션 -->
  <nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <c:set var="maxPages" value="${totalPages30 > totalPages40 ? totalPages30 : totalPages40}" />
    <c:set var="currentPageNo" value="${pageNo30}" />
    <c:choose>
      <c:when test="${currentPageNo > 1}">
        <li class="token">
          <a class="token-link" href="${CP}/safe/safePage.do?pageNo=${currentPageNo - 1}">Previous</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="token">
          <span class="token-link">Previous</span>
        </li>
      </c:otherwise>
    </c:choose>

    <c:forEach var="i" begin="1" end="${maxPages}">
      <li class="token <c:if test="${i == currentPageNo}">active</c:if>">
        <a class="token-link" href="${CP}/safe/safePage.do?pageNo=${i}">${i}</a>
      </li>
    </c:forEach>

    <c:choose>
      <c:when test="${currentPageNo < maxPages}">
        <li class="token">
          <a class="token-link" href="${CP}/safe/safePage.do?pageNo=${currentPageNo + 1}">Next</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="token">
          <span class="token-link">Next</span>
        </li>
      </c:otherwise>
    </c:choose>
  </ul>
</nav>

 </body>
 <script src="${CP}/resources/js/safeInfoPage/safeInfoPage.js"></script>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>