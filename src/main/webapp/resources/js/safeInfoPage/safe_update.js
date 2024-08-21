document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");

	const seqInput = document.querySelector("#seq");
    const divInput = document.querySelector("#boardDiv");
    const titleInput = document.querySelector("#title");
    const userIdInput = document.querySelector("#userId");
    const imgLinkInput = document.querySelector("#imgLink");
    const contentsTextArea = document.querySelector("#content");
    
    //이미지 파일처리
    const form = document.querySelector("form");
    const fileInput = document.querySelector("input[type='file']");
    const fileNameInput = document.querySelector("#fileName");
    
    const doUpdateBtn = document.querySelector("#doUpdate");
    const moveToListBtn = document.querySelector("#moveToList");
       
    moveToListBtn.addEventListener("click",function(event){
        console.log("moveToListBtn click");
        event.stopPropagation();
        if(confirm("목록 으로 이동 하시겠습니까?") === false)return;
        moveToList();
    });
	
    doUpdateBtn.addEventListener("click", function(event){
        console.log("doUpdateBtn click");     
        doUpdate();
    });
	    
    
    function moveToList() { 
        window.location.href = "/doma/safe/safePage.do";
    }
	
		function doUpdate(){
		
		if(isEmpty(imgLinkInput.files[0]) == true){
            alert('사진을 선택 하세요.')
            imgLinkInput.focus();
            return;
        }
		
        console.log("doUpdate()");
        console.log("seqInput : " + seqInput);
        console.log("seqInput : " + seqInput.value);
        console.log("divInput : " + divInput.value);
        console.log("titleInput : " + titleInput.value);
        console.log("userIdInput : " + userIdInput.value);
	    console.log("imgLinkInput.files[0]", imgLinkInput.files[0]);
        console.log("simplemde", simplemde.value());
        
        if(confirm("수정 하시겠습니까?") === false)return;
		
        // FormData 객체 생성
	    let formData = new FormData();
	    formData.append("seq", seqInput.value);
	   	formData.append("div", divInput.value);
		formData.append("title", titleInput.value);
		formData.append("userId", userIdInput.value);
		formData.append("content", simplemde.value());
		formData.append("imgFile", imgLinkInput.files[0]);  // file이 서버에서 받는 MultipartFile의 키와 일치
		
		if (fileInput.files.length > 0) {
	        formData.append("imgFile", imgLinkInput.files[0]);
	    }

         $.ajax({
	        url: "/doma/safe/doUpdate.do",
	        type: "POST",
	        data: formData,
	        processData: false,  // FormData가 자동으로 처리되지 않도록 설정
	        contentType: false,  // 콘텐츠 타입을 자동으로 설정하지 않도록 설정
	        success: function(data) {
	        	
	        	console.log("서버 응답 데이터:", data);  // 응답 데이터를 직접 확인
	        	 
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