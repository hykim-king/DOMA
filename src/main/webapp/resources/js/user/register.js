
 document.addEventListener("DOMContentLoaded", function(){
	console.log("────────DOMContentLoaded────────");
	
	//변수
	const doSaveBtn = document.querySelector("#doSave");
	console.log("doSaveBtn", doSaveBtn);
	
	//이벤트 리스너
	doSaveBtn.addEventListener("click",function(event){
		console.log("doSaveBtn click");
		
		//doSave();
	});
	  
	function doSave() {
        console.log("doSave()");
    }
    
});
        