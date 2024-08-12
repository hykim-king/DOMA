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
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>
<script src="${CP }/resources/js/safeInfoPage/safe_save.js"></script>
<title>오늘 사람 프로그램</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container">
  <div class="page-header">
      <h2>
      </h2>
  </div>
  <!--// 제목 end ------------------------------------------------------------->
  <!-- 버튼 -->
  <div class="mb-2 d-grid gap-2 d-md-flex justify-content-md-end">
      <input type="button" value="목록" id="moveToList" class="btn btn-primary">
      <input type="button" value="등록"  id="doSave" class="btn btn-primary">
  </div>
  <!--// 버튼 ----------------------------------------------------------------->
  <!-- form -->
  <form action="${CP}/board/fileUpload.do" class="form-horizontal"  name="regForm" id="regForm" action="${CP}/file/fileUpload.do" method="post" enctype="multipart/form-data">
  	<div style="display : flex">
  		<label for="boardDiv" class="col-sm-1 col-form-label">게시판 구분</label>
  		<select id="boardDiv" name="boardDiv" class="form-select" style="width:300px;">
        	<option value="">전체</option>
        	<option value="30">상황별 안전 정보</option>
        	<option value="40">위급상황 대처방법</option>
		</select>
		<label for="userId" class="col-sm-1 col-form-label" style="margin-left : 15%;">등록자</label>
        <div class="col-sm-2">
          <input type="text" value="<c:out value='${user.userId}'/>" class="form-control readonly-input" readonly="readonly" name="userId" id="userId"  maxlength="20" required="required">
        </div>
 	</div>
    <div class="row mb-2">
        <label for="title" class="col-sm-1 col-form-label">제목</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" name="title" id="title"  maxlength="75" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="imgLink" class="col-sm-2 col-form-label">이미지 링크</label>
        <div class="col-sm-10">
          <input type="file" class="form-control" name="imgLink" id="imgLink">        
        </div>        
    </div>
    <div class="row mb-2">
        <label for="content" class="col-sm-2 col-form-label">내용</label>
        <div class="col-sm-10">
         <textarea style="height: 200px"  class="form-control" id="content" name="content"></textarea>
        </div>
    </div>
  </form>
  <!--// form end -->
  fileList:${fileList }
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</div>
<!--// container end ---------------------------------------------------------->
<script>
    var simplemde = new SimpleMDE({ element: document.getElementById("content")})
</script>

<%-- bootstrap js --%>
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.js"></script>
</body>
</html>