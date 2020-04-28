<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<title>WAREWARE - Login</title>
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css">
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
		<c:if test="${not empty login_message}">
			<script type="text/javascript">
				alert("${login_message}");
			</script>
		</c:if>
		<script>
			$(document).ready(function(){
	
				// 이메일 정규식 생성
				var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
				// 로그인 버튼 클릭 시 이벤트 발생
				$("#login-btn").on("click", function(){
	
					// 이메일 정규식 유효성 검사
					if(!emailRule.test($("#email").val())){
						$("#email_message").html("Your email address is incorrect! Try Again!").css("color", "#e89980");
			        	return false;
					} else {
						$("#email_message").html("");
					}
	
					$("#login-form").submit();
	
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
						<li>
							<a href="myPage" class="icon solid fa-angle-down">MyPage</a>
							<ul>
								<li><a href="generic">my profile</a></li>
								<li><a href="contact">my resume</a></li>
							</ul>
						</li>
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
					<h2>Login</h2>
				</header>
				<div class="box special">
					<form id="login-form" method="POST" action="login">	
						<div class="row gtr-50 gtr-uniform">
							<div class="col-12">
								<input type="email" name="user_email" id="email" value="" placeholder="Email" />
								<p id="email_message"></p>
							</div>
							<div class="col-12">
								<input type="password" name="password" id="password" value="" placeholder="Password" />
							</div>
							<div class="col-12">
								<ul class="actions stacked">
									<li><a id="login-btn" class="button fit">LogIn</a></li>
									<li><a href="signup" class="button alt fit">You Don't have any Account? <i>Click this!</i></a></li>
								</ul>
							</div>
						</div>
					</form>
				</div>
				<div class="box special">
					<div class="row gtr-50 gtr-uniform">
						<!-- 네이버 로그인 창으로 이동 -->
						<div id="naver_id_login" class="col-12"><span class="image fit" ><a  href="${naverAuthUrl}">
						<img src="resources/images/icons/naverLogin.jpg"/></a>
					</span>
					</div>
					</div>
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