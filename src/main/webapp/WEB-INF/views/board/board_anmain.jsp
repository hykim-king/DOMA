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
<%@page import="com.acorn.doma.domain.User"%>
<%@ page import="com.acorn.doma.cmn.StringUtil"%>
<%@ page import="com.acorn.doma.cmn.Search"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%

    User outVO = (User) session.getAttribute("user");
    String userId = (outVO != null) ? outVO.getUserId() : "";
    
    int grade = 0; // 기본값 설정
    if (outVO != null) {
        grade = outVO.getGrade();
    }
%> 

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
<script>
document.addEventListener("DOMContentLoaded", function() {
    console.log("DOMContentLoaded");

    const urlParams = new URLSearchParams(window.location.search);
    const seq = urlParams.get('seq');
    const userId = "<%= (userId != null && !userId.isEmpty()) ? userId : "" %>";
    const grade = <%= grade %>; // int 타입은 그대로 출력
    const modId = document.getElementById("modId").value;
    console.log("seq: " + seq);
    console.log("userId: " + userId);
    console.log("modId: " + modId);
    console.log("grade: " + grade);
    
    // 객체 생성=================================================================================================
    const moveToListBtn = document.querySelector("#moveToList");
    const doDeleteBtn = document.querySelector("#doDelete");
    const moveToUpBtn = document.querySelector("#moveToUp");
    const doUpdateBtn = document.querySelector("#doUpdate");
    const seqInput = document.querySelector("#seq");
    const divInput = document.querySelector("#div");
    const gnameInput = document.querySelector("#gname");
    const imgLinkInput = document.querySelector("#imgLink");
    const contentsTextArea = document.getElementById("comment");
    const searchDivSelect = document.querySelector("#searchDiv");
    const doSaveBtn = document.querySelector("#doSave");
    const modIdInput = document.querySelector("#modId");
    const titleInput = document.getElementById("title");
    const contentInput = document.getElementById("content");

    ajaxGetComments();

    // 이벤트 처리=================================================================================================

    moveToListBtn.addEventListener("click", function(event) {
        console.log("moveToListBtn click");
        event.stopPropagation();
        moveToList();
    });

    moveToUpBtn.addEventListener("click", function(event) {
        console.log("moveToUpBtn click");
        event.stopPropagation();

        // moveToUpSession 함수에서 이동 가능 여부와 confirm 필요 여부를 확인합니다.
        const shouldMove = moveToUpSession();

        // 수정 페이지로 이동 여부를 묻는 confirm 대화 상자를 표시해야 하는 경우에만 실행합니다.
        if (shouldMove && confirm("수정 페이지로 이동하시겠습니까?")) {
            moveToUp();
        }
    });

    doSaveBtn.addEventListener("click", function(event) {
        console.log("doSaveInput click");
        event.stopPropagation();
        commentsSession();
    });

    doDeleteBtn.addEventListener("click", function(event) {
        console.log("doDeleteBtn click");
        event.stopPropagation();
        deleteSession();
    });

    // 함수=================================================================================================

    //삭제 세션 여부    
    function deleteSession() {
        const userId = "<%= (userId != null && !userId.isEmpty()) ? userId : "" %>";
        const modId = document.getElementById("modId").value;
        const grade = <%= grade %>; // grade 값 가져오기

        console.log("checkSessionAndMove: userId = " + userId + ", modId = " + modId + ", grade = " + grade);

        if (userId === "" || userId === " ") {
            alert("로그인이 필요합니다.");
            window.location.href = "/doma/user/loginPage.do";
        } else if (userId !== "" && userId === modId) {
            doDelete();    
        } else if (userId === userId) {
            if (grade === 0) {
                doDelete();
            } else if (grade === 1) {
                alert("관리자가 아닙니다.");
            }
        } else {
            alert("관리자가 아닙니다.");
        }
    }   
        
    //수정하기 세션 여부    
    function moveToUpSession() {
        const userId = "<%= (userId != null && !userId.isEmpty()) ? userId : "" %>";
        const modId = document.getElementById("modId").value;
        const grade = <%= grade %>; // grade 값 가져오기
    
        console.log("checkSessionAndMove: userId = " + userId + ", modId = " + modId + ", grade = " + grade);
    
        if (userId === "" || userId === " ") {
            alert("로그인이 필요합니다.");
            window.location.href = "/doma/user/loginPage.do";
            return false;
        } else if (userId === modId) {
            return true; // 작성자와 userId가 일치하는 경우
        } else if (grade === 0) {
            return true; // 작성자가 아니지만 grade가 0인 경우
        } else if (grade === 1) {
            alert("관리자가 아닙니다.");
            return false;
        } else {
            alert("관리자가 아닙니다.");
            return false;
        }
    }
    
    //코멘트 저장 세션 여부
    function commentsSession() {
        const userId = "<%= (userId != null && !userId.isEmpty()) ? userId : "" %>";

        console.log("CommentscheckSession: userId = " + userId);

        if (userId !== "" && userId !== " ") {
            commentSave();
        } else {
            alert("로그인이 필요합니다.");
            window.location.href = "/doma/user/loginPage.do";
        }
    }

    function moveToList() {
        window.location.href = "/doma/board/doRetrieveAn.do?div=" + divInput.value;
    }

    function moveToUp() {
        let params = {
            "seq": seq,
            "div": divInput.value
        };

        window.location.href = "/doma/board/anMoveToUp.do?seq=" + seq + "&div=" + divInput.value;
    }

    function commentSave() {
        console.log("commentSave()");

        if (isEmpty(contentsTextArea.value) === true) {
            alert('내용을 입력하세요.');
            contentsTextArea.focus();
            return;
        }

        if (!confirm('등록하시겠습니까?')) {
            alert("취소하였습니다.");
            return;
        }

        let params = {
            "seq": seq,
            "userId": userId,
            "modId": modId,
            "comments": contentsTextArea.value
        };

        PClass.pAjax("/doma/comments/doSave.do", params, "html", "POST", true, function(data) {
            if (data) {
                try {
                    const message = JSON.parse(data);
                    if (isEmpty(message) === false && 1 === message.messageId) {
                        location.reload();
                    } else {
                        alert(message.messageContents);
                    }
                } catch (e) {
                    alert("data를 확인하세요");
                }
            }
        });
    }

    function doRetrieve() {
        console.log("doRetrieve 댓글 리스트");

        $.ajax({
            url: "/doma/comments/doRetrieve.do",
            type: 'GET',
            dataType: "json",
            data: { seq: seq },
            success: function(response) {
                console.log(response);
            },
            error: function(error) {
                console.error("Error", error);
            }
        });
    }

    //doDelete : 삭제
    function doDelete() {
        console.log("doDelete()");
        
        if(isEmpty(seqInput.value) == true){
            alert('seq를 확인 하세요.')
            seqInput.focus();
            return;
        }
        
        if(confirm("삭제 하시겠습니까?") === false)return;
        
        //비동기 통신
        let type = "GET";
        let url = "/doma/board/doDelete.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
            "seq"    : seq
        };

        PClass.pAjax(url, params, dataType, type, async, function(data){
            if(data){
                try{
                    //JSON문자열을 JSON Object로 변환
                    const message = JSON.parse(data)
                    if(isEmpty(message) === false && 1 === message.messageId){
                        moveToList();
                    }else{
                        alert(message.messageContents);
                    }
                    
                }catch(e){
                    alert("data를 확인 하세요");
                }
            }
        });
    }

    function ajaxGetComments() {
        $.ajax({
            type: "GET",
            url: "/doma/comments/doRetrieve.do",
            dataType: "json",
            data: {
                "seq": seq,
                "ajax": true
            },
            success: function(response) {
                console.log("Success response", response);
                var replyList = $("#reply-list");
                replyList.empty();

                if (response.length > 0) {
                    response.forEach(function(reply) {
                        var replyRow = $("<li></li>").addClass("reply-row");

                        var replyWriter = $("<p></p>").addClass("reply-writer").text(reply.userId);
                        var replyComments = $("<p></p>").addClass("reply-comments").text(reply.comments);
                        var replyDate = $("<p></p>").addClass("reply-date")
                            .text((reply.modDt ? "수정일 " : "") + (reply.modDt ? reply.modDt : reply.regDt));

                        replyRow.append(replyWriter).append(replyComments).append(replyDate);

                        // 로그인 여부 확인 및 grade에 따른 수정/삭제 버튼 추가 조건
                        if (userId) {  // 로그인 여부 확인
                            if (grade === 0) {
                                // grade가 0일 때 삭제 버튼만 추가
                                var deleteButton = $("<button></button>").text("삭제").addClass("btn btn-outline-warning");

                                // 삭제 버튼 클릭 이벤트
                                deleteButton.on("click", function() {
                                    if (confirm("삭제하시겠습니까?")) {
                                        $.ajax({
                                            type: "GET",
                                            url: "/doma/comments/doDelete.do",
                                            dataType: "text",
                                            data: {
                                                "comSeq": reply.comSeq,
                                                "userId": userId,
                                                "ajax": true
                                            },
                                            success: function(response) {
                                                alert('삭제하였습니다.');
                                                ajaxGetComments();
                                            },
                                            error: function(error) {
                                                console.log("Error:", error);
                                                alert("댓글 삭제에 실패했습니다.");
                                            }
                                        });
                                    }
                                });

                                replyRow.append(deleteButton);

                            } else if (grade === 1 && userId === reply.userId) {
                                // grade가 1이고 userId가 댓글 작성자와 같을 때 수정/삭제 버튼 추가
                                var updateButton = $("<button></button>").text("수정").addClass("btn btn-outline-warning");
                                var deleteButton = $("<button></button>").text("삭제").addClass("btn btn-outline-warning");

                                // 수정 버튼 클릭 이벤트
                                updateButton.on("click", function() {
                                    var newComments = prompt("수정할 내용을 입력하세요:", reply.comments);
                                    if (newComments !== null) {
                                        $.ajax({
                                            type: "POST",
                                            url: "/doma/comments/doUpdate.do",
                                            data: {
                                                "comSeq": reply.comSeq,
                                                "seq": seq,
                                                "userId": userId,
                                                "modId": modId,
                                                "comments": newComments,
                                                "ajax": true
                                            },
                                            success: function(response) {
                                                alert('수정하였습니다.');
                                                ajaxGetComments();
                                            },
                                            error: function(error) {
                                                console.log("Error:", error);
                                            }
                                        });
                                    }
                                });

                                // 삭제 버튼 클릭 이벤트
                                deleteButton.on("click", function() {
                                    if (confirm("삭제하시겠습니까?")) {
                                        $.ajax({
                                            type: "GET",
                                            url: "/doma/comments/doDelete.do",
                                            dataType: "text",
                                            data: {
                                                "comSeq": reply.comSeq,
                                                "userId": userId,
                                                "ajax": true
                                            },
                                            success: function(response) {
                                                alert('삭제하였습니다.');
                                                ajaxGetComments();
                                            },
                                            error: function(error) {
                                                console.log("Error:", error);
                                                alert("댓글 삭제에 실패했습니다.");
                                            }
                                        });
                                    }
                                });

                                replyRow.append(updateButton).append(deleteButton);
                            }
                        }

                        replyList.append(replyRow);
                    });
                } else {
                    replyList.append("<p>댓글이 없습니다. 첫 번째 댓글을 달아보세요!</p>");
                }
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }

    ajaxGetComments();

});

    
</script>


<title>DOMA 커뮤니티</title>
</head>
<body>

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <input type="hidden" name="seq"    id="seq" value="${board.seq}">
    <input type="hidden" name="div"    id="div" value="${board.getDiv()}">
    <input type="hidden" name="modId"  id="modId" value="${board.modId}">
    <input type="hidden" name="comSeq" id="comSeq" value="${comments.comSeq}">
    <div class="container">
        <button type="button" value="목록" id="moveToList" class="btn btn-outline-warning">목록으로</button>
        <button type="button" value="수정" id="moveToUp" class="btn btn-outline-warning">수정하기</button>
        <button type="button" value="삭제" id="doDelete" class="btn btn-outline-warning">삭제하기</button>
        
        <article class="post">
            <h2 name="title" id="title" class="post-title">${board.title}</h2>
            <div class="post-meta">
                <p name="userId" id="userId" class="post-author">작성자: ${board.userId}</p>
                <p class="post-date">${board.regDt}</p>
                <p class="text-end">조회수: ${board.views}</p>
            </div>
            <hr>
            <div id="imgLink" class="post-content">
                <img src="${info.imgLink }">
            </div>
            <hr>
            <div name="content" id="content" class="post-content">
                <p>${board.content}</p>
            </div>
        </article>

        <section class="comments">
            <h3>댓글</h3>
            <div class="comment-form">
                <form action="board_main.jsp" method="post" onsubmit="commentSave(event)">
                    <label for="comment">댓글을 입력하세요:</label>
                    <textarea id="comment" name="comment" rows="4" required></textarea>
                    <button type="button" value="댓글 쓰기" id="doSave" name="doSave" class="btn btn-primary mt-2">댓글 쓰기</button>
                </form>
            </div>
            <div class="comment-list">
                <div class="comment">
                    <p>
                        <strong>작성자:</strong> 댓글 내용이 여기에 표시됩니다.
                    </p>
                </div>
                <!-- 추가 댓글은 여기에 나열됩니다 -->
                <ul id="reply-list" class="list-unstyled">
                <!-- AJAX를 통해 동적으로 댓글이 추가될 영역 -->
                
                </ul>
            </div>
        </section>
    </div>

</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</html>
