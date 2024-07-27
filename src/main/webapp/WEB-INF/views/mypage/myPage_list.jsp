<%--
/**
	Class Name:
	Author : acorn
	Description:
	Modification information
	
	수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 7. 25        최초작성 
    
    D-O-M-A 개발팀
    since 2020.11.23
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap.css">
<script src="/DOMA/resources/js/jquery_3_7_1.js"></script>
<script src="/DOMA/resources/js/common.js"></script> 
<script>
 
</script>

<title>리뷰쓰기</title>
<style>
        .container {
            display: flex;
        }
        .left-container, .right-container {
            width: 50%;
            padding: 20px;
        }
        .left-container {
            border-right: 1px solid #ccc;
        }
        .right-container {
            border-left: 1px solid #ccc;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        form label, form input {
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-container">
            <h2>입력 폼</h2>
            <form action="submitForm.jsp" method="post">
                <label for="id">아이디:</label>
                <input type="text" id="id" name="id" required>
                
                <label for="name">이름:</label>
                <input type="text" id="name" name="name" required>
                
                <label for="address">주소:</label>
                <input type="text" id="address" name="address" required>
                
                <input type="submit" value="제출">
            </form>
        </div>
        <div class="right-container">
            <h2>테이블</h2>
            <table>
                <thead>
                    <tr>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>주소</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 예시 데이터 -->
                    <tr>
                        <td>user1</td>
                        <td>홍길동</td>
                        <td>서울</td>
                    </tr>
                    <tr>
                        <td>user2</td>
                        <td>김철수</td>
                        <td>부산</td>
                    </tr>
                    <!-- 실제 데이터는 서버에서 가져와서 여기에 추가 -->
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>