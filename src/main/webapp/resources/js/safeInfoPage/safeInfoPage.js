/**
 * 
 */	
	const situationBtn = document.querySelectorAll("ul.ui_section");
	const actingBtn = document.querySelectorAll("ul.ui_section");

    situationBtn.forEach(function(button) {
        button.addEventListener("click", function(event) {
            const situationSeq = event.currentTarget.querySelector("li[data-value]").getAttribute("data-value");
            console.log("situationSeq is ", situationSeq);
            selectOne(situationSeq);
        });
    });
	
	actingBtn.forEach(function(button) {
        button.addEventListener("click", function(event) {
            const actingSeq = event.currentTarget.querySelector("li[data-value]").getAttribute("data-value");
            console.log("actingSeq is ", actingSeq);
            selectOne(actingSeq);
        });
    });
	
	function selectOne(input) {
	  	console.log("selectOne()");
	  	console.log("input : " + input);
	  	
	    window.location.href = "/doma/safe/selectOne.do?seq="+ input;
	}
	
	
	function saveBtn() {
	    console.log("saveBtn()");
		
		window.location.href = "/doma/safe/savePage.do";
	}
	