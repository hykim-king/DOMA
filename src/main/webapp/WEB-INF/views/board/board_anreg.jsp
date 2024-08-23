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
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>
<style>
html, body {
    height: 100%;
    margin: 0;
}

body {
    background-color: #f4f4f4;
    font-family: 'Nanum Gothic', sans-serif;
    color: #333;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

.container {
    flex-grow: 1; /* 남은 공간을 차지하도록 설정 */
    background-color: #f4f4f4;
    padding-bottom: 10px; /* 컨테이너와 푸터 사이의 간격 줄이기 */
}

footer {
    margin-top: -100px; /* 푸터가 위로 올라가도록 설정 */
    padding: 10px 0;
    background-color: #fff;
    border-top: 1px solid #ddd;
    text-align: center;
    width: 100%;
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
    const anSaveBtn = document.querySelector("#anSave");
    const moveToListBtn = document.querySelector("#moveToList");
    const titleInput = document.querySelector("#title");
    const userIdInput = document.querySelector("#userId");
    const contentsTextArea = document.getElementById("content");
    const divInput = document.querySelector("#div");
    const imgLinkInput = document.querySelector("#imgLink");
    const seqInput = document.querySelector("#seq");
    const modIdInput = document.querySelector("#modId");
    //구분
    const searchDivSelect = document.querySelector("#searchDiv");
    
    
//이벤트 처리=================================================================================================    
    
	//moveToListBtn
    moveToListBtn.addEventListener("click", function(event){
	    console.log("moveToListBtn click");
	    event.stopPropagation();
	
	    // 글쓰기를 취소하시겠습니까? 알림을 추가
	    if (confirm("글쓰기를 취소하시겠습니까?") === false) {
	        return;
	    }
	    
	    moveToList();
	});
	
	//등록
    anSaveBtn.addEventListener("click", function(event){
        console.log("doSaveBtn click");     
        anSave();
    });
	
    
    
//함수=================================================================================================    
    
	//moveToList()
    function moveToList() {
        window.location.href = "/doma/board/doRetrieveAn.do?div=" + divInput.value;
    }
    
    function moveToMain() {
        window.location.href = "/doma/board/anSelectOne.do?seq=" + seqInput.value + "div=" + divInput.value;
    }
	
	//doSave()
	function anSave(){
        console.log("AnSave()");
        
        if(isEmpty(titleInput.value) == true){
            alert('제목을 입력 하세요.')
            titleInput.focus();
            return;
        }
        
        if(isEmpty(contentsTextArea.value) == true){
            alert('내용을 입력 하세요.')
            contentsTextArea.focus();
            return;
        }
        
        if(confirm("등록 하시겠습니까?") === false)return;
        
        //비동기 통신
        let type = "GET";
        let url = "/doma/board/anSave.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
        	"seq" : seqInput.value,
            "title"    : titleInput.value,
            "userId"    : userIdInput.value,
            "modId"  : userIdInput.value,
            "content" : contentsTextArea.value,
            "div"      : divInput.value
        };

        PClass.pAjax(url, params, dataType, type, async, function(data){
            if(data){
                try{
                    //JSON문자열을 JSON Object로 변환
                    const message = JSON.parse(data)
                    if(isEmpty(message) === false && 1 === message.messageId){
                        moveToList();
                    }else{
                        alert(message.messageContents);
                    }
                    
                }catch(e){
                    alert("data를 확인 하세요");
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
  <br>   <br>   <br> 
  <!-- 제목 -->
  <div class="page-header mb-4">
      <h2>
        <c:choose>
            <c:when test="${ '10' == board.getDiv() }">커뮤니티-등록</c:when>
            <c:when test="${ '20' == board.getDiv() }">공지사항-등록</c:when>
            <c:otherwise>
                                 공지사항/자유게시판
            </c:otherwise>
        </c:choose>
      </h2>
  </div>
  <!--// 제목 end ------------------------------------------------------------->
  <!-- 버튼 -->
  <div class="mb-2 d-grid gap-2 d-md-flex justify-content-md-end">
      <input type="button" value="목록" id="moveToList" class="btn btn-outline-warning">
      <input type="button" value="등록"  id="anSave" class="btn btn-outline-warning">
  </div>
  <!--// 버튼 ----------------------------------------------------------------->
  <!-- form -->
  <form action="${CP}/board/fileUpload.do" method="post" enctype="multipart/form-data" class="form-horizontal">
    <input type="hidden" name="seq"    id="seq" value="${board.seq}">
    <input type="hidden" name="div" id="div" value="${board.getDiv() }">
    <input type="hidden" name="modId" id="modId" value="${board.modId}">
    <div class="row mb-2">
	    <label for="title" class="col-sm-2 col-form-label">제목</label>
	    <div class="col-sm-10">
	        <input type="text" class="form-control" name="title" id="title" value="[공지사항] " maxlength="75" required="required">
	    </div>
	</div>
    <div class="row mb-2">
        <label for="userId" class="col-sm-2 col-form-label">등록자</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${user.userId}'/>" class="form-control readonly-input" readonly="readonly" name="userId" id="userId"  maxlength="20" required="required">
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
 
</div>
<!--// container end ---------------------------------------------------------->

<%-- bootstrap js --%>
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>