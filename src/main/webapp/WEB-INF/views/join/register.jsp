<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
    String contextPath = request.getContextPath();
%>
<link rel="stylesheet" href="<%= contextPath %>/resources/css/register.css">
</head>
<body>
	<div class="container">
            <form action="doSave" method="post">
                <ul>
                    <h1>Register</h1>
                    <li class="register_id">
                        <label>아이디</label><br>
                        <input type="text" class="input_text" id="registerId" placeholder="아이디를 입력하세요">
                        <input type="submit" class="input_text" id="IdCheckBtn" value="중복확인">
                    </li>
                    <li class="register_name">
                        <label>닉네임</label><br>
                        <input type="text" class="input_text" id="registerName" placeholder="사용하실 닉네임을 입력하세요.">
                    </li>
                    <li class="register_password">
                        <label>비밀번호</label><br>
                        <input type="password" class="input_text" id="registerPassword" placeholder="비밀번호를 입력하세요">
                    </li>
                    <li class="register_password_check">
                        <label>비밀번호 확인</label><br>
                        <input type="password" class="input_text" id="registerPasswordCheck" placeholder="비밀번호를 입력하세요">
                    </li>
                    <li class="register_birth">
                        <label>생년월일</label><br>
                        <input type="date" class="input_birth" id="registerBirth" value="생년월일">
                    </li>
                    <li class="register_address">
                        <label>주소</label><br>
                        <input type="text" class="input_text" id="registerAddress" placeholder="주소를 입력하세요.">
                        <input type="button" class="input_text" id="adressSearchBtn" value="우편번호">
                    </li>
                    <li class="register_address">
                        <label>상세주소</label><br>
                        <input type="text" class="input_text" id="registerAddressDetail" placeholder="상세주소를 입력하세요.">
                    </li>
                    <li class="register_submit">
                        <input type="submit" class="input_text" id="registerBtn" value="회원가입">
                    </li>
                </ul>
            </form>
        </div>
    </div>
</body>
</html>