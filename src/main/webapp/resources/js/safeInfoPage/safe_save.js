document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");
//객체 생성=================================================================================================    
    const doSaveBtn = document.querySelector("#doSave");
    const moveToListBtn = document.querySelector("#moveToList");
    const titleInput = document.querySelector("#title");
    const userIdInput = document.querySelector("#userId");
    const contentsTextArea = document.querySelector("#content");
    const divInput = document.querySelector("#div");
    const imgLinkInput = document.querySelector("#imgLink");
    //구분
    const searchDivSelect = document.querySelector("#searchDiv");
    
    
//이벤트 처리=================================================================================================    
    
	//구분
    searchDivSelect.addEventListener("change",function(event){
        if("" === searchDivSelect.value){
            searchWordInput.value = "";//검색어
            pageSizeSelect.value  = 10;//페이지 사이즈
        }
    });
	
	//moveToListBtn
    moveToListBtn.addEventListener("click",function(event){
        console.log("moveToListBtn click");
        event.stopPropagation();
        if(confirm("목록 으로 이동 하시겠습니까?") === false)return;
        moveToList();
    });
	
	//등록
    doSaveBtn.addEventListener("click", function(event){
        console.log("doSaveBtn click");     
        doSave();
    });
	
    
    
//함수=================================================================================================    
    
	//moveToList()
    function moveToList() {
        window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
    }
	
	//doSave()
	function doSave(){
        console.log("doSave()");
        
        if(isEmpty(searchDivSelect.value) == true){
            alert('구를 선택 하세요.')
            searchDivSelect.focus();
            return;
        }
        
        if(isEmpty(titleInput.value) == true){
            alert('제목을 입력 하세요.')
            titleInput.focus();
            return;
        }
        
        if(isEmpty(userIdInput.value) == true){
            alert('등록자 아이디를 입력 하세요.')
            userIdInput.focus();
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
        let url = "/doma/board/doSave.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
       		"gname"   : searchDivSelect.value,
            "title"    : titleInput.value,
            "userId"    : userIdInput.value,
            "content" : simplemde.value(),
            "imgLink" : imgLinkInput.value,
            "div"      : divInput.value
        };

        PClass.pAjax(url, params, dataType, type, async, function(data){
            if(data){
                try{
                    //JSON문자열을 JSON Object로 변환
                    const message = JSON.parse(data)
                    if(isEmpty(message) === false && 1 === message.messageId){
                        alert(message.messageContents);
                        //window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
                        moveToList();
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