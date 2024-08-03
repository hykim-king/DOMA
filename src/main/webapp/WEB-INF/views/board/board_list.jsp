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
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
        
        <div  style="margin : 20px 0px 20px 30px">
            <input type="button" value="게시글 등록" class="g-col-6 btn btn-secondary">
            <input type="button" value="게시글 수정" class="g-col-6 btn btn-secondary">
            <input type="button" value="게시글 삭제" class="g-col-6 btn btn-secondary">
        </div>
        <div class="d-flex m-2">
            <!-- table -->
		    <table class="table table-striped table-hover table-bordered m-3" id="boardTable">
		      <thead >
		        <tr class="table-success">
		          <th class="text-center col-sm-1">no</th>
		          <th class="text-center col-sm-6">제목</th>
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
            
            
            <div >
                <form class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <input type="search" class="g-col-6">
                    <input type="button" value="검색" class="g-col-6 btn btn-secondary">
                </form>
                <div class="grid gap-0 column-gap-6">
                    <table> 
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="삼성동"  class="btn btn-secondary btn-lg"></td>
                            <td class="p-2 g-col-8"><input type="button" value="삼성동"  class="btn btn-secondary btn-lg"></td>
                        </tr>
                        <tr>
                            <td class="p-2 g-col-8"><input type="button" value="삼성동"  class="btn btn-secondary btn-lg"></td>
                            <td class="p-2 g-col-8"><input type="button" value="삼성동"  class="btn btn-secondary btn-lg"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    <%--bootstrap js --%>
<script src="${CP}/resources/js/bootstrap.bundle.js"></script> 
</body>
</html>