<%--
/**
    Class Name: 
    Description:
    Author: acorn
    Modification information
    
    수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 7. 30        최초작성 
    
    DOMA 개발팀
    since 2020.11.23
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@page import="com.acorn.doma.domain.User"%>
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
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script>

<%-- google Nanum+Gothic --%>
<link rel="stylesheet"  href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- simplemde -->
<link rel="stylesheet" href="${CP }/resources/css/bootstrap/simplemde.min.css">

<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>

<style>
    .readonly-input {
        background-color: #e9ecef;
    }
</style>

<title>DOMA</title>
<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");
//객체 생성=================================================================================================    
    //moveToList : 목록으로 이동
      
    //doUpdate : 수정
    const doUpdateBtn = document.querySelector("#doUpdate");
    
    //seq
    const seqInput = document.querySelector("#seq");
    
    //div
    const divInput = document.querySelector("#div");
    
    //구이름
    const gnameInput = document.querySelector("#gname");
    
    //제목
    const titleInput = document.querySelector("#title");
    
    //이미지
    const imgLinkInput = document.querySelector("#imgLink");
    
    //내용
    const contentsTextArea = document.getElementById("content");
    
    //구분
    const searchDivSelect = document.querySelector("#searchDiv");
    
    const userId = document.querySelector("userId");
    
    const modIdInput = document.querySelector("#modId");
    const userIdInput = document.querySelector("#userId");
    
    //파일 업로드
    const form = document.querySelector("form");
    const fileInput = document.querySelector("input[type='file']");
    const fileNameInput = document.querySelector("#fileName");
    

//이벤트 처리=================================================================================================
  
    
    //doUpdate : 수정
    doUpdateBtn.addEventListener("click",function(event){
        console.log("doUpdateBtn click");
        event.stopPropagation();
        doUpdate();
    });
    
     
    
//함수=================================================================================================
    
    function MoveBoard(userId){ 
        //frm.pageNo.value = 1; 
       //window.location.href = "/doma/doma/mpSelect.do?userId="+userId;
       window.location.href = '/doma/mypage/mpSelect.do?userId='+userIdInput.value;
       // 팝업 창으로 열기
       //window.open('/doma/mypage/mpSelect.do?userId=' + userIdInput.value, 'popupWindow', 'width=600,height=400,scrollbars=yes');
 
		}
	
	
	
	//doUpdate : 수정
    function doUpdate() {
        console.log("doUpdate()");

        if (isEmpty(titleInput.value) == true) {
            alert('제목을 입력 하세요.');
            titleInput.focus();
            return;
        }

        if (isEmpty(contentsTextArea.value)) {
            alert('내용을 입력 하세요.');
            contentsTextArea.focus();
            return;
        }

        if (confirm("수정 하시겠습니까?") === false) return;

        if (imgLinkInput.files.length === 0) {
            doUpdate();
            return;
        }
        // FormData 객체 생성
        let formData = new FormData();
        formData.append("seq", seqInput.value);
        formData.append("div", divInput.value);
        formData.append("gname", searchDivSelect.value);
        formData.append("title", titleInput.value);
        formData.append("userId", userIdInput.value);
        formData.append("modId", modIdInput.value);
        formData.append("content", contentsTextArea.value);
        formData.append("imgFile", imgLinkInput.files[0]);  // file이 서버에서 받는 MultipartFile의 키와 일치

        if (fileInput.files.length > 0) {
            formData.append("imgFile", imgLinkInput.files[0]);
        }

        $.ajax({
            url: "/doma/mypage/mpBoardUp.do",
            type: "POST",
            data: formData,
            processData: false,  // FormData가 자동으로 처리되지 않도록 설정
            contentType: false,  // 콘텐츠 타입을 자동으로 설정하지 않도록 설정
            success: function(data) {
                console.log("서버 응답 데이터:", data);  // 응답 데이터를 직접 확인

                if (data) {
                    try {
                        // JSON 문자열을 JSON 객체로 변환
                        const message = JSON.parse(data);
                        if (message && message.messageId === 1) {
                            alert(message.messageContents);
                            location.reload();
                            window.close(); // 수정이 완료되면 창을 닫습니다.
                        }
                    } catch (e) {
                        console.error(e);
                    }
                }
            }
        });
    }

    
     
});    
</script>
</head>
<body>  
<!-- container -->
<div class="container">
  <!-- 제목 -->
  <div class="page-header  mb-4">
  <br>
    <h2> 게시글 수정하기 </h2>
    <hr>
  </div> 
  <!--// 제목 end ------------------------------------------------------------->
  
  <!-- 버튼 -->
  <div class="mb-2 d-grid gap-2 d-md-flex justify-content-md-end"> 
      <input type="button" value="수정"  id="doUpdate" class="btn btn-primary"> 
  </div>
  <!--// 버튼 ----------------------------------------------------------------->
  <!-- form -->
  <form action="#" class="form-horizontal"  name="regForm" id="regForm">
    <input type="hidden" name="seq"    id="seq" value="${board.seq}">
    <input type="hidden" name="div"    id="div" value="${board.getDiv()}">
    <input type="hidden" name="modId"    id="modId" value="${board.modId}"> 
    <%-- <div class="row mb-2">
        <label for="seq" class="col-sm-2 col-form-label">seq</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.seq}'/>" class="form-control readonly-input" readonly="readonly" name="seq" id="seq"  maxlength="20" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="div" class="col-sm-2 col-form-label">div</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.getDiv()}'/>" class="form-control readonly-input" readonly="readonly" name="div" id="div"  maxlength="20" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="views" class="col-sm-2 col-form-label">조회수</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.views}'/>" class="form-control readonly-input" readonly="readonly" name="views" id="views">
        </div>
    </div> --%>
    
    <div class="row mb-2">
	    <label for="searchDiv" class="col-sm-2 col-form-label">구 이름</label>
	    <div class="col-sm-10">
	        <input type="text" value="<c:out value='${board.gname}'/>" class="form-control readonly-input" readonly="readonly" name="searchDiv" id="searchDiv">
	         
	    </div>
	</div>
    <div class="row mb-2">
        <label for="modId" class="col-sm-2 col-form-label">등록자</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.userId}'/>" class="form-control readonly-input" readonly="readonly" name="userId" id="userId"  maxlength="20" required="required">
        </div>
    </div> 
     <div class="row mb-2">
        <label for="imgLink" class="col-sm-2 col-form-label">이미지 링크</label>
        <div class="col-sm-10">
          <input type="file" multiple class="form-control" name="fileName" id="imgLink">        
        </div>        
    </div>

    <div class="row mb-2">
        <label for="title" class="col-sm-2 col-form-label">제목</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.title}'/>" class="form-control" name="title" id="title"  maxlength="75" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="content" class="col-sm-2 col-form-label">내용</label>
         <div class="col-sm-10">
         <textarea style="height: 200px" class="form-control" id="content" name="content">
    	<c:out value="${board.content}"/>
		</textarea>
		</div>
    </div>
  </form>
  <!--// form end -->
 
</div>
<!--// container end ---------------------------------------------------------->
 

<%-- bootstrap js --%>
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.js"></script> 
</body>
</html>