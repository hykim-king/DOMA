	const situationBtn = document.querySelectorAll("ul.ui_section");
	const actingBtn = document.querySelectorAll("ul.ui_section");

    situationBtn.forEach(function(button) {
        button.addEventListener("click", function(event) {
            const situationSeq = event.currentTarget.querySelector("li[data-value]").getAttribute("data-value");
            selectOne(situationSeq);
        });
    });
	
	actingBtn.forEach(function(button) {
        button.addEventListener("click", function(event) {
            const actingSeq = event.currentTarget.querySelector("li[data-value]").getAttribute("data-value");
            selectOne(actingSeq);
        });
    });
	
	function selectOne(input) {
	    window.location.href = "/doma/safe/selectOne.do?seq="+ input;
	}
	
	
	function saveBtn() {
		window.location.href = "/doma/safe/savePage.do";
	}
	