document.addEventListener('DOMContentLoaded', function() {
    loadNotices();
});

function loadNotices() {
    fetch('doRetrieveNotices.do')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log('Notices:', data);
            // 데이터를 DOM에 삽입하는 코드 추가
        })
        .catch(error => {
            console.error('Error fetching notices:', error);
        });
}
