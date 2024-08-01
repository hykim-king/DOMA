

document.addEventListener("DOMContentLoaded", function(){
	console.log("────────DOMContentLoaded────────");
	
	//버튼 변수
	const registerBtn = document.querySelector("#register");
	console.log("registerBtn is ready!");
	
	const loginBtn = document.querySelector("#login");
	console.log("loginBtn is ready!");
	
	//인풋 변수
	const userIdInput = document.querySelector("#userId");
	console.log("userIdInput : " + userIdInput);
	const passwordInput = document.querySelector("#password");
	console.log("passwordInput : " + passwordInput);
	
	//이벤트 리스너
	registerBtn.addEventListener("click", function(event){
		console.log("registerBtn clicked");
		
		register()
	});
	
	loginBtn.addEventListener("click", function(event){
		console.log("loginBtn clicked");
		
		login()
	});
	
	//함수
	function register() {
		console.log("register()");
		alert("회원가입 페이지로 이동합니다");
		window.location.href= "/doma/user/doRegister.do";
	}
	
	function login() {
		console.log("login()");
		
		if(isEmpty(userIdInput.value) == true){
			alert("아이디를 입력하세요.");
			userIdInput.focus();
			return;
		}
		
		if(isEmpty(passwordInput.value) == true){
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
                    	console.log(message.messageContent);
                    	console.log(message.messageId);
                        alert(message.messageContents);
                        moveToPage();
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
      
      function moveToPage() {
		console.log("moveToPage()");
		
		let type="POST";
        let url ="/doma/user/moveToPage.do";
        let async = "true";
        let dataType = "html";

        let params = {
            "userId" : userIdInput.value,
            "userName" : userNameInput.value
        }

        PClass.pAjax(url,params,dataType,type,async,function(data){
            if(data){
                try{
                    //문자열 Json Object로 변환
                    const message = JSON.parse(data);
                    if(isEmpty(message) === false && 1== message.messageId){
                    	console.log(message.messageContent);
                    	console.log(message.messageId);
                        alert(message.messageContents);
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
});