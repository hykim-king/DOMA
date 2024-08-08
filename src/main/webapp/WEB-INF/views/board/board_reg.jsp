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

<title>오늘 사람 프로그램</title>
<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");
//객체 생성=================================================================================================    
    const doSaveBtn = document.querySelector("#doSave");
    const moveToListBtn = document.querySelector("#moveToList");
    const titleInput = document.querySelector("#title");
    const userIdInput = document.querySelector("#userId");
    const contentsTextArea = document.querySelector("#content");
    const divInput = document.querySelector("#div");
    
//이벤트 처리=================================================================================================    
    
	//moveToListBtn
    moveToListBtn.addEventListener("click",function(event){
        console.log("moveToListBtn click");
        event.stopPropagation();
        if(confirm("목록 으로 이동 하시겠습니까?") === false)return;
        moveToList();
    });
	
	//등록
    doSaveBtn.addEventListener("click", function(event){
        console.log("doSaveBtn click");     
        doSave();
    });
    
//함수=================================================================================================    
    
	//moveToList()
    function moveToList() {
        window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
    }
	
	//doSave()
	function doSave(){
        console.log("doSave()");
        
        if(isEmpty(titleInput.value) == true){
            alert('아이디를 입력 하세요.')
            titleInput.focus();
            return;
            
        }
        
        if(isEmpty(userIdInput.value) == true){
            alert('등록자 아이디를 입력 하세요.')
            userIdInput.focus();
            return;
        }
        
        if(isEmpty(simplemde.value()) == true){
            alert('내용을 입력 하세요.')
            contentsTextArea.focus();
            return;
        }
        
        console.log("simplemde", simplemde.value());
        if(confirm("등록 하시겠습니까?") === false)return;
        
        //비동기 통신
        let type = "POST";
        let url = "/doma/board/doSave.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
            "title"    : titleInput.value,
            "userId"    : userIdInput.value,
            "content" : simplemde.value(),
            "div"      : divInput.value
        };

        PClass.pAjax(url, params, dataType, type, async, function(data){
            if(data){
                try{
                    //JSON문자열을 JSON Object로 변환
                    const message = JSON.parse(data)
                    if(isEmpty(message) === false && 1 === message.messageId){
                        alert(message.messageContents);
                        window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
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
  <!-- 제목 -->
  <div class="page-header">
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
      <input type="button" value="목록" id="moveToList" class="btn btn-primary">
      <input type="button" value="등록"  id="doSave" class="btn btn-primary">
  </div>
  <!--// 버튼 ----------------------------------------------------------------->
  <!-- form -->
  <form action="#" class="form-horizontal"  name="regForm" id="regForm">
    <input type="hidden" name="div" id="div" value="${board.getDiv() }">
    <div class="row mb-2">
        <label for="title" class="col-sm-2 col-form-label">제목</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" name="title" id="title"  maxlength="75" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="userId" class="col-sm-2 col-form-label">등록자</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" name="userId" id="userId"  maxlength="20" required="required">
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
<script>
    var simplemde = new SimpleMDE({ element: document.getElementById("content")})
</script>

<%-- bootstrap js --%>
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.js"></script>
</body>
</html>