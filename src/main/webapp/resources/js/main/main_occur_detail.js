/**
 * 
*/
function detailSelect(input) {
    console.log("detailSelect()");
    console.log("input : " + input);
    const yearSelect = input;
	
	// 토글 할 버튼 선택 (btn1)
    const detailInfo = document.querySelector('#detailInfo');
    console.log("detailInfo", detailInfo);
    
	  // btn1 숨기기 (display: none)
    if(detailInfo.style.display == 'none') {
    	detailInfo.style.display = 'block';
    }

    //비동기 통신
    let type= "POST";  
    let url = "/doma/point/guListLoad.do";
    let async = "true";
    let dataType = "html";

                    
    let params = { 
        "year"   : input
    };

    

    PClass.pAjax(url,params,dataType,type,async,function(data){
        if(data){
            try{ 
            //JSON문자열을 JSON Object로 변환
                const message =JSON.parse(data)     
                console.log("message.messagId:"+message.messageId);
                console.log("message.messageContents:"+message.messageContents);
                
                if(isEmpty(message) === false && 1 === message.messagId){   
                    alert(message.messageContents);
                	
                	const yearH2=ducument.querySelector("#yearH2");
                	
                	data.forEach(gu => {
			            const option = document.createElement('option');
			            option.value = gu.gname; 
			            option.text = gu.gname;
			            
			            // 만약 이전에 선택된 값이 있다면 selected 속성을 추가
			            if (gu.gname === '${search.searchDiv}') {
			                option.selected = true;
			            }
			
			            selectBox.appendChild(option);
		            });
		            
                }else{
                    alert(message.messageContents);
                }          
            }catch(e){
                console.error("data가 null혹은, undefined 입니다.",e);
                alert("data가 null혹은, undefined 입니다.");     
        }         
    }        

    });
}