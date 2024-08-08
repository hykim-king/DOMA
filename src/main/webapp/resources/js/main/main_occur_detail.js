/**
 * 
*/
function detailSelect(input) {
    console.log("detailSelect()");

    //비동기 통신
    let type= "POST";  
    let url = "/doma/main/doUpdate.do";
    let async = "true";
    let dataType = "html";

                    
    let params = { 
        "year"   : input.value

    };

    if(confirm("조회 하시겠습니까?")===false)return;        

    PClass.pAjax(url,params,dataType,type,async,function(data){
        if(data){
            try{ 
            //JSON문자열을 JSON Object로 변환
                const message =JSON.parse(data)     
                console.log("message.messagId:"+message.messagId);
                console.log("message.messageContents:"+message.messageContents);
                
                if(isEmpty(message) === false && 1 === message.messagId){   
                    alert(message.messageContents);
                    window.open('/doma/mypage/myPage.do',"width=300px,height=300px");
                }else{
                    alert(message.messageContents);
                    window.open('/doma/mypage/myPage.do',"width=300px,height=300px");
                }          
            }catch(e){
                console.error("data가 null혹은, undefined 입니다.",e);
                alert("data가 null혹은, undefined 입니다.");     
        }         
    }        

    });
}