<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">
<link rel="stylesheet"  href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="${CP }/resources/css/bootstrap/simplemde.min.css">
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>
<script src="${CP}/resources/js/common.js"></script>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css"> 
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>
<script src="${CP}/resources/js/safeInfoPage/safe_save.js"></script>
<title>오늘 사람 프로그램</title>
<style>
    .fixed-width-input {
        width: 300px;
    }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
user : ${user}
<div class="container">
	<div class="d-flex align-items-center justify-content-between">
	    <h2 class="mb-0">게시물 작성</h2>
	    <div class="d-flex">
	        <input type="button" value="목록" id="moveToList" class="btn btn-secondary me-2">
	        <input type="button" value="등록" id="doSave" class="btn btn-dark">
	    </div>
	</div>
	<hr>
  <!--// 버튼 ----------------------------------------------------------------->
  <!-- form -->
	<form action="${CP}/safe/save.do" class="form-horizontal"  name="regForm" id="regForm" method="post" enctype="multipart/form-data">
  		<div class="row mb-2"> 
  			<label for="boardDiv" class="col-sm-2 col-form-label">게시판 구분</label>
	  		<div class="col-sm-1">
		  		<select id="boardDiv" name="boardDiv" class="form-select fixed-width-input">
		        	<option value="">전체</option>
		        	<option value="30">상황별 안전 정보</option>
		        	<option value="40">위급상황 대처방법</option>
				</select>
			</div>
   		</div>
	   <div class="row mb-2">
	        <label for="title" class="col-sm-2 col-form-label">제목</label>
	        <div class="col-sm-10">
	          <input type="text" class="form-control" name="title" id="title"  maxlength="75" required="required">
	        </div>
	    </div>
	    <div class="row mb-2">
	        <label for="userId" class="col-sm-2 col-form-label">작성자</label>
	        <div class="col-sm-2">
	        <input type="text" value="${user.userId}" class="form-control" disabled=false name="userId" id="userId"  maxlength="20" required="required">
	        </div>
	    </div>
	    <div class="row mb-2">
	        <label for="imgLink" class="col-sm-2 col-form-label">이미지 링크</label>
	        <div class="col-sm-10">
	          <input type="file" multiple class="form-control" name="fileName" id="imgLink">        
	        </div>        
	    </div>
	    <div class="row mb-2">
	        <label for="content" class="col-sm-2 col-form-label">내용</label>
	        <div class="col-sm-10">
	         <textarea style="height: 200px"  class="form-control" id="content" name="content"></textarea>
	        </div>
	    </div> 
    </form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
<script>
    var simplemde = new SimpleMDE({ element: document.getElementById("content")})
</script>
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.js"></script>
</body>
</html>
