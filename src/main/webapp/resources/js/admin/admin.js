document.addEventListener('DOMContentLoaded', function() {
    checkUserPermission(); // 페이지 로드 시 권한 확인
});

function checkUserPermission() {
    fetch('/doma/admin/checkUserPermission.do')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'error') {
                alert(data.message); // 오류 메시지 표시
                window.location.href = '/doma/main/main.do'; // 메인 페이지로 리다이렉트
            } else {
                loadNotices(1); // 권한이 있으면 공지사항 로드
            }
        })
        .catch(error => {
            console.error('Error checking user permission:', error);
            alert('권한 확인 중 오류가 발생했습니다.');
            window.location.href = '/doma/main/main.do'; // 메인 페이지로 리다이렉트
        });
}

document.addEventListener('DOMContentLoaded', function() {
    loadNotices(1);
});
let btnflg = 0; //0일때 비활성화, 1일때 저장
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
        // 날짜만 추출 
        const boardRegDateOnly = notice.boardRegDt.split(' ')[0];

        // 제목과 내용을 6글자로 제한
        const truncatedTitle = notice.title.length > 6 ? notice.title.substring(0, 10) + '...' : notice.title;
        const truncatedContent = notice.content.length > 6 ? notice.content.substring(0, 10) + '...' : notice.content;

        const row = document.createElement("tr");
        row.innerHTML = `
            <td>${notice.rn}</td>
            <td><a href="#" class="notice-title" data-id="${notice.seq}">${truncatedTitle}</a></td>
            <td>${truncatedContent}</td>
            <td>${notice.userId}</td>
            <td>${boardRegDateOnly}</td>
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
    var button = document.querySelector('.member-action-button');
    if (button) {
        button.addEventListener('click', function() {
            button.disabled = true; // 버튼 비활성화
            if (btnflg==1) {
                submitNotice();
            }
        });
    }
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
    };

    // AJAX 요청
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/doma/admin/addNotice.do', true);
    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
    btnflg=0;
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.status === 'success') {
                    alert(response.message);
                    window.location.reload();
                } else {
                    alert(response.message);
                }
            } else {
                alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
            }
            // 버튼을 다시 활성화
            document.querySelector('.member-action-button').disabled = false;
        }
    };

    xhr.send(JSON.stringify(noticeData));
}


//수정
let originalTitle = '';
let originalContent = '';

// 게시글 상세 정보를 로드할 때 원래 제목과 내용 저장
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
            fillForm(data); 
            originalTitle = data.title;
            originalContent = data.content;
        })
        .catch(error => {
            console.error('Error fetching notice details:', error);
        });
}

function fillForm(notice) {
    document.querySelector('#title').value = notice.title;
    document.querySelector('#content').value = notice.content;
}

function handleUpdate() {
    const title = document.getElementById('title').value;
    const content = document.getElementById('content').value;
    const seq = document.querySelector('.notice-title').getAttribute('data-id'); // 제목 링크의 data-id 속성에서 seq 값을 가져오기

    if (!title || !content || !seq) {
        console.error("One or more fields are missing.");
        return;
    }

    // 제목과 내용이 변경되었는지 확인
    if (title === originalTitle && content === originalContent) {
        alert('수정사항을 입력해주세요.');
        return;
    }

    // AJAX 요청을 통해 서버에 수정 요청을 보냅니다.
    fetch('/doma/admin/updateNotice.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            title: title,
            content: content,
            seq: seq
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            alert(data.message);
            location.reload();
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('AJAX Error:', error);
        alert('공지사항 수정에 실패했습니다.');
    });
}


//삭제
// 전역 변수로 seq 값 저장
let currentSeq = null;

// 게시글 상세 정보를 로드할 때 seq 값을 설정
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
            fillForm(data);
            originalTitle = data.title;
            originalContent = data.content;
            currentSeq = data.seq; // seq 값을 전역 변수에 저장
        })
        .catch(error => {
            console.error('Error fetching notice details:', error);
        });
}

function fillForm(notice) {
    document.querySelector('#title').value = notice.title;
    document.querySelector('#content').value = notice.content;
}

function handleDelete() {
    if (currentSeq === null) {
        console.error("Seq is not defined.");
        return;
    }

    // 삭제 확인 대화상자 표시
    const confirmation = confirm("정말로 삭제하시겠습니까?");
    if (!confirmation) {
        // 사용자가 삭제를 취소한 경우
        return;
    }

    // 삭제 요청을 보내는 AJAX 호출
    fetch(`/doma/admin/deleteNotice.do?seq=${currentSeq}`, {
        method: 'DELETE',
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            alert(data.message);
            location.reload(); // 페이지 새로 고침
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('AJAX Error:', error);
        alert('공지사항 삭제에 실패했습니다.');
    });
}
