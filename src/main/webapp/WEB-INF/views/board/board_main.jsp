 <%--
/**
Class Name: board_list.jsp
Description:
Author: acorn
Modification information
확장
message.txt
19KB
board_main
`````` 
<%--
/**
Class Name: board_list.jsp
Description:
Author: acorn
Modification information
확장
message.txt
11KB
package com.acorn.doma.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acorn.doma.cmn.Message;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.StringUtil;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.Code;
import com.acorn.doma.domain.Point;
import com.acorn.doma.service.AccInfoService;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.acorn.doma.service.FreezingService;
import com.acorn.doma.service.MarkdownService;
import com.acorn.doma.service.PointService;

@Controller
@RequestMapping("main")
public class MainController implements PLog {

@Autowired
AccInfoService accInfoService;

@Autowired
BoardService boardService;

@Autowired
MarkdownService markdownService;

@Autowired
CodeService codeService;

public MainController() {
log.debug("┌──────────────────────────────┐");
log.debug("│ MainController()             │");
log.debug("└──────────────────────────────┘");
}

//http://localhost:8080/doma/main/emergency.do
@RequestMapping(value="/main.do"
,method=RequestMethod.GET
,produces = "text/plain;charset=UTF-8")
public String emergency(Model model) throws SQLException {
log.debug("┌──────────────────────────────┐");
log.debug("│ main()                       │");
log.debug("└──────────────────────────────┘");

String viewName = "main/main_emergency_info";

List<Accident> accList = accInfoService.fullTableScan();

model.addAttribute("accList", accList);

List<Accident> A01List = accInfoService.A01Retrieve();
model.addAttribute("A01List", A01List);
List<Accident> A02List = accInfoService.A02Retrieve();
model.addAttribute("A02List", A02List);
List<Accident> A04List = accInfoService.A04Retrieve();
model.addAttribute("A04List", A04List);
List<Accident> A10List = accInfoService.A10Retrieve();
model.addAttribute("A10List", A10List);
List<Accident> A11List = accInfoService.A11Retrieve();
model.addAttribute("A11List", A11List);
return viewName;
}
@RequestMapping(value = "/IdSelect.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
public String accIdSelect(@RequestParam("accId") String accId, Model model) throws SQLException {
String viewName = "main/main_emergency_info";
    Accident accident = new Accident();
    accident.setAccId(accId);
    Accident accIdSelect = accInfoService.doSelectOne(accident);
    log.debug("accIdSelect: "+accIdSelect);
    model.addAttribute("accIdSelect", accIdSelect);
    return viewName;
}

@RequestMapping(value = "/boardInfo.do"
, method = RequestMethod.GET
, produces = "text/plain;charset=UTF-8")  
public String MyPage(HttpSession session,Model model,Board inVO)throws Exception {
String viewName = "/board/board_main";
... (61줄 남음)
접기
message.txt
6KB
board_mng
<%--
/**
    Class Name: 
    Description:
    Author: acorn
    Modification information
확장
message.txt
13KB
﻿
sub
sub_0215
 
hw
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
//객체 생성=================================================================================================    
		//moveToList : 목록으로 이동
		const moveToListBtn = document.querySelector("#moveToList");

		//doDelete : 삭제
		const doDeleteBtn = document.querySelector("#doDelete");

		//moveToUp : 수정페이지로 이동
		const moveToUpBtn = document.querySelector("#moveToUp");
		
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
		
		//코멘트 저장
		const doSaveInput = document.querySelector("#doSave");

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
		
		//moveToUp
		moveToUpBtn.addEventListener("click", function(event) {
            console.log("moveToUpBtn click");
            event.stopPropagation();
            if (confirm("수정페이지로 이동 하시겠습니까?") === false)
                return;
            checkSessionAndMove();
        });
		
		//doSave : 저장
		doSaveInput.addEventListener("click", function(event) {
			console.log("doSaveInput click");
            event.stopPropagation();
            commentSave();
		});

		

//함수=================================================================================================
		
	    //checkSessionAndMove()
        function checkSessionAndMove() {
        
            // JSP에서 userId 값을 JavaScript 변수로 설정
            const userId = "<%= (userId != null && !userId.isEmpty()) ? userId : "" %>";
            
            //userId값 확인
            console.log("checkSessionAndMove: userId = " + userId); 
        
            if (userId !== "" && userId !== " ") {
            	doSelectOne();
            }else {
                alert("작성자가 아닙니다.");
            }
        }
	
	
	    function moveToList() {
	    	window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
        }
        
        function moveToUp() {
        	//비동기 통신
            let type = "GET";
            let url = "/doma/board/moveToUp.do";
            let async = "true";
            let dataType = "html";

            let params = {
                "seq" : seqInput.value,
                "div" : divInput.value,
                "gname" : searchDivSelect.value,
                "title" : titleInput.value,
                "content"  : contentsTextArea.value
                
            };
            
        	window.location.href = "/doma/main/moveToUp.do?seq="+seqInput.value+"&div="+divInput.value+"&gname="+searchDivSelect.value+"&title"+titleInput.value+"&content="+contentsTextArea.value;
        }
        
        //doSelectOne()
        function doSelectOne(seq){
            console.log("doSelectOne seq:"+seq);
            //div
            //seq
            //등록자 정보
            
            //비동기 통신
            let type = "GET";
            let url = "/doma/main/moveToUp.do";
            let async = "true";
            let dataType = "html";

            let params = {
                "div" : divInput.value
            };
            
            
            window.location.href = "/doma/main/moveToUp.do?seq="+seq+"&div="+div;
               
        }
        
        
        //doSave : 저장
        function commentSave() {
            console.log("commentSave()");

            if (isEmpty(contentsTextArea.value) == true) {
                alert('내용을 입력 하세요.')
                return;
            }

            if (confirm("저장 하시겠습니까?") === false)
                return;

            //비동기 통신
            let type = "GET";
            let url = "/doma/comment/doUpdate.do";
            let async = "true";
            let dataType = "html";

            let params = {
                "comseq" : comseqInput.value,
                "seq" : seqInput.value,
                "userId" : userIdInput.value,
                "modId" : modIdInput.value,
                "comments" : simplemde.value()
            };

            PClass.pAjax(url, params, dataType, type, async, function(data) {
                if (data) {
                    try {
                        //JSON문자열을 JSON Object로 변환
                        const message = JSON.parse(data)
                        if (isEmpty(message) === false
                                && 1 === message.messageId) {
                            alert(message.messageContents);
                            window.location.href = "/http://localhost:8080/doma/main/boardInfo.do?seq=1&div=" + divInput.value;
                            
                        } else {
                            alert(message.messageContents);
                        }

                    } catch (e) {
                        alert("data를 확인 하세요");
                    }
                }
            });
        }
	
        //doUpdate : 수정
		function doUpdate() {
			console.log("doUpdate()");

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
				"comseq" : comseqInput.value,
				"seq" : seqInput.value,
				"userId" : userIdInput.value,
				"modId" : modIdInput.value,
				"comments" : simplemde.value()
			};

			PClass.pAjax(url, params, dataType, type, async, function(data) {
				if (data) {
					try {
						//JSON문자열을 JSON Object로 변환
						const message = JSON.parse(data)
						if (isEmpty(message) === false
								&& 1 === message.messageId) {
							alert(message.messageContents);
							window.location.href = "/http://localhost:8080/doma/main/boardInfo.do?seq=1&div=" + divInput.value;
							
						} else {
							alert(message.messageContents);
						}

					} catch (e) {
						alert("data를 확인 하세요");
					}
				}
			});
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


<title>DOMA 커뮤니티</title>
</head>
<body>
user : ${user } 
board : ${board }
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<input type="hidden" name="seq"    id="seq" value="${board.seq}">
    <input type="hidden" name="div"    id="div" value="${board.getDiv()}">
	<div class="container">
		<button type="button" value="목록" id="moveToList" class="btn btn-outline-warning">목록으로</button>
		<button type="button" value="수정" id="moveToUp" class="btn btn-outline-warning">수정하기</button>
		<article class="post">
			<h2 name="title" id="title" class="post-title">${board.title}</h2>
			<div class="post-meta">
				<p name="modId" id="modId" class="post-author">작성자: ${board.modId}</p>
				<p class="post-date">${board.regDt}</p>
			</div>
			<div class="row mb-2">
		        <label for="searchDiv" class="col-sm-2 col-form-label">지역</label>
		        <div class="col-sm-2">
		            <input type="text" value="<c:out value='${board.gname}'/>" class="form-control readonly-input" readonly="readonly" name="searchDiv" id="searchDiv">   
		        </div>
		    </div>
			<hr>
			<div name="content" id="content" class="post-content">
				<p>${board.content}</p>
			</div>
		</article>

		<section class="comments">
			<h3>댓글</h3>
			<div class="comment-form">
				<form action="board_main.jsp" method="post">
					<label for="comment">댓글을 입력하세요:</label>
					<textarea id="comment" name="comment" rows="4" required></textarea>
					<button type="submit" id="doSave" name="doSave">댓글 작성</button>
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
