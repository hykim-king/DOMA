document.addEventListener("DOMContentLoaded", function() {
    console.log("────────DOMContentLoaded────────");
    
	//버튼 변수
	const myPageBtn = document.querySelector("#my_page");
	console.log("myPageBtn is " + myPageBtn);
	
	const adminPageBtn = document.querySelector("#admin_page");
	console.log("adminPageBtn is " + adminPageBtn);
	
	const registerPageBtn = document.querySelector("#register_page");	
	console.log("registerPageBtn is " + registerPageBtn);
	
	const loginPageBtn = document.querySelector("#login_page");
	console.log("loginPageBtn is " + loginPageBtn);
	
	const mainPagenBtn = document.querySelector("#main_page");
	console.log("mainPagenBtn is " + mainPagenBtn);
	  
	//이벤트 리스너
	myPageBtn.addEventListener("click", function(event){
		console.log("myPageBtn clicked");
		
		myPage();
	});
	
	adminPageBtn.addEventListener("click", function(event){
		console.log("adminPageBtn clicked");
		
		adminPage();
	});
	
	registerPageBtn.addEventListener("click", function(event){
		console.log("registerPageBtn clicked");
		
		registerPage();
	});
	
	loginPageBtn.addEventListener("click", function(event){
		console.log("loginPagenBtn clicked");
		
		loginPage();
	});
	
	mainPagenBtn.addEventListener("click", function(event){
		console.log("mainPagenBtn clicked");
		
		mainPage();
	});
	
	//함수
	function myPage() {
		console.log("adminPage()");
		alert("관리자 페이지로 이동합니다");
		window.location.href= "/doma/mypage/myPage.do";
	}
	
	function adminPage() {
		console.log("adminPage()");
		alert("관리자 페이지로 이동합니다");
		window.location.href= "/doma/admin/adminnotice.do";
	}
	
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
		window.location.href= "/doma/main/main.do";
	}
	
});