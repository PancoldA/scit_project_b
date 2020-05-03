<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<title>WAREWARE - Sign Up</title>
	<script src="resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="resources/css/main.css" />
	<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
	<script>
		$(document).ready(function(){

			// 이메일 정규식 생성
			var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			// 이메일 유효성 검사 통과 여부
			var emailCheck = false;

			// 이메일 인증 검사 통과 여부
			var authCheck = false;

			// 이메일 인증 키 저장
			var authKey = "";

			// 비밀번호 정규식 생성 : 특수문자 포함 8~10자리
			var passwordRule = /^.*(?=^.{8,10}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

			// 비밀번호 유효성 검사 통과 여부
			var passwordRuleCheck = false;

			// 비밀번호 일치 여부
			var passwordConfirm = false;
			
			$("#email").on("keyup", function(){

				var email = $(this).val();

				// 이메일 정규식 유효성 검사
				if(!emailRule.test(email)){
					$("#email_message").html("Your email address is incorrect! Try Again!").css("color", "#e89980");
					emailCheck = false;
				} else { 
					
					$("#email_message").html("");

					$.ajax({

						method : "POST"
						, url : "emailCheck"
						, data : { "user_email" : email }
						, success : function(response) {

							// 이메일 중복 검사
							if(response == "success") {
								$("#email_message").html("You can use this email!").css("color", "#03cf5d");
								emailCheck = true;
							}
							else {
								$("#email_message").html("You can't use this email!").css("color", "#e89980");
								emailChekc = false;
							}
						}
						, error : function(response) {
							emailCheck = false;
							alert("emailCheck error!");
						}

					});

				}
	
			});

			// 전송 버튼 클릭 시 이벤트 발생
			$("#send-btn").on("click", function(){

				// 아이디 유효성 검사 및 중복성 검사 여부
				if(emailCheck){

					var email = $("#email").val();
					var data = {"user_email" : email};

					$.ajax({

						method : "POST"
						, url : "mailSend"
						, data : data
						, success : function(response){

							// response가 null이 아닐 시 인증키 저장
							if(response != null)
								authKey = response;
							// response가 null일 시 인증 여부 실패
							else
								authCheck = false;
							
						}
						, error : function(response){

							authCheck = false;
							console.log(response);
							alert("mailSend error!");
							
						}

					});
						
				} else { 
					alert("Check your email!");
				}
					
			});

			// 비밀번호 유효성 검사
			$("#password").on("keyup", function(){

				var password = $(this).val();

				// 비밀번호 정규식 검사
				if(passwordRule.test(password)){
					passwordRuleCheck = true;
					$("#password_message").html("You can use this!").css("color", "#03cf5d");
				}
				else {
					passwordRuleCheck = false;
					$("#password_message").html("8~10 including Special characters please!").css("color", "#e89980");
				}

			});

			//비밀번호 일치 체크
			$("#passwordCheck").on("keyup", function(){

				var password = $("#password").val();
				var passwordCheck = $(this).val();

				// 비밀번호가 비밀번호 체크와 일치할 시
				if(password == passwordCheck){
					passwordConfirm = true;
					$("#passwordCheck_message").html("Password Checked!").css("color", "#03cf5d");
				}
				// 비밀번호가 비밀번호 체크와 일치하지 않을 시
				else if(password != passwordCheck){
					passwordConfirm = false;
					$("#passwordCheck_message").html("Password not Checked!").css("color", "#e89980");
				}
				// 비밀번호나 비밀번호 체크가 공란일 시
				else if(password == "" || passwordCheck == ""){
					passwordConfirm = false;
					$("#passwordCheck_message").html("");
				}

			});

			// 인증 버튼 클릭 시 이벤트 발생
			$("#auth-btn").on("click", function(){

				$("#auth_message").html("");
				var enterKey = $("#key").val();

				// 인증키가 null일 시
				if(authKey == ""){
					authCheck = false;
					$("#auth_message").html("Try send again!").css("color", "#e89980");
					return;
				}
				// 인증키가 입력키와 일치하지 않을 시
				else if(authKey != enterKey){
					authCheck = false;
					$("#auth_message").html("Try enter again!").css("color", "#e89980");
					return;
				}
				// 인증키가 입력키와 일치할 시
				else if(authKey == enterKey){
					$("#auth_message").html("Checked!").css("color", "#03cf5d");
					authCheck = true;
				}
					
			});
			
			// 회원가입 버튼 클릭 시 이벤트 발생
			$("#signup-btn").on("click", function(){

				// 아이디 유효성 검사 및 중복성 검사와 인증키 검사 여부
				if(emailCheck && authCheck && passwordRuleCheck && passwordConfirm)
					$("#signup-form").submit();
				else {
					$("#signup_message").html("Check your email or authorization key!").css("color", "#e89980");
					return;
				}

			});

		});
	</script>
</head>
<body class="is-preload">
	<div id="page-wrapper">
		<header id="header">
			<h1><a href="/wareware/"><img id="wareware_icon" class="image fit" src="resources/images/icons/wareware_icon.png"></a></h1>
			<nav id="nav">
				<ul>
					<li><a href="/wareware/">Home</a></li>
					<li><a href="resumeHome">Self Analysis</a></li>
					<li><a href="posting">Job Explorer</a></li>
					<li><a href="news_sentiment">News Analysis</a></li>
					<c:if test="${sessionScope.sessionId != null}">
						<li>
							<a href="#" class="icon solid fa-angle-down">MyPage</a>
							<ul>
								<li><a href="resumeList">resume list</a></li>
							</ul>
						</li>
						</c:if>
					<c:choose>
						<c:when test="${sessionScope.sessionId != null}">
							<li>${sessionScope.sessionId}님 반갑습니다!</li>
							<li><a href="logout" class="button">Logout</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="login" class="button">Login / Sign Up</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</header>
		<section id="main" class="container small">
			<header>
				<h2>Sign Up</h2>
			</header>
			<div class="box special">
				<form id="signup-form" method="post" action="signup">	
					<div class="row gtr-50 gtr-uniform">
						<div class="col-12">
							<input type="email" name="user_email" id="email" value="" placeholder="Email" />
						</div>
						<div class="col-12">
							<p id="email_message"></p>
						</div>
						<div class="col-12">
							<input type="text" name="key" id="key" value="" placeholder="Authorization Key" />
						</div>
						<div class="col-12">
							<p id="auth_message">Click send button and enter authorization key!</p>
						</div>
						<div class="col-12">
							<ul class="actions special">
								<li><a id="send-btn" class="button small alt fit">Send</a></li>
								<li><a id="auth-btn" class="button small alt fit">Auth</a></li>
							</ul>
						</div>
						<div class="col-12">
							<input type="password" name="password" id="password" value="" placeholder="Password" />
						</div>
						<div class="col-12">
							<p id="password_message"></p>
						</div>
						<div class="col-12">
							<input type="password" name="passwordCheck" id="passwordCheck" value="" placeholder="Password Check" />
						</div>
						<div class="col-12">
							<p id="passwordCheck_message"></p>
						</div>
						<div class="col-12">
						<hr>
						</div>
						<div class="col-12">
							<p id="signup_message"></p>
						</div>
						<div class="col-12">
							<ul class="actions stacked">
								<li><a id="signup-btn" class="button fit">Sign Up</a></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</section>
		<footer id="footer">
			<ul class="copyright">
				<li>Copyright &copy; WAREWARE. All rights reserved.</li>
			</ul>
		</footer>
	</div>
	<script src="resources/js/jquery.dropotron.min.js"></script>
	<script src="resources/js/jquery.scrollex.min.js"></script>
	<script src="resources/js/browser.min.js"></script>
	<script src="resources/js/breakpoints.min.js"></script>
	<script src="resources/js/util.js"></script>
	<script src="resources/js/main.js"></script>
</body>
</html>