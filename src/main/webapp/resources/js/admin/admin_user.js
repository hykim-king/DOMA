document.addEventListener('DOMContentLoaded', function() {
    loadUsers(1); // 페이지 로딩 시 사용자 목록을 로드
});
let currentPage = 1;
let pageSize = 5; // 페이지 크기
let totalPages = 1; // 총 페이지 수
let pageGroupSize = 5; // 페이지 그룹당 버튼 수
let currentPageGroup = 1; // 현재 페이지 그룹

function loadUsers(pageNo) {
    /*fetch('/doma/admin/doRetrieveUsers.do')
        .then(response => {
            if (response.ok) {
                return response.json();
            } else {
                return response.text().then(text => {
                    throw new Error(`Server responded with status ${response.status}: ${text}`);
                });
            }
        })
        .then(data => {
            console.log('Users:', data.users);
            displayUsers(data.users);
        })
        .catch(error => {
            console.error('Error fetching users:', error);
        }); */
        
    currentPage = pageNo;
    console.log("Loading notices for page:", pageNo);

    const searchWord = document.querySelector("#searchWord").value;
    pageSize = parseInt(document.querySelector("#pageSize").value);  // 페이지 크기 설정

    const params = new URLSearchParams({
        pageNo: pageNo,
        pageSize: pageSize,
        searchWord: searchWord
    });

    fetch(`/doma/admin/doRetrieveUsers.do?${params.toString()}`)  // 데이터가 있는 엔드포인트로 요청
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
            displayUsers(data.users);  // 데이터를 가져와서 테이블에 표시
            totalPages = Math.ceil(data.totalCount / pageSize); // 총 페이지 수 계산
            renderPagination(); // 페이지 네비게이션 버튼 렌더링
        })
        .catch(error => {
            console.error('Error fetching notices:', error);
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
                loadUsers((currentPageGroup - 1) * pageGroupSize + 1);
            } else if (page === 'next-group' && totalPages > currentPageGroup * pageGroupSize) {
                currentPageGroup++;
                loadUsers(currentPageGroup * pageGroupSize + 1);
            } else if (page !== 'prev-group' && page !== 'next-group') {
                loadUsers(parseInt(page));
            }
        });
    });
}
function displayUsers(users) {
    const userContainer = document.getElementById("user-container");
    userContainer.innerHTML = ''; // 이전 사용자 목록 제거

    users.forEach(user => {
        const row = document.createElement("tr");
        row.innerHTML = `
            <td>${user.userId}</td>
            <td>${user.userName}</td>
            <td>${user.userRegDt}</td>
            <td>${user.userCelDt ? user.userCelDt : '활성'}</td>
        `;
        userContainer.appendChild(row);
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
                loadUsers((currentPageGroup - 1) * pageGroupSize + 1);
            } else if (page === 'next-group' && totalPages > currentPageGroup * pageGroupSize) {
                currentPageGroup++;
                loadUsers(currentPageGroup * pageGroupSize + 1);
            } else if (page !== 'prev-group' && page !== 'next-group') {
                loadUsers(parseInt(page));
            }
        });
    });
}
function handleSearch() {
    currentPageGroup = 1; // 검색 시 페이지 그룹을 첫 그룹으로 설정
    loadUsers(1);  // 검색 버튼 클릭 시 첫 페이지 로드
}
