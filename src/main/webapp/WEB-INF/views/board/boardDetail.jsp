<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세보기</title>    
    <style>
        .info-box {
            margin-top: 13px;
            background-color: #ffffff;
            padding: 30px;
            border: 1px solid #ccc;
            border-top: 3px solid #27403d; /* 윗 테두리 색상 및 굵기 설정 */
        }
        .info-box table {
            width: 100%;
        }
        .info-box table td {
            width: 30%;
            padding-left: 10px;
        }       
        .info-box table td.contents {
            padding-top: 10px;
        }
        .comment-box {
            border: 1px solid #ccc;
            padding: 10px;
            margin-top: 20px;
            border-top: 3px solid #27403d;
        }
        .comment-header h3 {
            margin: 0;
        }
        .comment-header button {
            margin-left: auto;
            float: right;
            background-color: #27403d; /* 배경색 변경 */
            color: #ffffff; /* 글씨색 변경 */
            margin: 5px 5px;
            padding: 7px 10px;
            overflow: hidden;
            border-radius: 5px;
            border: none; 
            cursor: pointer; 
            font-size: 16px;
        }
        #commentForm textarea {
            width: 100%;
            min-height: 90px;
            resize: vertical;
            border: 1px solid #ccc;
        }
        section{
          height : auto;
                min-height: 500px;
                padding : 170px;
                margin-top : 100px;
             }        

    .category-wrap {
        display: flex;
        justify-content: flex-start; /* 왼쪽 정렬 */
        gap: 10px; /* 버튼 사이 간격 조정 */
        align-items: center;
    }

    .category-wrap a.btn, .category-wrap a.edit-button {
        background-color: #27403d;
        color: #ffffff;
        margin: 0; /* 버튼 외부 마진 제거 */
        padding: 7px 10px;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        font-size: 16px;
        text-align: center;
        text-decoration: none;
    }


    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- container -->
<section class="container">
    <div class="inner-container">
        <div class="page-title-group">
            <h2 class="page-title"></h2>
        </div>
<div class="category-box">
    <div class="category-wrap">
        <a href="#" class="btn">목록</a>
        <a href="#" class="edit-button">편집</a>
    </div>
</div>

        </div>
        <div class="info-box">
<table>
    <tr>
        <th style="font-size: 40px; text-align: left; padding: 5px;">제목ex</th>
        <td colspan="10" style="text-align: right;">2024-00-00</td>
    </tr>
    <tr>
        <td style="font-size: 20px;">작성자</td>
        <td colspan="8"></td>
        <td style="text-align: right;">조회수 :</td>
    </tr>
    <tr>
        <td colspan="9"></td>
        <td style="text-align: right;">게시번호 :</td>
    </tr>
    <tr>
    <td colspan="10" style="padding: 10px 0;">
        <!-- 선을 넣을 영역 -->
        <div style="border-bottom: 1px solid #ccc;"></div>
    </td>
  </tr>
    <tr>
        <td style="font-size: 20px; text-align: left; padding: 5px;">작성글ㅇㅇ</td>
    </tr>
</table>
<!-- 댓글 부분 -->
<div class="comment-box">
    <div class="comment-header">
        <div style="display: flex; align-items: center;">
            <h3 style="margin: 0;">comment</h3>
            <button type="button" id="submitComment" style="margin-left: auto;">등록</button>
        </div>
    </div>
    <div id="commentForm">
        <div>
            <label for="content"></label>
            <textarea id="content" name="content" rows="4" required placeholder="comment를 남겨주세요"></textarea>
        </div>
    </div>
    <div id="answer-list">
        <ul id="commentList">
      </ul>
    </div>
  </div>
    </div>
</section>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>
