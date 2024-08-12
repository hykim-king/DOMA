<%@ page import="com.acorn.doma.cmn.StringUtil"%>
<%@ page import="com.acorn.doma.cmn.Search"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/admin_page.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- favicon  --%>
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico"
	type="image/x-icon">

<%-- bootstrap css --%>
<link rel="stylesheet"
	href="${CP}/resources/css/bootstrap/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script>

<%-- google Nanum+Gothic --%>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">

<%-- FontAwesome for icons --%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- simplemde -->
<link rel="stylesheet"
	href="${CP }/resources/css/bootstrap/simplemde.min.css">
<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>

<%-- FontAwesome for icons --%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<script>
	document.addEventListener("DOMContentLoaded", function() {
		console.log("DOMContentLoaded");
		//객체 생성=================================================================================================    
		//moveToList : 목록으로 이동
		const moveToListBtn = document.querySelector("#moveToList");

		//doDelete : 삭제
		const doDeleteBtn = document.querySelector("#doDelete");
		console.log("doDeleteBtn", doDeleteBtn);

		//doUpdate : 수정
		const doUpdateBtn = document.querySelector("#doUpdate");

		//seq
		const seqInput = document.querySelector("#seq");

		//div
		const divInput = document.querySelector("#div");

		//구이름
		const gnameInput = document.querySelector("#gname");

		//제목
		const titleInput = document.querySelector("#title");

		//이미지
		const imgLinkInput = document.querySelector("#imgLink");

		//내용
		const contentsTextArea = document.querySelector("#content");

		//구분
		const searchDivSelect = document.querySelector("#searchDiv");

		const modIdInput = document.querySelector("#modId");

		//이벤트 처리=================================================================================================
		//moveToListBtn
		moveToListBtn.addEventListener("click", function(event) {
			console.log("moveToListBtn click");
			event.stopPropagation();
			if (confirm("목록 으로 이동 하시겠습니까?") === false)
				return;
			moveToList();
		});

		//doUpdate : 수정
		doUpdateBtn.addEventListener("click", function(event) {
			console.log("doUpdateBtn click");
			event.stopPropagation();
			doUpdate();
		});

		//doDelete : 삭제
		doDeleteBtn.addEventListener("click", function(event) {
			console.log("doDeleteBtn click");
			event.stopPropagation();
			doDelete();
		});

		//함수=================================================================================================
		//doUpdate : 수정
		function doUpdate() {
			console.log("doUpdate()");

			if (isEmpty(seqInput.value) == true) {
				alert('seq를 확인 하세요.')
				//seqInput.focus();
				return;
			}

			if (isEmpty(titleInput.value) == true) {
				alert('제목을 입력 하세요.')
				titleInput.focus();
				return;
			}

			//marker : simplemde.value()
			if (isEmpty(simplemde.value()) == true) {
				alert('내용을 입력 하세요.')
				contentsTextArea.focus();
				return;
			}

			if (confirm("수정 하시겠습니까?") === false)
				return;

			//비동기 통신
			let type = "POST";
			let url = "/doma/board/doUpdate.do";
			let async = "true";
			let dataType = "html";

			let params = {
				"seq" : seqInput.value,
				"div" : divInput.value,
				"gname" : searchDivSelect.value,
				"title" : titleInput.value,
				"modId" : modIdInput.value,
				"content" : simplemde.value()
			};

			PClass.pAjax(url, params, dataType, type, async, function(data) {
				if (data) {
					try {
						//JSON문자열을 JSON Object로 변환
						const message = JSON.parse(data)
						if (isEmpty(message) === false
								&& 1 === message.messageId) {
							alert(message.messageContents);
							//window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
							moveToList();
						} else {
							alert(message.messageContents);
						}

					} catch (e) {
						alert("data를 확인 하세요");
					}
				}
			});
		}

		function moveToList() {
			window.location.href = "/doma/board/doRetrieve.do?div="
					+ divInput.value;
		}

		//doDelete : 삭제
		function doDelete() {
			console.log("doDelete()");

			if (isEmpty(seqInput.value) == true) {
				alert('seq를 확인 하세요.')
				seqInput.focus();
				return;
			}

			if (confirm("삭제 하시겠습니까?") === false)
				return;

			//비동기 통신
			let type = "GET";
			let url = "/doma/board/doDelete.do";
			let async = "true";
			let dataType = "html";

			let params = {
				"seq" : seqInput.value
			};

			PClass.pAjax(url, params, dataType, type, async, function(data) {
				if (data) {
					try {
						//JSON문자열을 JSON Object로 변환
						const message = JSON.parse(data)
						if (isEmpty(message) === false
								&& 1 === message.messageId) {
							alert(message.messageContents);
							//window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
							moveToList();
						} else {
							alert(message.messageContents);
						}

					} catch (e) {
						alert("data를 확인 하세요");
					}
				}
			});
		}
	});
</script>


<style>
body {
	font-family: 'Nanum Gothic', sans-serif;
	color: #333;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

header, footer {
	background-color: #fff;
	border-bottom: 1px solid #ddd;
}

.post {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	height: 350px;
}

.post-title {
	font-weight: bold;
	font-size: 24px;
	color: #333;
	margin-top: 5px;
}

.post-content {
	font-size: 16px;
	color: #555;
}

.post-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.post-author {
	margin: 0;
	font-size: 14px;
	color: #555;
}

.post-date {
	margin: 0;
	font-size: 14px;
	color: #777;
}

.comments {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.comment-form {
	margin-bottom: 20px;
}

.comment-form label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.comment-form textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.comment-form button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	margin-top: 10px;
}

.comment-form button:hover {
	background-color: #0056b3;
}

.comment-list {
	margin-top: 20px;
}

.comment {
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

.comment p {
	margin: 0;
}

.comment strong {
	color: #007bff;
}
</style>

<title>DOMA 커뮤니티</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container">
		<button type="button" class="btn btn-outline-warning">편집하기</button>
		<article class="post">
			<h2 class="post-title">${board.title}</h2>
			<div class="post-meta">
				<p class="post-author">작성자: ${board.userId}</p>
				<p class="post-date">${board.regDt}</p>
			</div>
			<hr>
			<div class="post-content">
				<p>${board.content}</p>
			</div>
		</article>

		<section class="comments">
			<h3>댓글</h3>
			<div class="comment-form">
				<form action="submitComment.jsp" method="post">
					<label for="comment">댓글을 입력하세요:</label>
					<textarea id="comment" name="comment" rows="4" required></textarea>
					<button type="submit">댓글 작성</button>
				</form>
			</div>
			<div class="comment-list">
				<div class="comment">
					<p>
						<strong>작성자:</strong> 댓글 내용이 여기에 표시됩니다.
					</p>
				</div>
				<!-- 추가 댓글은 여기에 나열됩니다 -->
			</div>
		</section>
	</div>
</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</html>
