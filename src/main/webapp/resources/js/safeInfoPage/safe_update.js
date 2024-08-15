document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");

	const seqInput = document.querySelector("seq");
    const divInput = document.querySelector("#boardDiv");
    const titleInput = document.querySelector("#title");
    const userIdInput = document.querySelector("#userId");
    const imgLinkInput = document.querySelector("#imgLink");
    const contentsTextArea = document.querySelector("#content");
    
    
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
        console.log("doUpdate()");
        console.log("divInput : " + divInput.value);
        console.log("titleInput : " + titleInput.value);
        console.log("userIdInput : " + userIdInput.value);
        console.log("imgLinkInput : " + imgLinkInput.value);
        console.log("simplemde", simplemde.value());
        
        if(confirm("수정 하시겠습니까?") === false)return;
        
        //비동기 통신
        let type = "POST";
        let url = "/doma/safe/doUpdate.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
        	"seq" : seqInput.value,
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