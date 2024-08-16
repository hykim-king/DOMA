<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DOMA</title>
    <style>
        /* 위에서 수정한 CSS 코드 적용 */
        @keyframes rollCredits {
            0% {
                transform: translateY(100%);
            }
            100% {
                transform: translateY(-100%);
            }
        }

        body {
            background-color: #000;
            color: #fff;
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .credits-container {
            position: absolute;
            bottom: 0;
            width: 100%;
            animation: rollCredits 70s linear;
        }

        .project-title {
            font-size: 6em;
        }

        .project-subtitle {
            font-size: 2em;
            color: #ccc;
        }

        .section {
            margin-bottom: 40px;
        }

        .team-member {
            display: flex;
            align-items: center; /* 세로 정렬 */
            margin-bottom: 20px;
            text-align: left; /* 텍스트 왼쪽 정렬 */
        }

        .team-member img {
            max-width: 100px; /* 이미지 크기 조정 */
            height: auto;
            margin-right: 20px; /* 이미지와 텍스트 사이의 간격 */
            margin-left: 630px;
        }

        .section-title {
            font-size: 2em;
            margin-bottom: 10px;
        }

        .section-content {
            font-size: 1em;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="credits-container">
        <header class="project-header">
            <h1 class="project-title">DORO MASTER</h1>
            <h2 class="project-subtitle">24.07.01 - 24.08.26</h2>
        </header>

        <!-- Project Description -->
        <section class="project-description section">
            현대에 들어서 서울의 인구밀도와 교통량은 교통혼잡을 유발하여 시민들의 일상생활, 생산성, 삶의 질에 부정적인 영향을 미치고 있습니다.<br>
            이를 해결하기 위해 교통사고, 공사, 악천후 등 예측하기 어려운 상황에서도 신속한 대응이 필요하다고 생각했으며,<br>저희는 시민들이 적절한 대체 경로를 선택하도록 도와 교통 흐름을 개선하고,<br>
            시민들이 직접 목격한 돌발 상황을 신고하고 공유할 수 있는 플랫폼을 통해 보다 효율적인 교통 관리와 시민들의 안전과 편의를 증진시키기 위한 웹사이트를 제작하기로 하였습니다.
            <br><br>
        </section>

        <!-- Functionality Definition -->
        <section class="section">
            <h3 class="section-title">기능 정의</h3>
            <div class="section-content">
                <h2 class="section-subtitle">실시간 교통 돌발상황 정보 제공</h2>
                교통 상황 모니터링 시스템<br>
                실시간 교통 데이터 수집 및 분석<br>
                도로 공사, 사고, 자연 재해 등의 돌발 상황 감지<br>.<br>.<br>
                <h2 class="section-subtitle">지도 기반 시각화</h2>
                실시간 교통 돌발 상황을 지도에 표시<br>
                다양한 필터 및 레이어 기능 제공(사고, 공사 등)<br>.<br>.<br>
                <h2 class="section-subtitle">데이터 분석 및 예측 기능</h2>
                과거 데이터 분석<br>
                과거 교통 데이터 분석을 통한 패턴 인식<br>
                자주 발생하는 돌발 상황 및 문제 구간 식별<br>.<br>.<br>
                <h2 class="section-subtitle">교통 상황 예측</h2>
                예측된 정보 기반의 사전 알림 및 대체 경로 추천<br>.<br>.<br>
                <h2 class="section-subtitle">사용자 커뮤니티 기능</h2>
                교통 정보 공유 및 토론을 위한 게시판<br>
                주제, 지역별로 게시판을 분류<br><br><br>
            </div>
        </section>

        <!-- Major Features -->
        <section class="section">
            <h3 class="section-title">주요 기능</h3>
            <div class="section-content">
                <h2 class="section-subtitle">서울 내 날씨 현황 제공</h2>
                데이터에 가상 데이터를 넣고 랜덤으로 화면에 표시<br>
                각 날씨 상황에 따른 도로 위 위험 요소 표시 시각화<br>
                도로 사고 다발 지역 및 돌발 상황 알림<br>.<br>.<br>
                <h2 class="section-subtitle">서울 내 주요 사고다발지역 표시</h2>
                실시간 돌발 상황(사고, 도로공사) 알림<br>
                사고 위험 및 교통 소통 정보 시각화<br>.<br>.<br>
                <h2 class="section-subtitle">데이터 분석 및 시각화</h2>
                수집된 교통 데이터를 분석하여 사고 다발 지역, 교통 혼잡 시간대 등을 시각화<br>
                사용자들에게 유용한 교통 통계 정보를 제공하여 안전한 운전을 지원<br>.<br>.<br>
                <h2 class="section-subtitle">사고 위험 지역 및 시간대별 분석</h2>
                교통 소통 현황(정체 구간, 우회도로) 시각화<br>
                예방 대응 방법 안내<br>.<br>.<br>
                <h2 class="section-subtitle">날씨별 안전 운전 요령 제공</h2>
                사고 발생 시 대처 방법 및 비상 연락처 안내<br>.<br>.<br>                                 
                <h2 class="section-subtitle">커뮤니티 기능</h2>
                교통 관련 주제에 대해 사용자들이 자유롭게 토론할 수 있는 게시판 제공<br>
                안전 운전 팁, 도로 안전 캠페인 정보 등을 공유할 수 있는 공간을 제공<br>
                사용자들이 자신의 경험을 공유하고, 유사한 상황에서의 대처법을 논의<br><br><br>
            </div>
        </section>

        <!-- Expected Effects -->
        <section class="section">
            <h3 class="section-title">기대 효과</h3>
            <div class="section-content">
                <h2 class="section-subtitle">위험 구간 식별 및 개선</h2>
                수집된 교통 돌발 상황 데이터를 분석하여 사고 다발 지역이나 위험 구간을 식별하고 개선 방안을 마련할 수 있습니다.<br>
                커뮤니티 피드백을 기반으로 도로 상태나 교통 시설을 개선하여 사고 위험을 줄입니다.<br>.<br>.<br>
                <h2 class="section-subtitle">사고 예방 교육 및 인식 제고</h2>
                커뮤니티 내에서 안전 운전에 대한 정보를 공유하고, 사고 예방을 위한 교육 자료를 제공하여 운전자들의 인식을 높입니다.<br>
                운전자들이 자신이 겪은 돌발 상황과 대처 방법을 공유함으로써 다른 운전자들이 유사한 상황에서 올바르게 대처할 수 있도록 합니다.<br>.<br>.<br>
                <h2 class="section-subtitle">시민 안전 증대</h2>
                돌발 상황 정보를 실시간으로 제공하여 위험 구역을 피하도록 안내함으로써 시민들의 안전을 보호할 수 있습니다.<br>.<br>.<br>
                <h2 class="section-subtitle">교통 혼잡 완화</h2>
                돌발 상황으로 인한 교통 혼잡 정보를 제공하여 운전자들이 혼잡 지역을 피할 수 있게 합니다.<br>
                돌발 상황에 대한 정보를 미리 공유함으로써 교통 흐름을 유지하고 2차 사고를 예방합니다.<br>.<br>.<br>
                <h2 class="section-subtitle">효율적인 교통 관리</h2>
                교통 당국이 실시간 데이터를 통해 교통 상황을 모니터링하고 효율적으로 관리할 수 있어, 더 나은 교통 정책을 수립하고 실행할 수 있습니다.<br><br><br>                         
            </div>
        </section>

        <!-- Team Information -->
        <section class="section">
            <h3 class="section-title">Team DOMA</h3><br><br>
            <div class="team-member">
                <img src="<%=request.getContextPath()%>/resources/img/doma/doma1.jpg" alt="DOMA Background">
                <div>
                    <p class="team-member-title">Team Leader : 김현석</p>
                    <p class="team-member-role">팀의 리더 역할을 맡고, 전체 프로젝트를 조율합니다.</p>
                </div>
            </div>
            <div class="team-member">
                <img src="<%=request.getContextPath()%>/resources/img/doma/doma2.jpg" alt="DOMA Background">
                <div>
                    <p class="team-member-title">Team Member : 박현아</p>
                    <p class="team-member-role">프로젝트의 다양한 부분을 담당하며 협력합니다.</p>
                    <br>
                </div>
            </div>
            <div class="team-member">
                <img src="<%=request.getContextPath()%>/resources/img/doma/doma5.jpg" alt="DOMA Background">
                <div>
                    <p class="team-member-title">Team Member : 박효준</p>
                    <p class="team-member-role">프로젝트의 다양한 부분을 담당하며 협력합니다.</p>
                    <br>
                </div>
            </div>
            <div class="team-member">
                <img src="<%=request.getContextPath()%>/resources/img/doma/doma3.jpg" alt="DOMA Background">
                <div>
                    <p class="team-member-title">Team Member : 엄기은</p>
                    <p class="team-member-role">프로젝트의 다양한 부분을 담당하며 협력합니다.</p>
                    <br>
                </div>
            </div>
            <div class="team-member">
                <img src="<%=request.getContextPath()%>/resources/img/doma/doma4.jpg" alt="DOMA Background">
                <div>
                    <p class="team-member-title">Team Member : 임강혁</p>
                    <p class="team-member-role">프로젝트의 다양한 부분을 담당하며 협력합니다.</p>
                </div>
            </div>
        </section>
        
       <section class="section">
       <br><br><br><br>.<br>.<br>
        <h3 class="section-title">Thanks</h3>
       <div class="section-content">
        <h2 class="section-subtitle"></h2>
        <br>.<br>.<br>
          </div>
        </section>
    </div>
        <script>
        const creditsContainer = document.querySelector('.credits-container');
        creditsContainer.addEventListener('animationend', () => {
            window.location.href = 'http://localhost:8080/doma/main/main.do';
        });
    </script>
</body>
</html>
