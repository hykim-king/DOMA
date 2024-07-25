document.addEventListener('DOMContentLoaded', function () {
    const topButton = document.getElementById('top-button');

    window.addEventListener('scroll', function () {
        const scrollPosition = window.scrollY || document.documentElement.scrollTop;
        if (scrollPosition > 200) {
            topButton.style.display = 'block';
        } else {
            topButton.style.display = 'none';
        }
    });

    topButton.addEventListener('click', function (event) {
        event.preventDefault(); // 링크의 기본 동작을 방지
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
});
