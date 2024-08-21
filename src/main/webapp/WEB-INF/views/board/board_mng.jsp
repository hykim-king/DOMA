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
<%@ include file="/WEB-INF/views/template/header.jsp" %>

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

<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css"> 
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>

 
<style>
body {
    font-family: 'Nanum Gothic', sans-serif;
    color: #333;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

header, footer {
    background-color: #fff;
    border-bottom: 1px solid #ddd;
}

.post {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    height: 350px;
}

.post-title {
    font-weight: bold;
    font-size: 24px;
    color: #333;
    margin-top: 5px;
}

.post-content {
    font-size: 16px;
    color: #555;
}

.post-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.post-author {
    margin: 0;
    font-size: 14px;
    color: #555;
}

.post-date {
    margin: 0;
    font-size: 14px;
    color: #777;
}

.comments {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.comment-form {
    margin-bottom: 20px;
}

.comment-form label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.comment-form textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

.comment-form button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 10px;
}

.comment-form button:hover {
    background-color: #0056b3;
}

.comment-list {
    margin-top: 20px;
}

.comment {
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
}

.comment p {
    margin: 0;
}

.comment strong {
    color: #007bff;
}
</style>

<title>DOMA</title>
<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");
//객체 생성=================================================================================================    
    //moveToMainBtn : 뒤로 이동
    const moveToMainBtn = document.querySelector("#moveToMain");
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
    
    const modIdInput = document.querySelector("#modId");
    const userIdInput = document.querySelector("#userId");
    
    //파일 업로드
    const form = document.querySelector("form");
    const fileInput = document.querySelector("input[type='file']");
    const fileNameInput = document.querySelector("#fileName");
    

//이벤트 처리=================================================================================================
    //moveToMainBtn
    moveToMainBtn.addEventListener("click",function(event){
        console.log("moveToMainBtn click");
        event.stopPropagation();
        if(confirm("수정을 취소 하시겠습니까?") === false)return;
        moveToMain();
    });
    
    //doUpdate : 수정
    doUpdateBtn.addEventListener("click",function(event){
        console.log("doUpdateBtn click");
        event.stopPropagation();
        doUpdate();
    });
    
    
//함수=================================================================================================
    //doUpdate()
	function doUpdate(){
        
        console.log("doUpdate()");
        
        console.log("seqInput : " + seqInput);
        console.log("seqInput : " + seqInput.value);
        console.log("searchDivSelect", searchDivSelect.value);
        console.log("divInput : " + divInput.value);
        console.log("titleInput : " + titleInput.value);
        console.log("userIdInput : " + userIdInput.value);
        console.log("modIdInput : " + modIdInput.value);
        console.log("imgLinkInput.files[0]", imgLinkInput.files[0]);
        console.log("simplemde", contentsTextArea.value);
        
        if(isEmpty(titleInput.value) == true){
            alert('제목을 입력 하세요.')
            titleInput.focus();
            return;
        }
        
        if(isEmpty(imgLinkInput.files[0]) == true){
            alert('사진을 선택 하세요.')
            imgLinkInput.focus();
            return;
        }
        
        //marker : simplemde.value()
        if(isEmpty(contentsTextArea.value) == true){
            alert('내용을 입력 하세요.')
            contentsTextArea.focus();
            return;
        }
        
        if(confirm("수정 하시겠습니까?") === false)return;
        
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
            url: "/doma/board/fileUpdate.do",
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
                            moveToMain();
                        } else {
                            alert(message.messageContents);
                        }
                    } catch (e) {
                        alert("데이터를 확인 하세요");
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error("요청 실패: " + status + ", " + error);
                alert("요청 처리 중 오류가 발생했습니다.");
            }
        });
    }     
	
    function moveToMain() {
        window.location.href = "/doma/board/boardInfo.do?seq=" + seqInput.value +"&div=" + divInput.value;
    }
    
});    
</script>
</head>
<body>
<!-- container -->
<div class="container">
  <!-- 제목 -->
  <div class="page-header  mb-4">
    <h2>
        <c:choose>
           <c:when test="${ '10'== board.getDiv() }">커뮤니티</c:when>
           <c:when test="${ '20'== board.getDiv() }">공지사항</c:when>
           <c:otherwise>
                                공지사항/자유게시판
           </c:otherwise>
       </c:choose>
    </h2>
  </div> 
  <!--// 제목 end ------------------------------------------------------------->
  
  <!-- 버튼 -->
  <div class="mb-2 d-grid gap-2 d-md-flex justify-content-md-end">
      <input type="button" value="뒤로가기"  id="moveToMain" class="btn btn-outline-warning">
      <input type="button" value="수정"  id="doUpdate" class="btn btn-outline-warning">
  </div>
  <!--// 버튼 ----------------------------------------------------------------->
  <!-- form -->
  <form action="${CP}/board/fileUpload.do" class="form-horizontal"  name="mngForm" id="mngForm" action="${CP}/file/fileUpload.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="seq"    id="seq" value="${board.seq}">
    <input type="hidden" name="div"    id="div" value="${board.getDiv()}">
    <input type="hidden" name="modId"    id="modId" value="${board.modId}">
    
    <div class="row mb-2">
	    <label for="searchDiv" class="col-sm-2 col-form-label">구 이름</label>
	    <div class="col-sm-10">
	        <input type="text" value="<c:out value='${moveUp.gname}'/>" class="form-control readonly-input" readonly="readonly" name="searchDiv" id="searchDiv">
	        <select name="searchDiv" class="form-select" id="selectDiv" onchange="document.getElementById('searchDiv').value=this.options[this.selectedIndex].text">
	            <option value="">구 선택</option>
	            <c:forEach var="item" items="${GNAME}">
	                <option value="${item.detCode}" <c:if test="${item.detCode == search.searchDiv }">selected</c:if>>${item.detNm}</option>
	            </c:forEach>
	        </select>
	    </div>
	</div>
	<div class="row mb-2">
        <label for="userId" class="col-sm-2 col-form-label">등록자</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${moveUp.userId}'/>" class="form-control readonly-input" readonly="readonly" name="userId" id="userId"  maxlength="20" required="required">
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
	        <input type="text" value="<c:out value='${moveUp.title}'/>" class="form-control" name="title" id="title" maxlength="75" required="required">
	    </div>
	</div>
	<div class="row mb-2">
	    <label for="content" class="col-sm-2 col-form-label">내용</label>
	    <div class="col-sm-10">
	        <textarea style="height: 200px" class="form-control" id="content" name="content"><c:out value='${moveUp.content}'></c:out></textarea>
	    </div>
	</div>
  </form>
  <!--// form end -->
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