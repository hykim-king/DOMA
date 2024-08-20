<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nanum+Gothic&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Nanum Gothic', sans-serif !important;
        background-color: #f8f9fa;
        margin: 0; /* margin 0으로 조정 */
        padding: 0;
    }

    .container-fluid {
        background-color: #ffffff;
        border-radius: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
       	height: 780px; /* 높이 제한 */
        overflow-y: auto; /* 스크롤 활성화 */
        width: 550px;
        margin: 50px auto;
    }

    h1 {
    	font-family: 'Nanum Gothic', sans-serif;
        color: #000000;
        font-weight: bold;
        text-align: center;
        margin-top : 10px;
        margin-bottom: 30px; /* 제목 아래 여백 추가 */
    }

    .form-control {
        border-radius: 5px;
        border: 1px solid #ced4da;
    }

    .btn-warning {
        border-radius: 5px;
        padding: 10px 20px;
    }

    .form-group {
        margin-bottom: 30px; /* 폼 그룹 사이의 여백 */
    }

    .form-group label {
        font-weight: bold;
        margin-bottom: 10px; /* 라벨과 입력 필드 사이의 여백 조정 */
    }

    #map {
        width: 100%;
        height: 100px;
        margin-top: 10px; /* 지도 상단 여백 추가 */
    }

    #guide {
        font-size: 0.9em;
        color: #999;
        margin-top: 1px;
    }

    .btn-lg {
        font-size: 1.25rem;
        padding: 10px;
    }
</style>

 
<script src="${CP }/resources/js/common.js"></script>
<script src="${CP }/resources/js/jquery_3_7_1.js"></script>
<script src="${CP }/resources/js/user/register.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/template/header.jsp" %>
    <div class="container-fluid" >
        <h1>회원가입</h1>
        <form action="#" method="post" class="form-horizontal w-100">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" class="form-control" name="id" id="id" maxlength="20" required>
                <input type="button" value="중복확인" class="btn btn-dark mt-2" id="idDuplicateCheck">
            </div>
            <div class="form-group">
                <label for="name">닉네임</label>
                <input type="text" class="form-control" name="name" id="name" maxlength="20" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <p style="margin-bottom: 10px;">비밀번호는 최소 특수문자 1자, 영어 대소문자 1자, 숫자 1자리 이상이며 8~20자리 이내입니다.</p>
                <input type="password" class="form-control" name="password" id="password" maxlength="20" required>
            </div>
            <div class="form-group">
                <label for="passwordCheck">비밀번호 확인</label>
                <input type="password" class="form-control" name="passwordCheck" id="passwordCheck" maxlength="20" required>
            </div>
            <div class="form-group">
                <label for="birth">생년월일</label>
                <input type="date" min="1907-01-01" max="2024-08-01" class="form-control" name="birth" id="birth" maxlength="10" required>
            </div>
             <div class="form-group">
			    <label for="sample4_postcode">주소</label>
			    <input type="text" class="form-control mb-2" id="sample4_postcode" disabled placeholder="우편번호">
			    <input type="text" class="form-control mb-2" id="sample4_jibunAddress" disabled placeholder="지번주소">
			    <input type="text" class="form-control mb-2" id="sample4_roadAddress" disabled placeholder="도로명주소">
			    <input type="text" class="form-control mb-2" id="sample4_detailAddress" placeholder="상세주소">
			    <input type="text" class="form-control mb-2" id="sample4_extraAddress" disabled placeholder="참고항목">
			    
			    <!-- 우편번호 찾기 버튼 -->
			    <input type="button" class="btn btn-dark mb-1 w-100" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
			    
			    <!-- 회원가입 버튼을 바로 아래에 배치 -->
			    <input type="button" class="btn btn-warning mb-1 w-100" id="doSave" value="회원가입">
			 
			    <div id="map"></div>
			</div>
			
			<div class="form-group">
			    <span id="guide"></span>
			</div>
              
             
        </form>
    </div>
<%@ include file="/WEB-INF/views/template/footer.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress;
                var extraRoadAddr = '';

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
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
