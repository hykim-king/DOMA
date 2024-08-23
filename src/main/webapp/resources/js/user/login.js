/**
 * 
 */
 document.addEventListener("DOMContentLoaded", function(){
	
	loginBtn.addEventListener("click",function(event){
		login();
	});
	
	 document.addEventListener("keydown", function(event) {
        if (event.key === "Enter") {
            login(); 
        }
    });
	
	function login() {
		const id = userIdInput.value;
		const pw = passwordInput.value;
		
		if(isEmpty(id) == true){
			alert("아이디를 입력하세요.");
			userIdInput.focus();
			return;
		}
		
		if(isEmpty(pw) == true){
			alert("비밀번호를 입력하세요.");
			passwordInput.focus();
			return;
		}  
		

		let type="POST";
        let url ="/doma/user/Login.do";
        let async = "true";
        let dataType = "html";

        let params = {
            "userId" : userIdInput.value,
            "userPw" : passwordInput.value
        }

        PClass.pAjax(url,params,dataType,type,async,function(data){
            if(data){
                try{
                    //문자열 Json Object로 변환
                    const message = JSON.parse(data);
                    if(isEmpty(message) === false && 1== message.messageId){
                        alert(message.messageContents);
   						window.location.href="/doma/main/main.do";
                    }else{
                        alert(message.messageContents);
                    }
                }catch(e){
                    alert("일치하지 않는 아이디 혹은 비밀번호입니다.");
                }
            }else{
                alert("data가 null 혹은, undefined 입니다.");
            }
        });
   }
   
});