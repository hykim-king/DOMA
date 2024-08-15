	const seqInput = document.querySelector("#seq");
	const titleInput = document.querySelector("#title").innerText;
	
	function moveToList() {
        window.location.href = "/doma/safe/safePage.do";
    }
	
	function updatePage(){
		console.log("doUpdate()");
		console.log("seqInput : " + seqInput);
		console.log("titleInput : " + titleInput);
		
		window.location.href = "/doma/safe/updatePage.do?seq="+seqInput.value ;	
	}
	
	function doDelete(){
		console.log("doDelete()");
		console.log("seqInput : " + seqInput);
		console.log("titleInput : " + titleInput);
		
	    let type="GET";
	    let url ="/doma/safe/doDelete.do";
	    let async = "true";
	    let dataType = "html";
	
	    let params = {
	        "seq": seqInput.value,
	        "title" : titleInput
	    };
	    if(confirm("삭제 하시겠습니까?") === false)return;
	
	    PClass.pAjax(url,params,dataType,type,async,function(data){
	        if(data){
	            try{
	                //문자열 Json Object로 변환
	                const message = JSON.parse(data);
	                if(isEmpty(message) === false && 1== message.messageId){
	                    console.log(message.messageContent);
	                    console.log(message.messageId);
	                    alert(message.messageContents);
	                    window.location.href="/doma/safe/safePage.do";
	                }else{
	                    alert(message.messageContents);
	                }
	            }catch(e){
	                console.error("data가 null 혹은, undefined 입니다");
	                alert("일치하지 않는 아이디 혹은 비밀번호입니다.");
	            }
	        }else{
	            console.log("else");
	            alert("data가 null 혹은, undefined 입니다.");
	        }
	    });
	}