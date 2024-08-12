document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");

    const divInput = document.querySelector("#boardDiv");
    const titleInput = document.querySelector("#title");
    const userIdInput = document.querySelector("#userId");
    const imgLinkInput = document.querySelector("#imgLink");
    const contentsTextArea = document.querySelector("#content");
    
    
    const doSaveBtn = document.querySelector("#doSave");
    const moveToListBtn = document.querySelector("#moveToList");
       
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
	
	function doSave(){
        console.log("doSave()");
        
        if(isEmpty(titleInput.value) == true){
            alert('제목을 입력 하세요.')
            titleInput.focus();
            return;
        }
        
        if(isEmpty(simplemde.value()) == true){
            alert('내용을 입력 하세요.')
            contentsTextArea.focus();
            return;
        }
        
        console.log("simplemde", simplemde.value());
        if(confirm("등록 하시겠습니까?") === false)return;
        
        //비동기 통신
        let type = "POST";
        let url = "/doma/safe/save.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
       		"div"   : divInput.value,
            "title"    : titleInput.value,
            "userId"    : userIdInput.value,
            "content" : simplemde.value(),
            "imgLink" : imgLinkInput.value
        };

        PClass.pAjax(url, params, dataType, type, async, function(data){
            if(data){
                try{
                    //JSON문자열을 JSON Object로 변환
                    const message = JSON.parse(data)
                    if(isEmpty(message) === false && 1 === message.messageId){
                        alert(message.messageContents);
                        window.location.href ="/doma/safe/safePage.do";
                    }else{
                        alert(message.messageContents);
                    }
                    
                }catch(e){
                    alert("data를 확인 하세요");
                }
            }
        });
    }
	
	
    
});