/**
 * 
 */

const situationBtn = document.querySelector("#situation_seq");
const actingBtn = document.querySelector("#acting_seq");

situationBtn.addEventListener("click",function(event){
	console.log("situationBtn is ", situationBtn);
});

actingBtn.addEventListener("click",function(event){
	console.log("actingBtn is ",actingBtn);
});

function selectOne(input) {
  	console.log("loadData()");
  	
    window.location.href = "/doma/safe/selectOne.do";
}

function saveBtn() {
    console.log("saveBtn()");
	
	window.location.href = "/doma/safe/savePage.do";
}

function deleteBtn() {
    console.log("deleteBtn()");
}