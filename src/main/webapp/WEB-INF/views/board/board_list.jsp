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
<%@page import="com.acorn.doma.cmn.StringUtil"%>
<%@page import="com.acorn.doma.cmn.Search"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
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
<title>Insert title here</title>
<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");
//객체 생성=================================================================================================       
       
	
	
//이벤트 처리=================================================================================================  
      
    
       
});   
//함수=================================================================================================  
       
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- container -->
<div class="container">  
        <!-- 버튼 -->
        <div class="form-buttons" style="margin : 20px 0px 10px 30px">
            <input type="button" value="글쓰기" class="g-col-6 member-action-button">
            <input type="button" value="조회" class="g-col-6 member-action-button">
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
	            <select name="searchDiv" class="form-select" id="searchDiv">
	                <option value="">구 선택</option>
	                <c:forEach var="item" items="${BOARD_SEARCH}">
	                   <option value="${item.detCode}"  <c:if test="${item.detCode == search.searchDiv }">selected</c:if>    >${ item.detNm}</option>
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
		    <table class="table table-striped table-hover table-bordered m-3" id="boardTable">
		      <thead >
		        <tr class="table-warning">
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
		                      <a href="/doma/board/doSelectOne.do?seq=${vo.seq }&div=${vo.getDiv() }"><c:out value="${vo.title }"></c:out></a>
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
<script src="${CP}/resources/js/bootstrap.bundle.js"></script> 
</body>
</html>