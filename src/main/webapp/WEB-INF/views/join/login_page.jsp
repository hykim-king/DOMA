<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="CP" value="${pageContext.request.contextPath}" />
<body>
    <div class="container-fluid">
    user: ${user }
        <div class="d-grid gap-2 d-md-flex justify-content-md-end m-2">
            <form class="join_frm">
                <div class="form-floating mb-3">
				  <input type="text" class="form-control-sm" id="userId" placeholder="id">
				  <label for="userId"></label>
				</div>
                <div class="form-floating ">
				  <input type="password" class="form-control-sm" id="password" placeholder="password">
				  <label for="password"></label>
				</div>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end m-2">
	               	<input type="button" id="login" class="btn btn-outline-secondary" value="로그인">
	               	<input type="button" id="register" class="btn btn-outline-secondary" value="회원가입">
           		</div>
            </form>
        </div>