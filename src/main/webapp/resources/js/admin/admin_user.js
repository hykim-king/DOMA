// JavaScript 파일 (예: admin_user.js)
document.addEventListener('DOMContentLoaded', function() {
    loadUsers(1); // 페이지 로딩 시 사용자 목록을 로드
});

function loadUsers() {
    fetch('/doma/admin/doRetrieveUsers.do')
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
