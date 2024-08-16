document.addEventListener('DOMContentLoaded', function() {
    loadUsers(1); // 페이지 로딩 시 사용자 목록을 로드
});

let currentPage = 1;
let pageSize = 5; // 페이지 크기
let totalPages = 1; // 총 페이지 수
let pageGroupSize = 5; // 페이지 그룹당 버튼 수
let currentPageGroup = 1; // 현재 페이지 그룹

function loadUsers(pageNo) {
    currentPage = pageNo;
    console.log("Loading users for page:", pageNo);

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
            console.log('Users:', data);
            displayUsers(data.users);  // 데이터를 가져와서 테이블에 표시
            totalPages = Math.ceil(data.totalCount / pageSize); // 총 페이지 수 계산
            renderPagination(); // 페이지 네비게이션 버튼 렌더링
        })
        .catch(error => {
            console.error('Error fetching users:', error);
        });
}

function displayUsers(users) {
    const userContainer = document.getElementById("user-container");
    userContainer.innerHTML = ''; // 이전 사용자 목록 제거

    users.forEach(user => {
        // 날짜만 추출
        const userRegDateOnly = user.userRegDt.split(' ')[0];

        const row = document.createElement("tr");
        row.innerHTML = `
            <td><a href="#" class="user-id" data-id="${user.userId}">${user.userId}</a></td>
            <td>${user.userName}</td>
            <td>${userRegDateOnly}</td>
            <td>${user.userCelDt ? '비활성' : '활성'}</td>
        `;
        userContainer.appendChild(row);
    });

    // 클릭 이벤트 리스너 추가
    document.querySelectorAll('.user-id').forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 링크 클릭 동작 방지
            const userId = this.getAttribute('data-id');
            loadUserDetails(userId);
        });
    });
}

//유저 정보 리스트업
function loadUserDetails(userId) {
    fetch(`/doma/admin/doSelectUser.do?userId=${userId}`) 
        .then(response => response.json())
        .then(data => {
            console.log('User Details:', data);
            displayUserDetails(data);
        })
        .catch(error => {
            console.error('Error fetching user details:', error);
        });
}

function displayUserDetails(user) {
    // 각 form-group의 input 필드에 유저 정보를 설정
    document.getElementById('memberId').value = user.userId;
    document.getElementById('name').value = user.userName;
    document.getElementById('address').value = user.userAddress;
    document.getElementById('detailAddress').value = user.userDetailAddress;
    document.getElementById('birthdate').value = user.userBirth;
    document.getElementById('joinDate').value = user.userRegDt.split(' ')[0];
    
    // userCelDt가 null인 경우 '활성'으로, 그렇지 않으면 '비활성 : userCelDt'로 설정
    const celdtValue = user.userCelDt ? `비활성 : ${user.userCelDt}` : '활성';
    document.getElementById('celdt').value = celdtValue;
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

//회원수정
function updateUser() {
    // 수정할 데이터 수집
    const userId = document.getElementById('memberId').value;
    const userName = document.getElementById('name').value || null;
    const userBirth = document.getElementById('birthdate').value || null;
    const userAddress = document.getElementById('address').value || null;
    const userDetailAddress = document.getElementById('detailAddress').value || null;

    // 수정할 내용이 있는지 확인
    if (!userName && !userBirth && !userAddress && !userDetailAddress) {
        alert('수정 실패: 수정사항을 입력해주세요.');
        return; // 수정 요청을 보내지 않음
    }

    const user = {
        userId: userId,
        userName: userName,
        userBirth: userBirth,
        userAddress: userAddress,
        userDetailAddress: userDetailAddress
    };

    fetch('/doma/admin/updateUser.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(user)
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            alert(data.message); // 성공 메시지
            // 페이지를 새로 고침하여 최신 상태를 반영
            window.location.reload(); // 현재 페이지를 새로 고침
        } else {
            alert(data.message); // 오류 메시지
        }
    })
    .catch(error => {
        console.error('Error updating user:', error);
        alert('데이터 업데이트 중 문제가 발생했습니다. 잠시 후 다시 시도해 주세요.'); // 네트워크 오류 처리
    });
}

//회원 삭제
function deleteUser() {
    const userId = document.getElementById('memberId').value; // 현재 폼에 표시된 userId를 가져옴
    if (!userId) {
        alert("User ID not found. Please select a valid user.");
        return;
    }

    // 삭제 확인 메시지 표시
    const confirmDelete = confirm("정말로 해당 회원을 삭제하시겠습니까?");
    if (!confirmDelete) {
        return; // 사용자가 취소를 누르면 삭제 중단
    }

    console.log("Deleting user with ID:", userId); // 디버깅용 로그

    fetch('/doma/admin/deleteUser.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            'userId': userId
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            alert('회원을 삭제했습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            alert('회원 삭제 실패 : ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error deleting user:', error);
        alert('An unexpected error occurred while deleting the user.');
    });
}













