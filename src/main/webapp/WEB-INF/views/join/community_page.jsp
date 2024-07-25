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
</head>
<body>
    <div class="container-fluid">
        <div class="col-sm-2 m-3 justify-content-end">
            <form class="join_frm">
                <div class="form-floating mb-3">
				  <input type="text" class="form-control-sm" id="floatingInput" placeholder="id">
				  <label for="floatingInput"></label>
				</div>
                <div class="form-floating ">
				  <input type="password" class="form-control-sm" id="floatingPassword" placeholder="password">
				  <label for="floatingPassword"></label>
				</div>
            </form>
            <div class="col-md m-3">
               	<input type="submit" class="btn btn-secondary" value="로그인">
               	<input type="button" class="btn btn-secondary" value="회원가입">
           	</div>
        </div>
        <div>
	        <nav class="navbar col-md" style="background-color: #ffc107">
				<table class="navbar-nav">
					<tr>					
						<td class="nav-item">
							<a class="nav-link active" aria-current="page" href="${CP}/user/doRetrieve.do">상황별 안전 정보</a>
						</td>
						<td class="nav-item">
							<a class="nav-link active" aria-current="page" href="${CP}/board/doDelete.do">데이터 시각화</a>
						</td>
						<td class="nav-item">
							<a class="nav-link active" aria-current="page" href="${CP }/template/list.do">공지사항</a>
						</td>
					</tr>
				</table>
			</nav>
        </div>
		<div class="col-md m-3">
            <table class="table table-striped table-hover table-bordered">
                <tr>
                    <td class="text-center col-sm-1">작성자</td>
                    <td class="text-center col-sm-3">현재 삼성동 도로 상태..</td>
                    <td class="text-center col-sm-2">위치</td>
                    <td class="text-center col-sm-2">작성날짜</td>
                </tr>
            </table>
	        <div class="float-end">
	            <form>
	                <input type="search" class="form-control-sm" >
	                <input type="button" value="검색" class="btn btn-secondary">
	            </form>
		        <div class="grid gap-0 column-gap-3">
		            <table> 
		                <tr>
		                    <td class="p-2 g-col-6"><input type="button" value="삼성동"  class="btn btn-secondary"></td>
		                    <td class="p-2 g-col-6"><input type="button" value="삼성동"  class="btn btn-secondary"></td>
		                </tr>
		                <tr>
		                    <td class="p-2 g-col-6"><input type="button" value="삼성동"  class="btn btn-secondary"></td>
		                    <td class="p-2 g-col-6"><input type="button" value="삼성동"  class="btn btn-secondary"></td>
		                </tr>
		            </table>
		        </div>
	        </div>
		</div>
    </div>
    <%--bootstrap js --%>
<script src="${CP}/resources/js/bootstrap.bundle.js"></script> 
</body>
</html>