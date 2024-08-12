<%--
/**
	Class Name: board_list.jsp
	Description:
	Author: acorn
	Modification information
	
	수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 8. 2        최초작성 
    
    DOMA 개발팀
    since 2020.11.23
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@page import="com.acorn.doma.domain.User"%>
<%@ page import="com.acorn.doma.cmn.StringUtil"%>
<%@ page import="com.acorn.doma.cmn.Search"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
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

<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css"> 
<link rel="stylesheet" href="${CP }/resources/css/bootstrap/simplemde.min.css">
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<title>DOMA 커뮤니티</title>
<style> 
.boardTable {
        border: 1px #a39485 solid;
        font-size: .9em;
        box-shadow: 0 2px 5px rgba(0,0,0,.25);
        width: 90%;
        border-collapse: collapse;
        border-radius: 5px;
        overflow: hidden;
        margin-bottom: 30px; /* 두 테이블 사이에 간격을 추가 */
    }

    /* 두 번째 테이블의 상단에 간격 추가 */
    .secondTableContainer {
        margin-left: 20px; 
       width: 10%;
    }

    /* 나머지 CSS 스타일 그대로 유지 */
    th {
        text-align: left;
    }

    thead {
        font-weight: bold;
        color: #fff;
        background: #000000;
    }

    td, th {
        padding: 1em .5em;
        vertical-align: middle;
    }

    td {
        border-bottom: 1px solid rgba(0,0,0,.1);
        background: #fff;
    }

    a {
        color: #73685d;
    }

    @media all and (max-width: 768px) {
        table, thead, tbody, th, td, tr {
            display: block;
        }

        th {
            text-align: right;
        }

        table {
            position: relative; 
            padding-bottom: 0;
            border: none;
            box-shadow: 0 0 10px rgba(0,0,0,.2);
        }

        thead {
            float: left;
            white-space: nowrap;
        }

        tbody {
            overflow-x: auto;
            overflow-y: hidden;
            position: relative;
            white-space: nowrap;
        }

        tr {
            display: inline-block;
            vertical-align: top;
        }

        th {
            border-bottom: 1px solid #a39485;
        }

        td {
            border-bottom: 1px solid #e5e5e5;
        }
    }
</style> 

<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");
//객체 생성=================================================================================================       
	//조회버튼
    const doRetrieveBtn = document.querySelector("#doRetrieve");
    console.log("doRetrieveBtn:", doRetrieveBtn);
    //등록
    const moveToRegBtn = document.querySelector("#moveToReg");
    console.log("moveToRegBtn:", moveToRegBtn);
    //등록시 파일업로드로
    const fileUploadgBtn = document.querySelector("#fileUpload");
    //검색어
    const searchWordInput = document.querySelector("#searchWord");
    //구분
    const searchDivSelect = document.querySelector("#searchDiv");
    //페이지사이즈
    const pageSizeSelect = document.querySelector("#pageSize");
    
    const gangNamInput = document.querySelector("#gangNam");
    
    <%-- // JSP에서 userId 값을 JavaScript 변수로 설정
    const userId = "<%= (userId != null && !userId.isEmpty()) ? userId : "" %>";
    
    console.log("checkSessionAndMove: userId = " + userId); --%>
	
//이벤트 처리=================================================================================================  
    
	//등록 이동 버튼
	moveToRegBtn.addEventListener("click",function(event){
	    console.log("moveToRegBtn click");
	    moveToReg();
    });;
	
	//구분
    searchDivSelect.addEventListener("change",function(event){
        if("" === searchDivSelect.value){
            searchWordInput.value = "";//검색어
            pageSizeSelect.value  = 10;//페이지 사이즈
        }
    });
	
    //검색어(엔터키 이벤트)
    searchWordInput.addEventListener("keydown",function(event){
        console.log("searchWordInput keydown");
        if(event.key === 'Enter' && event.keyCode === 13){
            event.stopPropagation();
            doRetrieve(1);
        }
    });
	
    //조회버튼
    doRetrieveBtn.addEventListener("click",function(event){
        console.log("doRetrieveBtn click");
        event.stopPropagation();
        doRetrieve(1);
    });
    
    gangNamInput.addEventListener("click",function(event){
        console.log("doRetrieveBtn click");
        event.stopPropagation();
        doRetrieve(1);
    });
	
       
});   
//함수=================================================================================================  
	// checkSessionAndMove()
    function checkSessionAndMove() {
        console.log("checkSessionAndMove: userId = " + userId);
           
        if (userId !== "" && userId !== " ") {
            moveToReg(); // 세션이 존재하면 등록 페이지로 이동
        } else {
            alert("로그인이 필요합니다.");
            window.location.href = "/doma/user/loginPage.do"; // 세션이 없으면 로그인 페이지로 리다이렉트
        }
    }
	
	//moveToReg()
    function moveToReg(){
        const frm = document.querySelector("#boardForm");
        //frm.pageNo.value = 1;
        frm.action = "/doma/board/moveToReg.do";
        frm.submit();
    }
    
	//doSelectOne()
	function doSelectOne(seq){
	    console.log("doSelectOne seq:"+seq);
        //div
        //seq
        //등록자 정보
        
        const frm = document.querySelector("#boardForm");
        let div = frm.div.value;
        
        window.location.href = "/doma/board/doSelectOne.do?seq="+seq+"&div="+div;
           
    }
	
	//pageRetrieve
	function pageRetrieve(url, pageNo){
	    console.log("pageRetrieve()");
        const frm      = document.querySelector("#boardForm");
        let searchDiv  = frm.searchDiv.value;
        let searchWord = frm.searchWord.value;
        let pageSize   = frm.pageSize.value;
        frm.pageNo.value = pageNo;
        let div  = frm.div.value;
        console.log("searchDiv:"+searchDiv);
        console.log("searchWord:"+searchWord);
        console.log("pageSize:"+pageSize);
        console.log("pageNo:"+pageNo);
        console.log("div:"+div);
        console.log("url:"+url);
        
        frm.action = url;
        frm.submit();
    }
	
	//doRetrieve()
	function doRetrieve(pageNo){
	    console.log("doRetrieve()");
        const frm      = document.querySelector("#boardForm");
        let searchDiv  = frm.searchDiv.value;
        let searchWord = frm.searchWord.value;
        let pageSize   = frm.pageSize.value;
        let searchGu   = frm.searchGu.value;
        frm.pageNo.value = pageNo;
        let div  = frm.div.value;
        frm.div.value = "10";
        console.log("searchDiv:"+searchDiv);
        console.log("searchWord:"+searchWord);
        console.log("pageSize:"+pageSize);
        console.log("pageNo:"+pageNo);
        console.log("searchGu:"+searchGu);
        console.log("div:"+div);
        
        frm.action = "/doma/board/doRetrieve.do";
        frm.submit();
     }
	
	
	
</script>

</head>
<body>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
user : ${user}
<!-- container -->
<div class="container"> 
        <!-- 제목 -->
		<div class="page-header  mb-4">
		  <h2>
		      <c:choose>
		         <c:when test="${ '10'== search.getDiv() }">커뮤니티</c:when>
		         <c:when test="${ '20'== search.getDiv() }">공지사항</c:when>
		         <c:otherwise>
		                              공지사항/자유게시판
		         </c:otherwise>
		     </c:choose>
		  </h2>
		</div> 
		<!--// 제목 end ------------------------------------------------------------->
        <!-- 버튼 -->
        <div class="form-buttons" style="margin : 20px 0px 10px 30px" >
            <input type="button" value="글쓰기" id="moveToReg" class="btn btn-dark">
            <input type="button" value="조회" id="doRetrieve" class="btn btn-dark" >
        </div>
        <!-- //버튼 -------------------------------------------------------------------->
        
        <!-- 검색 -->
        <form action="#" name="boardForm" class="row g-2 align-items-center" id="boardForm">
	        <input type="hidden" name="div"    id="div" value="${search.getDiv() }">
	        <input type="hidden" name="pageNo" id="pageNo" value="${search.pageNo}">
	        <div class="col-sm-3">
	        </div>
	        <div class="col-sm-2 text-end g-2">
	        </div>
	        <div class="col-sm-1">
                <select name="searchDiv" class="form-select" id="searchDiv">
                    <option value="">전체</option>
                    <c:forEach var="item" items="${BOARD_SEARCH}">
                       <option value="${item.detCode}"  <c:if test="${item.detCode == search.searchDiv }">selected</c:if>    >${ item.detNm}</option>
                    </c:forEach>
                </select>
            </div>
	        <div class="col-sm-1">
	        <select name="searchGu" class="form-select" id="searchGu">
	            <option value="">구 선택</option>
	            <c:forEach var="item" items="${GNAME}">
	                <option value="${item.detCode}" <c:if test="${item.detCode == search.searchGu}">selected</c:if>>${item.detNm}</option>
	            </c:forEach>
	        </select>
	    </div>
	        <div class="col-sm-4">
	            <input type="search" name="searchWord" class="form-control" id="searchWord"
	             value="${search.searchWord }"
	             placeholder="검색어">
	        </div>
	        <div class="col-sm-1">
            <select name="pageSize" id="pageSize" class="form-select">
                <c:forEach var="item" items="${COM_PAGE_SIZE }">
                   <option value="${item.detCode}"   <c:if test="${item.detCode == search.pageSize }">selected</c:if> >${ item.detNm}</option>
                </c:forEach>
            </select>
            </div>
	    </form>
        <!-- //검색 --------------------------------------------------------------------->
        
        <div class="d-flex m-2">
            <!-- table -->
		      <table  class="boardTable">
		      <thead >
		        <tr  >
		          <th class="text-center col-sm-1">no</th>
		          <th class="text-center col-sm-1">구</th>
		          <th class="text-center col-sm-5">제목</th>
		          <th class="text-center col-sm-2">등록자</th>
		          <th class="text-center col-sm-2">등록일</th>
		          <th class="text-center col-sm-1">조회수</th>
		          <th class="text-center col-sm-1 d-none">SEQ</th>
		        </tr>
		      </thead>
		      <tbody>
		          <c:choose>
		            <c:when test="${list.size() > 0 }">
		              <c:forEach var="vo" items="${list }">
		                  <tr>
		                    <td class="text-center" ><c:out value="${vo.no }"></c:out></td>
		                    <td class="text-center" ><c:out value="${vo.gname }"></c:out></td>
		                    <td class="text-left" >
		                      <a href="/doma/main/boardInfo.do?seq=${vo.seq }&div=${vo.getDiv() }"><c:out value="${vo.title }"></c:out></a>
		                    </td>
		                    <td class="text-center" ><c:out value="${vo.modId }"></c:out></td>
		                    <td class="text-center" ><c:out value="${vo.modDt }"></c:out></td>
		                    <td class="text-end" ><c:out value="${vo.views }"></c:out></td>
		                    <td class="text-center d-none" ><c:out value="${vo.seq }"></c:out></td>
		                  </tr>
		              </c:forEach>
		            </c:when>
		            <c:otherwise>
		                <tr><td class="text-center" colspan="99" >No data found!</td></tr>
		            </c:otherwise>
		          </c:choose>
		      </tbody>
		    </table>
		    <!--// table end ------------------------------------------------------------->
            <div class="secondTableContainer">
                <div class="grid gap-0 column-gap-6">
                    <table class="boardTable">
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="강남구" id="gangNam" name="gangNam" class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="강동구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="강북구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="강서구"  class="btn btn-outline-secondary"></td>
                        </tr>
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="관악구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="광진구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="구로구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="금천구"  class="btn btn-outline-secondary"></td>
                        </tr>
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="노원구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="도봉구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="동대문구" class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="동작구"  class="btn btn-outline-secondary"></td>
                        </tr>
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="마포구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="서대문구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="서초구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="성동구"  class="btn btn-outline-secondary"></td>
                        </tr>
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="성북구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="송파구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="양천구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="영등포구"  class="btn btn-outline-secondary"></td>
                        </tr>
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="용산구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="은평구" class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="종로구"  class="btn btn-outline-secondary"></td>
                            <td class="p-2 g-col-8"><input type="button" value="중구"  class="btn btn-outline-secondary"></td>
                        </tr>
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="중랑구"  class="btn btn-outline-secondary"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
  <!-- pagenation -->
  <div class="text-center">
    <div id="page-selection" class="text-center page">
    <%
    //총글수 :
    int totalCnt = (Integer) request.getAttribute("totalCnt");
    
    Search search = (Search) request.getAttribute("search");
    
    //페이지 번호
    int pageNo = search.getPageNo();
    
    //페이지 사이즈
    int pageSize = search.getPageSize();
    
    //바닥글
    int bottomCount = search.BOTTOM_COUNT;
    
    String url = "/doma/board/doRetrieve.do";
    String scriptName = "pageRetrieve";
    
    %>
    <%= StringUtil.renderingPaging(totalCnt, pageNo, pageSize, bottomCount, url, scriptName) %>
    </div>
  </div> 
  <!-- //pagenation ----------------------------------------------------------->    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</div>
<!--// container end ---------------------------------------------------------->
    <%--bootstrap js --%>
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.js"></script> 
</body>
</html>