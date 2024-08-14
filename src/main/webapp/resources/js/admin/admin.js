document.addEventListener('DOMContentLoaded', function() {
    loadNotices(1);
});

let currentPage = 1;
let pageSize = 5; // 페이지 크기
let totalPages = 1; // 총 페이지 수
let pageGroupSize = 5; // 페이지 그룹당 버튼 수
let currentPageGroup = 1; // 현재 페이지 그룹

function loadNotices(pageNo) {
    currentPage = pageNo;
    console.log("Loading notices for page:", pageNo);

    const searchWord = document.querySelector("#searchWord").value;
    pageSize = parseInt(document.querySelector("#pageSize").value);  // 페이지 크기 설정

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
            totalPages = Math.ceil(data.totalCount / pageSize); // 총 페이지 수 계산
            renderPagination(); // 페이지 네비게이션 버튼 렌더링
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
            <td><a href="#" class="notice-title" data-id="${notice.seq}">${notice.title}</a></td>
            <td>${notice.content}</td>
            <td>${notice.userId}</td>
            <td>${notice.boardRegDt}</td>
        `;
        listContainer.appendChild(row);
    });

    // 제목 클릭 이벤트 추가
    document.querySelectorAll('.notice-title').forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault();
            const id = this.getAttribute('data-id');
            loadNoticeById(id);
        });
    });
}

function renderPagination() {
    const paginationContainer = document.getElementById("pagination-container");
    paginationContainer.innerHTML = '';

    // 이전 그룹 버튼
    if (currentPageGroup > 1) {
        paginationContainer.innerHTML += `<button class="page-button" data-page="prev-group">이전</button>`;
    }

    // 페이지 번호 버튼들
    const startPage = (currentPageGroup - 1) * pageGroupSize + 1;
    const endPage = Math.min(totalPages, currentPageGroup * pageGroupSize);

    for (let i = startPage; i <= endPage; i++) {
        if (i === currentPage) {
            paginationContainer.innerHTML += `<button class="page-button active" data-page="${i}">${i}</button>`;
        } else {
            paginationContainer.innerHTML += `<button class="page-button" data-page="${i}">${i}</button>`;
        }
    }

    // 다음 그룹 버튼
    if (totalPages > currentPageGroup * pageGroupSize) {
        paginationContainer.innerHTML += `<button class="page-button" data-page="next-group">다음</button>`;
    }

    // 페이지 버튼 클릭 이벤트 추가
    document.querySelectorAll('.page-button').forEach(button => {
        button.addEventListener('click', function() {
            const page = this.getAttribute('data-page');
            if (page === 'prev-group' && currentPageGroup > 1) {
                currentPageGroup--;
                loadNotices((currentPageGroup - 1) * pageGroupSize + 1);
            } else if (page === 'next-group' && totalPages > currentPageGroup * pageGroupSize) {
                currentPageGroup++;
                loadNotices(currentPageGroup * pageGroupSize + 1);
            } else if (page !== 'prev-group' && page !== 'next-group') {
                loadNotices(parseInt(page));
            }
        });
    });
}

function handleSearch() {
    currentPageGroup = 1; // 검색 시 페이지 그룹을 첫 그룹으로 설정
    loadNotices(1);  // 검색 버튼 클릭 시 첫 페이지 로드
}

function loadNoticeById(seq) {
    fetch(`/doma/admin/getNoticeById.do?seq=${seq}`)
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
            console.log('Notice details:', data);
            fillForm(data);  // 폼에 데이터를 채우기
        })
        .catch(error => {
            console.error('Error fetching notice details:', error);
        });
}

function fillForm(notice) {
    document.querySelector('#title').value = notice.title;
    document.querySelector('#content').value = notice.content;
}

//등록
document.addEventListener('DOMContentLoaded', function () {
    document.querySelector('.member-action-button').addEventListener('click', function() {
        submitNotice();
    });
});

function submitNotice() {
    // 폼 요소 가져오기
    var title = document.getElementById('title').value.trim();
    var content = document.getElementById('content').value.trim();

    // 유효성 검사
    if (!title || !content) {
        alert('제목과 내용을 입력하세요.');
        return;
    }

    // 공지사항 데이터 객체 생성
    var noticeData = {
        title: title,
        content: content
        // 추가적인 필드가 필요하다면 여기에 추가하세요
    };

    // AJAX 요청
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/doma/admin/addNotice.do', true);
    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.status === 'success') {
                    alert(response.message);
                    // 성공 시 페이지를 새로고침하거나, 다른 페이지로 리다이렉트할 수 있습니다.
                    window.location.reload();
                } else {
                    alert(response.message);
                }
            } else {
                alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
            }
        }
    };

    xhr.send(JSON.stringify(noticeData));
}