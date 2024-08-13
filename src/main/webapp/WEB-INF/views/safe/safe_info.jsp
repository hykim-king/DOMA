<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script> 
<title>Insert title here</title>

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
	height : 500px;
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
.img_section{
	height: 150px;
	border-radius : 20px 20px 0px 0px;
}
.title_section{
	height: 30px;
	border-radius : 0px 0px 20px 20px;
	text-align : center;
}
li{
	border : 2px solid #495057;
	margin: 0px;
	padding : 0px;
	overflow : hidden;
}
li.hover{

}
</style>
<body>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
				<button class="button btnFade btnGray" onclick="deleteBtn()">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
					  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
					  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
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
 </body>
 <script src="${CP}/resources/js/safeInfoPage/safeInfoPage.js"></script>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>