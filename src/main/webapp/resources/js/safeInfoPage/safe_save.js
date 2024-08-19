document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");

    const divInput = document.querySelector("#boardDiv");
    const titleInput = document.querySelector("#title");
    const userIdInput = document.querySelector("#userId");
    const imgLinkInput = document.querySelector("#imgLink");
    const contentsTextArea = document.querySelector("#content");
    
    
    const doSaveBtn = document.querySelector("#doSave");
    const moveToListBtn = document.querySelector("#moveToList");
    
     const form = document.querySelector("form");
    const fileInput = document.querySelector("input[type='file']");
    const fileNameInput = document.querySelector("#fileName");

    form.addEventListener("submit", function(event) {
        const filePath = fileInput.value;
        const fileName = filePath.split('\\').pop();  // 파일 이름 추출
        fileNameInput.value = fileName;
    });   
    
    moveToListBtn.addEventListener("click",function(event){
        console.log("moveToListBtn click");
        event.stopPropagation();
        if(confirm("목록 으로 이동 하시겠습니까?") === false)return;
        moveToList();
    });
	
    doSaveBtn.addEventListener("click", function(event){
        console.log("doSaveBtn click");     
        doSave();
    });
	    
    
    function moveToList() {
        window.location.href = "/doma/safe/safePage.do";
    }
	
	function doSave() {
    console.log("doSave()");
    
    // 제목 입력 검증
    if (isEmpty(titleInput.value)) {
        alert('제목을 입력 하세요.');
        titleInput.focus();
        return;
    }
    
    // 내용 입력 검증
    if (isEmpty(simplemde.value())) {
        alert('내용을 입력 하세요.');
        contentsTextArea.focus();
        return;
    }
    
    console.log("simplemde", simplemde.value());
    if (!confirm("등록 하시겠습니까?")) return;

    // FormData 객체 생성
    let formData = new FormData();
    formData.append("div", divInput.value);
    formData.append("title", titleInput.value);
    formData.append("userId", userIdInput.value);
    formData.append("content", simplemde.value());
    formData.append("imgLink", imgLinkInput.value);
    
    if (fileInput.files.length > 0) {
        formData.append("file", fileInput.files[0]);
    }

    // 비동기 요청 보내기
    let url = "/doma/safe/save.do";

    $.ajax({
        url: url,
        type: "POST",
        data: formData,
        processData: false,  // FormData가 자동으로 처리되지 않도록 설정
        contentType: false,  // 콘텐츠 타입을 자동으로 설정하지 않도록 설정
        success: function(data) {
            if (data) {
                try {
                    // JSON 문자열을 JSON 객체로 변환
                    const message = JSON.parse(data);
                    if (message && message.messageId === 1) {
                        alert(message.messageContents);
                        window.location.href = "/doma/safe/safePage.do";
                    } else {
                        alert(message.messageContents);
                    }
                } catch (e) {
                    alert("데이터를 확인 하세요");
                }
            }
        },
        error: function(xhr, status, error) {
            console.error("요청 실패: " + status + ", " + error);
            alert("요청 처리 중 오류가 발생했습니다.");
        }
    });
}
    
});