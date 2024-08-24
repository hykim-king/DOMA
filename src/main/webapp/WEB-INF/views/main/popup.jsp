<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CCTV Popup</title>
    <style>
        /* 스타일 추가 */
        .popup-container { font-family: Arial, sans-serif; padding: 20px; }
        .info-table, .cctv-table { margin-bottom: 20px; }
        button { padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <div class="popup-container">
        <div class="info-table">
            <table>
                <tbody>
                    <tr>
                        <td colspan="2" onclick="window.opener.moveToMarker('<%= request.getParameter("latitude") %>', '<%= request.getParameter("longitude") %>')">
                            <%= request.getParameter("accName") %> : <%= request.getParameter("accDName") %>
                        </td>
                    </tr>
                    <tr>
                        <th>기간</th>
                        <td><%= request.getParameter("occrDate") %> <%= request.getParameter("occrTime") %> ~ <br><%= request.getParameter("endDate") %> <%= request.getParameter("endTime") %></td>
                    </tr>
                    <tr>
                        <th>돌발유형</th>
                        <td><%= request.getParameter("accDName") %></td>
                    </tr>
                    <tr>
                        <td colspan="2"><%= request.getParameter("info") %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="cctv-table">
            <table>
                <tbody>
                    <tr>
                        <th>CCTV 이름</th>
                        <td><%= request.getParameter("cctvName") %></td>
                    </tr>
                    <tr>
                        <th>영상</th>
                        <td>
                            <video id="cctvVideo" controls autoplay>
                                <source src="<%= request.getParameter("cctvUrl") %>" type="application/x-mpegURL">
                                Your browser does not support the video tag.
                            </video>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <button onclick="window.close()">닫기</button>
    </div>
    
    <!-- Include HLS.js library -->
    <script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
    <script>
        var video = document.getElementById('cctvVideo');
        var cctvUrl = '<%= request.getParameter("cctvUrl") %>';
        
        // Check if HLS.js is supported
        if (Hls.isSupported()) {
            var hls = new Hls();
            hls.loadSource(cctvUrl);
            hls.attachMedia(video);
            hls.on(Hls.Events.MANIFEST_PARSED, function() {
                video.play();
            });
        } else if (video.canPlayType('application/vnd.apple.mpegurl')) {
            // For Safari and other browsers that support HLS natively
            video.src = cctvUrl;
            video.addEventListener('loadedmetadata', function() {
                video.play();
            });
        }
    </script>
</body>
</html>