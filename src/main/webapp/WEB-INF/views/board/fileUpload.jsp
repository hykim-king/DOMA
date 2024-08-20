<%--
/**
    Class Name: reg.jsp
    Description: 부트스트랩 template
    Author: acorn
    Modification information
    
    수정일                    수정자      수정내용
    -----        -----  -------------------------------------------
    2024. 7. 18         최초작성 
    
    
    author eclass 개발팀
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

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script> 

<%-- google Nanum+Gothic --%>
<link rel="stylesheet"  href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<title>DOMA</title>
</head>
<body>
<!-- container -->
<div class="container">
  
  <!-- 제목 -->
  <div class="page-header">
    <h2>파일 업로드</h2>
  </div>
  <!--// 제목 end ------------------------------------------------------------->
  
  <!-- 버튼 -->
  <div class="mb-2 d-grid gap-2 d-md-flex justify-content-md-end">
      
  </div>
  <!--// 버튼 ----------------------------------------------------------------->
  
  <!-- form -->
  <form action="${CP}/file/fileUpload.do" method="post" enctype="multipart/form-data" class="form-horizontal">
    <div class="row mb-2">
        <label for="title" class="col-sm-2 col-form-label">제목</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" name="title" id="title"  maxlength="75" required="required">
        </div>      
    </div>
    <div class="row mb-2">
        <label for="imgLink" class="col-sm-2 col-form-label">파일1</label>
        <div class="col-sm-10">
          <input type="file" class="form-control" name="imgLink" id="imgLink">        
        </div>        
    </div> 
    <div class="row mb-2">
        <label for="imgLink" class="col-sm-2 col-form-label">파일2</label>
        <div class="col-sm-10">
          <input type="file" class="form-control" name=imgLink id="imgLink">        
        </div>        
    </div>           
    <div class="row mb-2"">
        <label for="content" class="col-sm-2 col-form-label">내용</label>
        <div class="col-sm-10">    
         <textarea style="height: 200px"  class="form-control" id="content" name="content"></textarea>
        </div> 
    </div>    
    <div class="row mb-2"">
        <label for="regId" class="col-sm-2 col-form-label"></label>
        <div class="col-sm-10">    
         <input type="submit" value="전송" class="btn btn-primary">
        </div> 
    </div>    
  </form>
  fileList:${fileList }
  <!--// form end -->
</div>
<!--// container end ---------------------------------------------------------->
<%-- bootstrap js --%>
<script src="${CP}/resources/js/bootstrap.bundle.js"></script> 
</body>
</html>