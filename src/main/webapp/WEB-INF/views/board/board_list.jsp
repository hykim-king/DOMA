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
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<%

    User outVO = (User) session.getAttribute("user");
    String userId = (outVO != null) ? outVO.getUserId() : "";
    
%> 
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- favicon  --%>
<link rel="shortcut icon" href="${CP}/resources/img/pcon.png" type="image/x-icon">

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script>
 

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- simplemde -->

<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css"> 
<link rel="stylesheet" href="${CP }/resources/css/bootstrap/simplemde.min.css">
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<title>DOMA</title>
<style> 
h2 {
    font-size: 30px;
    font-weight: 500px;
    letter-spacing: 0;
    line-height: 1.5em;
    padding-bottom: 15px;
    position: relative;
    margin-left: 10px;
}

h2:before {
    content: "";
    position: absolute;
    left: 0;
    bottom: 0;
    height: 5px;
    width: 55px;
    background-color: #111;
}

h2:after {
    content: "";
    position: absolute;
    left: 0;
    bottom: 2px;
    height: 1px;
    width: 95%;
    max-width: 255px;
    background-color: #333;
}
.boardTable {
 		 font-family: 'Gowun Dodum', sans-serif;
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
    	 font-family: 'Gowun Dodum', sans-serif;
        margin-left: 20px; 
       	width: 10%;
    }

    /* 나머지 CSS 스타일 그대로 유지 */
    th {
     	 font-family: 'Gowun Dodum', sans-serif;
        text-align: left;
    }

    thead {
     	 font-family: 'Gowun Dodum', sans-serif;
        font-weight: bold;
        color: #fff;
        background: #000000;
    }

    .boardTable td, th {
     	 font-family: 'Gowun Dodum', sans-serif;
        padding: 1em .5em;
        vertical-align: middle;
    }

    td {
     	 font-family: 'Gowun Dodum', sans-serif;
        background: #fff;
    }

    a {
      font-family: 'Gowun Dodum', sans-serif;
        color: #73685d;
    }

    @media all and (max-width: 768px) {
        table, thead, tbody, th, td, tr {
         font-family: 'Gowun Dodum', sans-serif;
            display: block;
           
        }

        th {
          font-family: 'Gowun Dodum', sans-serif;
            text-align: right;
        }

        table {
         	 font-family: 'Gowun Dodum', sans-serif;
            position: relative; 
            padding-bottom: 0;
            border: none;
            box-shadow: 0 0 10px rgba(0,0,0,.2);
        }

        thead {
          font-family: 'Gowun Dodum', sans-serif;
            float: left;
            white-space: nowrap;
        }

        tbody {
       font-family: 'Gowun Dodum', sans-serif;
            overflow-x: auto;
            overflow-y: hidden;
            position: relative;
            white-space: nowrap;
        }

        tr {
         font-family: 'Gowun Dodum', sans-serif;
            display: inline-block;
            vertical-align: top;
        }

        th {
         	 font-family: 'Gowun Dodum', sans-serif;
            border-bottom: 1px solid #a39485;
        }

        td {
         	 font-family: 'Gowun Dodum', sans-serif;
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
    
    const div = document.querySelector("#div");
    
    // 구 선택 드롭다운
    const searchGuSelect = document.querySelector("#searchGu");
    
    // 구 버튼들
    const guButtons = document.querySelectorAll("input[type='button'][name='gu']");
    
    const resetBtn = document.querySelector("#reset");
	
//이벤트 처리=================================================================================================  
    
	//등록 이동 버튼
    moveToRegBtn.addEventListener("click",function(event){
        console.log("moveToRegBtn click");
        checkSessionAndMove();
    });;
    
	//resetBtn
	resetBtn.addEventListener("click",function(event){
        console.log("resetBtn click");
        event.stopPropagation();
        reset();
    });
	
	
	// 구 버튼 클릭 시 해당 값을 드롭다운에 설정
	guButtons.forEach(button => {
	    button.addEventListener("click", function(event){
	        const gname = button.getAttribute("data-gname");
	        console.log("Selected gname: ", gname);
	        
	        // 드롭다운에서 해당 gname 값을 찾아서 선택
	        for (let option of searchGuSelect.options) {
	            if (option.text === gname) {
	                option.selected = true;
	                break;
	            }
	        }
	        doRetrieve(1);
	    });
	});

	
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
    
       
});   
//함수=================================================================================================  
	
	//checkSessionAndMove()
	function checkSessionAndMove() {
		// JSP에서 userId 값을 JavaScript 변수로 설정
	    const userId = "<%= (userId != null && !userId.isEmpty()) ? userId : "" %>";
	    
	    //userId값 확인
	    console.log("checkSessionAndMove: userId = " + userId); 
	
		if (userId !== "" && userId !== " ") {
			moveToReg();
		}else {
			alert("로그인이 필요합니다.");
			window.location.href = "/doma/user/loginPage.do";
		}
    }
	
	//moveToReg()
    function moveToReg(){
        const frm = document.querySelector("#boardForm");
        //frm.pageNo.value = 1;
        frm.action = "/doma/board/moveToReg.do";
        frm.submit();
    }
	
	function reset() {
        window.location.href = "/doma/board/doRetrieve.do?div=10";
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

 
<!-- container -->
<br>
<div class="container"> 
        <!-- 제목 -->
		<div class="page-header mb-4">
	    <h2 style="font-family: 'Gowun Dodum', sans-serif;">
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
        <div class="form-buttons" style="margin : 9px -168px 1px 23px" >
            <input type="button" value="글쓰기" id="moveToReg" class="btn btn-dark">
            <input type="button" value="조회" id="doRetrieve" class="btn btn-dark" >
        </div>
        <!-- //버튼 -------------------------------------------------------------------->
        
        <!-- 검색 -->
        <form action="#" name="boardForm" class="row g-2 align-items-center" id="boardForm" style="margin : 4px -168px 6px 23px">
	        <input type="hidden" name="div"    id="div" value="${search.getDiv() }">
	        <input type="hidden" name="pageNo" id="pageNo" value="${search.pageNo}">
	        <div class="col-sm-3">
	        </div>
	        <div class="col-sm-2 text-end g-2">
	        </div>
	        <div class="col-sm-2">
                <select name="searchDiv" class="form-select" id="searchDiv">
                    <option value="">구분</option>
                    <c:forEach var="item" items="${BOARD_SEARCH}">
                       <option value="${item.detCode}"  <c:if test="${item.detCode == search.searchDiv }">selected</c:if>    >${ item.detNm}</option>
                    </c:forEach>
                </select>
            </div>
	        <div class="col-sm-2">
	        <select name="searchGu" class="form-select" id="searchGu">
	            <option value="">구 선택</option>
	            <c:forEach var="item" items="${GNAME}">
	                <option value="${item.detCode}" <c:if test="${item.detCode == search.searchGu}">selected</c:if>>${item.detNm}</option>
	            </c:forEach>
	        </select>
	        </div>
	        <div class="col-sm-2">
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
		                      <a href="/doma/board/boardInfo.do?seq=${vo.seq }&div=${vo.getDiv() }"><c:out value="${vo.title}"></c:out></a>
		                    </td>
		                    <td class="text-center" ><c:out value="${vo.userId}"></c:out></td>
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
                            <td class="p-2 g-col-8">
                                <input type="button" value="초기화" id="reset" name="reset" class="btn btn-outline-secondary">
                            </td>
                            <td class="p-2 g-col-8">
							    <input type="button" value="강남구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="강남구">
							</td>
							<td class="p-2 g-col-8">
                                <input type="button" value="강동구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="강동구">
                            </td>
                        </tr>
                        <tr>    
                            <td class="p-2 g-col-8">
                                <input type="button" value="강북구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="강북구">
                            </td> 
                            <td class="p-2 g-col-8">
                                <input type="button" value="강서구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="강서구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="관악구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="관악구">
                            </td>
                        </tr>
                        <tr>     
                            <td class="p-2 g-col-8">
                                <input type="button" value="광진구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="광진구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="구로구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="구로구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="금천구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="금천구">
                            </td>
                        </tr>
                        <tr>    
                            <td class="p-2 g-col-8">
                                <input type="button" value="노원구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="노원구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="도봉구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="도봉구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="동대문구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="동대문구">
                            </td>
                        </tr>
                        <tr>    
                            <td class="p-2 g-col-8">
                                <input type="button" value="동작구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="동작구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="마포구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="마포구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="서대문구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="서대문구">
                            </td>
                        </tr>
                        <tr>      
                            <td class="p-2 g-col-8">
                                <input type="button" value="서초구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="서초구">
                            </td>   
                            <td class="p-2 g-col-8">
                                <input type="button" value="성동구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="성동구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="성북구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="성북구">
                            </td>
                        </tr>
                        <tr>     
                            <td class="p-2 g-col-8">
                                <input type="button" value="송파구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="송파구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="양천구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="양천구">
                            </td> 
                            <td class="p-2 g-col-8">
                                <input type="button" value="영등포구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="영등포구">
                            </td>
                        </tr>
                        <tr>     
                            <td class="p-2 g-col-8">
                                <input type="button" value="용산구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="용산구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="은평구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="은평구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="종로구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="종로구">
                            </td>
                        </tr>
                        <tr>    
                            <td class="p-2 g-col-8">
                                <input type="button" value="중구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="중구">
                            </td>
                            <td class="p-2 g-col-8">
                                <input type="button" value="중랑구" id="gu" name="gu" class="btn btn-outline-secondary" data-gname="중랑구">
                            </td>
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