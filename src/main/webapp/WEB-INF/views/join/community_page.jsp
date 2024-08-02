<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap.css">
<script src="${CP }/resources/js/common.js"></script>
<script src="${CP }/resources/js/jquery_3_7_1.js"></script>
</head>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
		<div  style="margin : 20px 0px 20px 30px">
			<input type="button" value="게시글 등록" class="g-col-6 btn btn-secondary">
			<input type="button" value="게시글 수정" class="g-col-6 btn btn-secondary">
			<input type="button" value="게시글 삭제" class="g-col-6 btn btn-secondary">
		</div>
		<div class="d-flex m-2">
            <table class="table table-striped table-hover table-bordered m-3">
                <tr>
                    <td class="text-center col-sm-1">작성자</td>
                    <td class="text-center col-sm-3">현재 삼성동 도로 상태..</td>
                    <td class="text-center col-sm-3">위치</td>
                    <td class="text-center col-sm-2">작성날짜</td>
                </tr>
                <tr>
                    <td class="text-center col-sm-1">작성자</td>
                    <td class="text-center col-sm-3">현재 삼성동 도로 상태..</td>
                    <td class="text-center col-sm-2">위치</td>
                    <td class="text-center col-sm-2">작성날짜</td>
                </tr>
                <tr>
                    <td class="text-center col-sm-1">작성자</td>
                    <td class="text-center col-sm-3">현재 삼성동 도로 상태..</td>
                    <td class="text-center col-sm-2">위치</td>
                    <td class="text-center col-sm-2">작성날짜</td>
                </tr>
            </table>
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