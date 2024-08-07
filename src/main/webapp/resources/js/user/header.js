

document.addEventListener("DOMContentLoaded", function(){
	console.log("────────DOMContentLoaded────────");
	
	//버튼 변수
	const registerPageBtn = document.querySelector("#register_page");
	console.log("registerPageBtn is ready!");
	
	const logiPagenBtn = document.querySelector("#login_page");
	console.log("logiPagenBtn is ready!");
	
	const mainPagenBtn = document.querySelector("#main_page");
	console.log("mainPagenBtn is ready!");
	  
	//이벤트 리스너
	registerPageBtn.addEventListener("click", function(event){
		console.log("registerPageBtn clicked");
		
		registerPage()
	});
	
	logiPagenBtn.addEventListener("click", function(event){
		console.log("logiPagenBtn clicked");
		
		loginPage()
	});
	
	mainPagenBtn.addEventListener("click", function(event){
		console.log("mainPagenBtn clicked");
		
		mainPage()
	});
	
	//함수
	function registerPage() {
		console.log("registerPage()");
		alert("회원가입 페이지로 이동합니다");
		window.location.href= "/doma/user/RegisterPage.do";
	}
	
	function loginPage() {
		console.log("loginPage()");
		alert("로그인 페이지로 이동합니다");
		window.location.href= "/doma/user/loginPage.do";
	}
	
	function mainPage() {
		console.log("mainPage()");
		alert("메인 페이지로 이동합니다");
		
		window.location.href= "/doma/main/emergency.do";
	}
	
});