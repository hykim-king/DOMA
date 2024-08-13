document.addEventListener('DOMContentLoaded', function() {
    loadNotices(1);
});

function loadNotices(pageNo) {
    console.log("Loading notices for page:", pageNo);

    const searchWord = document.querySelector("#searchWord").value;
    const pageSize = 6;  // 페이지 크기 설정

    const params = new URLSearchParams({
        pageNo: pageNo,
        pageSize: pageSize,
        searchWord: searchWord
    });

    fetch(`/doma/admin/doRetrieveNotices.do?${params.toString()}`)  // 데이터가 있는 엔드포인트로 요청
        .then(response => {
            if (response.ok) {
                return response.json(); // JSON으로 응답을 변환
            } else {
                return response.text().then(text => {
                    throw new Error(`Server responded with status ${response.status}: ${text}`);
                });
            }
        })
        .then(data => {
            console.log('Notices:', data);
            displayNotices(data.notices);  // 데이터를 가져와서 테이블에 표시
        })
        .catch(error => {
            console.error('Error fetching notices:', error);
        });
}

function displayNotices(notices) {
    const listContainer = document.getElementById("list-container");
    listContainer.innerHTML = ''; // 이전 공지사항 제거

    console.log('Received notices:', notices);


    
    notices.forEach(notice => {
        const row = document.createElement("tr");
        row.innerHTML = `
            <td>${notice.rn}</td>
            <td>${notice.title}</td>
            <td>${notice.content}</td>
            <td>${notice.userId}</td>
            <td>${notice.boardRegDt}</td>
        `;
        listContainer.appendChild(row);
    });
}

function handleSearch() {
    loadNotices(1);  // 검색 버튼 클릭 시 첫 페이지 로드
}

document.addEventListener("DOMContentLoaded", () => {
    loadNotices(1);  // 페이지가 로드될 때 첫 페이지의 공지사항을 로드합니다.
});