<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CCTV Modal</title>
    <style>
        /* 모달 배경 스타일 */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            display: none;
            justify-content: center;
            align-items: center;
        }

        /* 모달 콘텐츠 스타일 */
        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 80%;
            max-width: 900px;
            height: 80%;
            overflow-y: auto;
            display: flex;
            flex-direction: row;
            box-sizing: border-box;
        }

        /* 상세내용 및 CCTV 섹션 */
        .info-table {
            width: 30%;
            padding: 10px;
            box-sizing: border-box;
        }

        .cctv-table {
            width: 70%;
            padding: 10px;
            box-sizing: border-box;
        }

        /* 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            width: 30%;
        }

        td {
            width: 70%;
            vertical-align: top;
        }

        /* CCTV 영상 스타일 */
        video {
            width: 100%;
            height: 400px;
            max-height: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* 닫기 버튼 스타일 */
        .close-button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            align-self: flex-end;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <!-- 모달 오버레이 -->
    <div class="modal-overlay" id="cctvModal">
        <div class="modal-content">
            <!-- 상세 정보 섹션 -->
            <div class="info-table">
                <table>
                    <tbody>
                        <tr>
                            <td colspan="2" id="modalAccName"></td>
                        </tr>
                        <tr>
                            <th>기간</th>
                            <td id="modalOccrDate"></td>
                        </tr>
                        <tr>
                            <th>돌발유형</th>
                            <td id="modalAccDName"></td>
                        </tr>
                        <tr>
                            <td colspan="2" id="modalInfo"></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- CCTV 영상 섹션 -->
            <div class="cctv-table">
                <table>
                    <tbody>
                        <tr>
                            <th>CCTV 이름</th>
                            <td id="modalCctvName"></td>
                        </tr>
                        <tr>
                            <th>영상</th>
                            <td>
                                <video id="cctvVideo" controls autoplay>
                                    <source id="cctvVideoSource" type="application/x-mpegURL">
                                </video>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 닫기 버튼 -->
            <button class="close-button" onclick="closeModal()">닫기</button>
        </div>
    </div>
    
    <!-- HLS.js 라이브러리 포함 -->
    <script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
</body>
</html>