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
<%@page import="com.acorn.doma.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="/WEB-INF/views/template/header.jsp" %>
<%
String userId = null;
if(session.getAttribute("user")!=null){
    User outVO = (User) session.getAttribute("user");
    userId = outVO.getUserId();
}


%>  
 

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


<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nanum+Gothic&display=swap" rel="stylesheet">

<%-- bootstrap icon --%>
<%-- <link rel="stylesheet" href="${CP}/resources/icon/font/bootstrap-icons.min.css">--%>

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap-ege.min.css"> 

 <style>
 .hidden {
    display: none;
}
.container {
	 font-family: 'Nanum Gothic', sans-serif !important;
    display: flex;
    gap: 20px;
    padding: 20px;
}
.left-container {
    margin-left: 200px;
    flex-basis: 30%;
    padding: 20px;
}
.right-container {
    flex-basis: 70%;
    padding: 20px;
}
.form-container {
    display: flex;
    align-items: flex-start;
}
.form-container h2 {
    margin-right: 20px;
    white-space: nowrap;
    margin-top: 40px;
}
.form-content {
    flex: 1;
}
.form-btn {
    display: flex;
    justify-content: flex-end;
}
.form-content form {
    display: flex;
    flex-direction: column;
}
form label, form input {
    margin-bottom: 10px;
}
.table-container {
    display: flex;
    align-items: flex-start;
}
.table-container h2 {
    margin-right: 20px;
    white-space: nowrap;
    margin-top: 40px;
}
.table-content {
    margin-top: 40px;
    text-align: center;
    flex: 1;
}
.form-container input[type="text"],
.form-container input[type="password"],
.form-container input[type="email"] {
    width: 300px;  
}
.password-wrapper {
    position: relative;
    display: inline-block;
}
.password-wrapper input {
    padding-right: 40px; /* Space for the icon */
}
.password-wrapper .toggle-password {
    position: absolute;
    right: 10px; /* Position the icon inside the input field */
    top: 20px;
    transform: translateY(-50%);
    cursor: pointer;
}
</style>
<script>
$(document).ready(function(){
    $('.toggle-password').on('click', function() {
        var $icon = $(this);
        var $input = $icon.prev('input');

        $input.toggleClass('active');
        if ($input.hasClass('active')) {
            $icon.attr('class', 'fa fa-eye-slash fa-lg toggle-password');
            $input.attr('type', 'text');
        } else {
            $icon.attr('class', 'fa fa-eye fa-lg toggle-password');
            $input.attr('type', 'password');
        }
    });
});
</script> 
<title>DOMA</title>
 
<script src="${CP}/resources/js/mypage/mypageinfo.js"></script>
</head>
<body>
    <div class="container">
        <div class="left-container">
            <div class="form-container">
                <h2>내 정보</h2>
                <p>${userId}</p>
                <div class="form-content">
                    <form action="" method="">
                        <div class="info">
                            <label for="userInfo" class="form-label mt-4"></label>
                            <input type="text" class="form-control" value="<c:out value='${user.userId}'/>" id="userId" name="userId" disabled="disabled">
                            <input type="text" class="form-control" value="<c:out value='${user.userName}'/>" id="userName" name="userName">
                            <div class="password-wrapper">
                                <input type="password" class="form-control" value="<c:out value='${user.userPw}'/>" id="userPw" name="userPw">
                                <i class="fa fa-eye fa-lg toggle-password"></i>
                            </div>
                            <div class="password-wrapper">
                            <input type="password" class="form-control" name="passwordCheck" id="passwordCheck" maxlength="20" required="required" placeholder="비밀번호를 확인(8~16자리)">
                             <i class="fa fa-eye fa-lg toggle-password"></i>
                            </div>

                            <input type="date" min="1907-01-01" max="2024-08-01" class="form-control" value="<c:out value='${user.birth}'/>" id="birth" name="birth" maxlength="10" required>
                            <input type="text" class="form-control" value="<c:out value='${user.address}'/>" id="sample4_roadAddress" name="address"  >
                            <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" style="display: none;" disabled>
                            <input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" style="display: none;" disabled>

                            <input type="button" class="btn btn-secondary" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
                            <span id="guide" style="color:#999;display:none"></span>
                            <input type="text" class="form-control" value="<c:out value='${user.detailAddress}'/>" id="sample4_detailAddress" placeholder="상세주소"  >
                        	<input type="text" class="form-control" id="sample4_extraAddress"   placeholder="참고항목" style="display: none;" disabled>
                        	<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
                        </div>
                        <br>
                        <div class="form-btn">
                            <input type="button" id="deleteInfo" class="btn btn-outline-danger" value="회원탈퇴">
                            &nbsp; &nbsp; 
                            <input type="reset" id="resetBtn" class="btn btn-outline-secondary" value="초기화">
                            &nbsp; &nbsp; 
                            <input type="button" id="updateInfo" class="btn btn-outline-success" value="수정">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="right-container">
            <!-- 게시글 테이블  -->
            <br>
            <br>
            <h2>게시글 <input type="button" id="MoveBoard" class="btn btn-outline-success" value="관리하기"></h2>
            <br>
            <br>
            <h2>&nbsp;&nbsp;답글 &nbsp;<input type="button" id="MoveComment" class="btn btn-outline-success" value="관리하기"></h2>
        </div>
    </div>
 
<%@ include file="/WEB-INF/views/template/footer.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</body>
</html>