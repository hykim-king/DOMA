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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- favicon  --%>
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">

<link rel="stylesheet" href="${CP}/resources/css/bootstrap-ege.min.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<script>

</script>

<title>리뷰쓰기</title>
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
                            <input type="text" class="form-control" id="userId" aria-describedby="userId" placeholder="userId" disabled="disabled">  
                            <input type="password" class="form-control" id="password" aria-describedby="password" placeholder="password"> 
                            <input type="email" class="form-control" id="email" aria-describedby="email" placeholder="email"  > 
                            <input type="text" class="form-control" id="bitrhday" aria-describedby="bitrhday" placeholder="bitrhday"  >  
                            <input type="text" class="form-control" id="address" aria-describedby="address" placeholder="address" disabled="disabled"> 
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
</html>
