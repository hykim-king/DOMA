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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- favicon  --%>
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script> 

<%-- google Nanum+Gothic --%>
<link rel="stylesheet"  href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">

<%-- bootstrap icon --%>
<link rel="stylesheet" href="${CP}/resources/icon/font/bootstrap-icons.min.css">

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<link rel="stylesheet" href="${CP}/resources/css/bootstrap-ege.min.css"> 
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        display: flex;
        gap: 20px;
        padding: 20px;
    }
    .left-container {
        flex-basis: 30%; /* Set left-container to 30% of the width */
        padding: 20px;
    }
    .right-container {
        flex-basis: 70%; /* Set right-container to 70% of the width */
        padding: 20px;
    }
    .form-container {
        display: flex;
        align-items: flex-start;
    }
    .form-container h2 {
        margin-right: 20px;
        white-space: nowrap;
        margin-top: 40px;
    }
    .form-content {
        flex: 1;
    }
    .form-btn {
        display: flex;
        justify-content: flex-end;
    }
    form {
        display: flex;
        flex-direction: column;
    }
    form label, form input {
        margin-bottom: 10px;
    }
    .table-container {
        display: flex;
        align-items: flex-start;
    }
    .table-container h2 {
        margin-right: 20px;
        white-space: nowrap;
        margin-top: 40px;
    }
    .table-content {
        margin-top: 40px;
        text-align: center;
        flex: 1;
    }
     
</style>
<title>내 정보</title>
 <script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");   
    
    
  	//수정버튼:doUpdate
	const doUpdateBtn = document.querySelector("#doUpdate");
	 
    
    //seq
    const userIdInput = document.querySelector("#userId");
     
    const userNameInput = document.querySelector("#userName");
     
    const userPwInput = document.querySelector("#userPw");
     
    const userEmailInput = document.querySelector("#userEmail");
    
    const birthInput = document.querySelector("#birth");
    const addressInput = document.querySelector("#address");
    
    const detailAddressInput = document.querySelector("#detailAddress");
     

 )}

</script> 
</head>
<body>
    <div class="container">
    <div class="left-container">
    <div class="form-container">
                <h2>내 정보</h2>
                <div class="form-content">
                    <form action="" method="">
                        <div>
                            <label for="userInfo" class="form-label mt-4"></label>
                            <input type="text" class="form-control" 	value="<c:out value='${user.userId }'/>" 		id="userId"    		name="userId"     disabled="disabled">
                             <input type="text" class="form-control"	value="<c:out value='${user.userName }'/>"  	id="userName"  		name="userName" >   
                            <input type="password" class="form-control" value="<c:out value='${user.userPw }'/>"  		id="userPw"    		name="userPw"  > 
                            <input type="email" class="form-control" 	value="<c:out value='${user.userEmail }'/>" 	id="userEmail" 		name="userEmail" > 
                            <input type="text" class="form-control" 	value="<c:out value='${user.birth }'/>" 		id="birth"	   		name="birth" >  
                            <input type="text" class="form-control" 	value="<c:out value='${user.address }'/>"	    id="address"   		name="address"       disabled="disabled">
                            <input type="text" class="form-control" 	value="<c:out value='${user.detailAddress }'/>" id="detailAddress"  name="detailAddress"    disabled="disabled">  
                        </div>  
                        <br> 
                        <div class="form-btn">
                        <input type="reset" id="resetBtn" class="btn btn-outline-secondary " value="초기화" >&nbsp; &nbsp; 
                        <input type="submit" id="updateBtn" class="btn btn-outline-secondary " value="수정" > 
                        </div>
                    </form>
    </div>
    </div>
    </div>
   <div class="right-container">
   <!-- 게시글 테이블  -->
   <div class="table-container">
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
    				
					<tr>
					<td>1</td>
					<td>제목_1</td>
					<td>서울 서초동</td>
					<td>27</td>
					<th><button type="button" class="btn btn-outline-secondary" >수정</button>
						<button type="button" class="btn btn-outline-danger" >삭제</button></th>
					  
					</tr>
					
					<tr>
					<td>2</td>
					<td>제목_2</td>
					<td>서울 서대문구</td>
					<td>27</td>
					<th><button type="button" class="btn btn-outline-secondary" >수정</button>
						<button type="button" class="btn btn-outline-danger" >삭제</button></th>
					</tr>
					<tr>
					<td>3</td>
					<td>제목_3</td>
					<td>서울 마포구</td>
					<td>27</td>
					<th><button type="button" class="btn btn-outline-secondary" >수정</button>
						<button type="button" class="btn btn-outline-danger" >삭제</button></th>
					</tr>
                
                    <!-- 실제 데이터는 서버에서 가져와서 여기에 추가 -->
                </tbody>
            	</table>
            	 
            	
    </div>
    </div>
    <!-- 답글테이블 -->
    <div class="table-container">
            	&nbsp; &nbsp; &nbsp; <h2>답글</h2>
            	<div class="table-content">
            	<table  class="table table-hover">
                <thead>
                    <tr class="table-secondary">
      				<!-- <th scope="row">Warning</th> -->
     				<th>순번</th>
      				<th>제목</th>
      				<th>지역</th>
     			    <th>작성자</th>
     			    <th>***</th>
    				</tr>
    				
					<tr>
					<td>1</td>
					<td>제목_1</td>
					<td>서울 서초동</td>
					<td>저스트다람쥐</td>
					<th><button type="button" class="btn btn-outline-secondary" >수정</button>
						<button type="button" class="btn btn-outline-danger" >삭제</button></th>
					  
					</tr>
					
					<tr>
					<td>2</td>
					<td>제목_2</td>
					<td>서울 서대문구</td>
					<td>오늘의토끼</td>
					<th><button type="button" class="btn btn-outline-secondary" >수정</button>
						<button type="button" class="btn btn-outline-danger" >삭제</button></th>
					</tr>
					<tr>
					<td>3</td>
					<td>제목_3</td>
					<td>서울 마포구</td>
					<td>마포갈매기</td>
					<th><button type="button" class="btn btn-outline-secondary" >수정</button>
						<button type="button" class="btn btn-outline-danger" >삭제</button></th>
					</tr>
                
                    <!-- 실제 데이터는 서버에서 가져와서 여기에 추가 -->
                </tbody>
            	</table>
            	 
            	
    </div>
    </div>
    
    </div>
</div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %>

<script src="/ehr/resources/js/bootstrap.bundle.js"></script>  
</html>
