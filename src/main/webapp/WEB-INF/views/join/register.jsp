<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap.css">
<script src="${CP }/resources/js/user/register.js"></script>
<script src="${CP }/resources/js/common.js"></script>
<script src="${CP }/resources/js/jquery_3_7_1.js"></script>
</head>
<body>
${user }
<%@ include file="/WEB-INF/views/template/header.jsp" %>
	<div class="container-fluid d-flex justify-content-center align-items-center vh-100">
		<div class="col-6">
			<h1 style="color:#ffc107; font-weight:bold;">회원가입</h1>
			<form action="#" method="post" class="form-horizontal" style="margin : auto">
			
				<div class="form-group row mb-2">
					<label for="id" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-10">
						<div class="row">
							<div class="col-sm-5">
								<input type="text" class="form-control" name="id" id="id" maxlength="20" required="required">
							</div>
							<div class="col-sm-4">
								<input type="button" value="중복확인" class="btn btn-warning" id="idDuplicateCheck">
							</div>
						</div>
					</div>
				</div>
				<div class="form-group row mb-2">
					<label for="Name" class="col-sm-2 col-form-label">닉네임</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="name" id="name" maxlength="20" required="required">
					</div>
				</div>
				<div class="form-group row mb-2">
					<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" name="password" id="password" maxlength="20" required="required">
					</div>
				</div>
				<div class="form-group row mb-2">
					<label for="passwordCheck" class="col-sm-2 col-form-label">비밀번호 확인</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" name="passwordCheck" id="passwordCheck" maxlength="20" required="required">
					</div>
					<div class="col-sm-4">
							<input type="button" value="비밀번호 확인" class="btn btn-warning" id="passwordDuplicateCheck">
					</div>
				</div>
				<div class="form-group row mb-2">
					<label for="email" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-4">
						<input type="email" class="form-control" name="email" id="email" maxlength="50" required="required">
					</div>
				</div>
				<div class="form-group row mb-2">
					<label for="birth" class="col-sm-2 col-form-label">생년월일</label>
					<div class="col-sm-4">
						<input type="date" class="form-control" name="birth" id="birth" maxlength="10" required="required">
					</div>
				</div>
				<div class="form-group row mb-2">
					<label for="sample3_postcode" class="col-sm-2 col-form-label">주소</label>
					<div class="col-sm-10">
						<div class="row">
							<div class="col-sm-5">
								<input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호">
								<input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소">
								<input type="text" class="form-control" id="sample4_roadAddress" placeholder="도로명주소">
								<span id="guide" style="color:#999;display:none"></span>
								<input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소">
								<input type="text" class="form-control" id="sample4_extraAddress" placeholder="참고항목">
								<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
							</div>
							<div class="col-sm-4">
								<input type="button" class="btn btn-warning" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group row mb-2">
					<div class="col-sm-10 offset-sm-2">
						<input type="button" class="btn btn-warning btn-lg btn-block" id="doSave" value="회원가입">
					</div>
				</div>
			</form>
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
