document.addEventListener("DOMContentLoaded", function() {
    
	const logoutBtn = document.querySelector("#logout");
	console.log("logoutBtn is " + logoutBtn);
	
	//이벤트 리스너
	logoutBtn.addEventListener("click", function(event){
		console.log("logoutBtn clicked");
		
		sessionStorage.clear();
	});
	
	
});