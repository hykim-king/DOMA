	
 document.addEventListener("DOMContentLoaded", function(){
	
	const idInput = document.querySelector("#id");
	const nameInput = document.querySelector("#name");
	const passwordInput = document.querySelector("#password");
	const passwordCheckInput = document.querySelector("#passwordCheck");
	const birthInput = document.querySelector("#birth");
	const addrInput = document.querySelector("#sample4_roadAddress");
	const detailAddrInput = document.querySelector("#sample4_detailAddress");
	
	//비밀번호 확인 버튼
	let idCheckCount = 0;
	let passwordCheckCount = 0;
	
	//변수
	const doSaveBtn = document.querySelector("#doSave");
	const idCheckBtn =  document.querySelector("#idDuplicateCheck");
	
	//이벤트 리스너
	doSaveBtn.addEventListener("click",function(event){
		doSave();
	});
	
	idCheckBtn.addEventListener("click",function(event){
		idCheck();
	});
	
	  
	function doSave() {
        const minDate = "1907-01-01";
        const maxDate = "2024-08-01";
        
		if(isEmpty(idInput.value) == true){
			alert("사용하실 아이디를 입력하세요.");
			idInput.focus();
			return;
		}
		if(idInput.value.indexOf(" ") !== -1){
			alert("아이디에 공백 문자가 있습니다.");
			idInput.focus();
			return;
		}
		if(isEmpty(nameInput.value) == true){
			alert("사용하실 닉네임을 입력하세요.");
			nameInput.focus();
			return;
		}
		if(isEmpty(passwordInput.value) == true){
			alert("비밀번호를 입력하세요.");
			passwordInput.focus();
			return;
		}
		if(isEmpty(passwordCheckInput.value) == true){
			alert("비밀번호를 확인하세요");
			passwordCheckInput.focus();
			return;
		}
		if(isEmpty(birthInput.value) == true){
			alert("생년월일을 입력하세요.");
			birthInput.focus();
			return;
		}
		
		birthInput.setAttribute("min", minDate);
        birthInput.setAttribute("max", maxDate);
        
        
		if (birthInput.value < minDate || birthInput.value > maxDate) {
            alert("생년월일은" + minDate + "~" + maxDate + "내로 입력 가능합니다.");

            return;
        }
		
		if(isEmpty(addrInput.value) == true){
			alert("주소를 입력하세요.");
			addrInput.focus();
			return;
		}
		if(isEmpty(detailAddrInput.value) == true){
			alert("상세주소를 입력하세요.");
			detailAddrInput.focus();
			return;
		}
		
		if(idCheckCount != 1){
			console.log("idCheckCount : " + idCheckCount);
			alert("아이디 중복을 확인하세요.");
			return;
		}
		
		if(passwordInput.value !== passwordCheckInput.value){
			alert("비밀번호가 일치하는지 확인하세요.");
			return;
		}
		
		if(passwordInput.value.indexOf(" ") !== -1 || passwordCheckInput.value.indexOf(" ") !== -1){
			alert("비밀번호와 비밀번호 확인에 공백 문자가 있습니다.");
			passwordInput.focus();
			return;
		}

		if(passwordValidation(passwordInput.value) === false && (passwordInput.value.length < 8 || passwordInput.value.length > 20)){
			alert("특수문자나 대소문자를 포함한 8~20자 이내의 비밀번호를 사용하세요."); 
			return;	
		}

		let type="POST";
        let url ="/doma/user/doSave.do";
        let async = "true";
        let dataType = "html";

        if(confirm("등록 하시겠습니까?") === false)return;

        let params = {
            "userId" : idInput.value,
            "userName" : nameInput.value,
            "userPw" : passwordInput.value,
            "birth" : birthInput.value,
            "address" : addrInput.value,
            "detailAddress" : detailAddrInput.value
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
                        window.location.href="/doma/user/loginPage.do";
                    }else{
                        alert(message.messageContents);
                    }
                }catch(e){
                    console.error("data가 null 혹은, undefined 입니다");
                    alert("이미 존재하는 아이디입니다.");
                }
            }else{
                console.log("else");
                alert("data가 null 혹은, undefined 입니다.");
            }
        });
	}
	
	function idCheck() {
		console.log("idCheck()");
		
		const usernamePattern = /^[a-zA-Z0-9]+$/;

        if (!usernamePattern.test(idInput.value)) {
            // 유효하지 않은 경우 경고 메시지 표시
            alert("아이디는 영어와 숫자만 가능합니다.");

            // 폼 제출 중단
            event.preventDefault();
            return;
        }
		if (idInput.value !== "" && idInput.value.length >= 4 && idInput.value.length <= 16) {
		    if (/\s/.test(idInput.value)) {
		        alert("아이디에는 공백을 사용할 수 없습니다.");
		        idInput.focus();
		        return;
		    }
		} else {
		    alert("아이디는 4~16자 이내, 특수문자와 한글은 사용불가합니다.");
		    idInput.focus();
		    return;
		}
		onlyNumberAndEnglish(idInput.value);
		
		let type="get";
        let url ="/doma/user/idCheck.do";
        let async = "true";
        let dataType = "html";

        if(confirm("아이디를 사용하시겠습니까?") === false)return;

        let params = {
            "userId" : idInput.value 
        }
		
		console.log("idInput : " + idInput.value);
		 
        PClass.pAjax(url,params,dataType,type,async,function(data){
            if(data){
                try{
                    //문자열 Json Object로 변환
                    const message = JSON.parse(data);
                    if(isEmpty(message) === false && 1== message.messageId){
                    	console.log(message.messageContents);
                    	console.log(message.messageId);
                        alert(message.messageContents);
                        idCheckCount= 1;
                        console.log("idCheckCount : " + idCheckCount); 
                    }else{
                        alert(message.messageContents);
                        console.log("idCheckCount : " + idCheckCount);
                             
                    }
                }catch(e){
                    console.error("JSON 파싱 오류:", e);
                    alert("이미 존재하는 아이디입니다.");
                }
            }else{
                console.log("else");
                alert("data가 null 혹은, undefined 입니다.");
            }
        });
	}
	
	
	function onlyNumberAndEnglish(input) {
  		return /^[A-Za-z0-9][A-Za-z0-9]*$/.test(input);
	}  
	
	function passwordValidation(input) {
		return /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/.test(input);
	}
	
});
        