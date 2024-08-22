/**
 * 
 */

document.addEventListener("DOMContentLoaded", function(){
  console.log(userId);
    console.log("DOMContentLoaded");    
    //seq
    const userIdInput = document.querySelector("#userId");
     
    const userNameInput = document.querySelector("#userName");
     
    const userPwInput = document.querySelector("#userPw");
      
    const gradeInput = document.querySelector("#grade");
    const birthInput = document.querySelector("#birth");
    const addressInput = document.querySelector("#address");
    const detailAddressInput = document.querySelector("#detailAddress");
   
	const addrInput = document.querySelector("#sample4_roadAddress");
	const detailAddrInput = document.querySelector("#sample4_detailAddress");
	


    const seqInput = document.querySelector("#seq");
    const titleInput = document.querySelector("#title");
    const gnameInput = document.querySelector("#gname");
    const viewsInput = document.querySelector("#views");

	//----비번
	const passwordCheckInput = document.querySelector("#passwordCheck");
	const passwordCheckBtn =  document.querySelector("#passwordDuplicateCheck");
	console.log("passwordCheckBtn", passwordCheckBtn);
	
	//비밀번호 확인 버튼
	let idCheckCount = 0;
	let passwordCheckCount = 0;
	  
    const doUpdateBtn = document.querySelector("#updateInfo");
    const doDeleteBtn = document.querySelector("#deleteInfo"); 

    const boardBtn = document.querySelector("#MoveBoard");
    console.log("boardBtn:", boardBtn);

    const commentBtn = document.querySelector("#MoveComment");
    console.log("commentBtn:", commentBtn);


    commentBtn.addEventListener("click",function(event){
      console.log("commentBtn click");
      
      MoveComment();
    });


    boardBtn.addEventListener("click",function(event){
      console.log("boardBtn click");
      
      MoveBoard();
    });
	
	 



    doUpdateBtn.addEventListener("click",function(event){
		console.log("doUpdateBtn click");
		passwordCheck();
		updateInfo();
	});

    doDeleteBtn.addEventListener("click",function(event){
		console.log("doDeleteBtn click");
		
		deleteInfo();
	});
	
	
	//----비번
	function passwordCheck() {
		console.log("passwordCheck()");
		console.log("userPwInput.value : " + userPwInput.value);
		//패스워드 인풋
		const pw = userPwInput.value;
		//패스워드 체크 인풋
		const pwc = passwordCheckInput.value;

		console.log("pw : " + pw);
		console.log("pwc : " + pwc);

		if(pw.indexOf(" ") !== -1 || pwc.indexOf(" ") !== -1){
			alert("비밀번호와 비밀번호 확인에 공백 문자가 있습니다.");
			userPwInput.focus();
			return false;
		}

		if(passwordValidation(pw) === false){
			alert("숫자,특수문자나 대소문자를 포함한 8~20자 이내의 비밀번호를 사용하세요.(ex.@$!%*#?&)"); 
			return;
		}

		 // 길이 체크 (8자리 ~ 20자리)
		 if (userPw.length < 8 || userPw.length > 20) {
			alert("비밀번호는 8자리에서 20자리 사이여야 합니다.");
			userPwInput.focus();
			return;
		}

		if(userPwInput.value === passwordCheckInput.value){	
			passwordCheckCount = 1;
			alert("비밀번호가 일치합니다.");
		}else{
			alert("비밀번호가 일치하지 않습니다.");
			return;
		}
		
	}
  function passwordValidation(input) {
		return /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/.test(input);
	}

  function MoveComment(userId){ 
        //frm.pageNo.value = 1; 
        //window.location.href = "/doma/doma/mpSelect.do?userId="+userId;
        window.location.href = '/doma/mypage/mpCommentSelect.do?userId='+userIdInput.value;
        // 팝업 창으로 열기
        //window.open('/doma/mypage/mpSelect.do?userId=' + userIdInput.value, 'popupWindow', 'width=600,height=400,scrollbars=yes');

        
}
  function MoveBoard(userId){ 
           //frm.pageNo.value = 1; 
          //window.location.href = "/doma/doma/mpSelect.do?userId="+userId;
          window.location.href = '/doma/mypage/mpSelect.do?userId='+userIdInput.value;
          // 팝업 창으로 열기
          //window.open('/doma/mypage/mpSelect.do?userId=' + userIdInput.value, 'popupWindow', 'width=600,height=400,scrollbars=yes');


  }



	
	function updateInfo(){
    console.log("doUpdate()");
        //필수 입력 처리

        if(isEmpty(userNameInput.value) == true){
            alert("이름을 입력 하세요.");
            userNameInput.focus();
            return;
        } 
        if(isEmpty(userPwInput.value) == true){
            alert("비밀번호를 입력 하세요.");
            userPwInput.focus();
            return;
        } 
        
         
        
        if(passwordCheckCount != 1){
			console.log("passwordCheckCount : " + passwordCheckCount);
			alert("비밀번호가 일치하는지 확인하세요.");
			return;
		}
             
               
        if(isEmpty(birthInput.value) == true){
          alert("생년월일을 입력 하세요.");
          birthInput.focus();
          return;
      } 
        if(isEmpty(addrInput.value) == true){
        alert("주소 입력 하세요.");
        addressInput.focus();
        return;
        }  

        if(isEmpty(detailAddrInput.value) == true){
        alert("상세주소 입력 하세요.");
        detailAddressInput.focus();
        return;
        }


        //비동기 통신
        let type= "POST";  
        let url = "/doma/mypage/doUpdate.do";
        let async = "true";
        let dataType = "html";
         
                                
        let params = { 
            "userId"   :userIdInput.value,
            "userName"     :userNameInput.value,
            "userPw" :userPwInput.value, 
            "birth"    :birthInput.value,
            "address"    :addrInput.value,
            "detailAddress":detailAddrInput.value
            
        };        
        
        if(confirm("수정 하시겠습니까?")===false)return;        
      
        PClass.pAjax(url,params,dataType,type,async,function(data){
          if(data){
            try{ 
                //JSON문자열을 JSON Object로 변환
                const message =JSON.parse(data)     
                console.log("message.messagId:"+message.messagId);
                console.log("message.messageContents:"+message.messageContents);
                if(isEmpty(message) === false && 1 === message.messagId){   
                   alert(message.messageContents);
                   window.location.href = '/doma/mypage/myPage.do';
                }else{
                   alert(message.messageContents);
                   window.location.href = '/doma/mypage/myPage.do';
                }          
            }catch(e){
               console.error("data가 null혹은, undefined 입니다.",e);
               alert("data가 null혹은, undefined 입니다.");     
            }         
          }        
        
        });
        
    }

    function deleteInfo(){
      console.log("mpGradeUp()");
          //필수 입력 처리
   
  			
          //비동기 통신
          let type= "POST";  
          let url = "/doma/mypage/mpGradeUp.do";
          let async = "true";
          let dataType = "html";
          let gradeValue = "";  
                                  
          let params = { 
               "userId"   :userIdInput.value,
            "userName"     :userNameInput.value,
            "userPw" :userPwInput.value, 
            "birth"    :birthInput.value,
            "address"    :addrInput.value,
            "detailAddress":detailAddrInput.value
              
          };        
          
          if(confirm("탈퇴 하시겠습니까?")===false)return;        
        
          PClass.pAjax(url,params,dataType,type,async,function(data){
            if(data){
              try{ 
                  //JSON문자열을 JSON Object로 변환
                  const message =JSON.parse(data)     
                  console.log("message.messagId:"+message.messagId);
                  console.log("message.messageContents:"+message.messageContents);
                  if(isEmpty(message) === false && 1 === message.messagId){   
                     alert(message.messageContents);
                     window.location.href = '/doma/user/loginPage.do';
                  }else{
                     alert(message.messageContents);
                     window.location.href = '/doma/user/loginPage.do';
                     
                  }          
              }catch(e){
                 console.error("data가 null혹은, undefined 입니다.",e);
                 alert("data가 null혹은, undefined 입니다.");     
              }         
            }        
          
          });
          
      }

     



});