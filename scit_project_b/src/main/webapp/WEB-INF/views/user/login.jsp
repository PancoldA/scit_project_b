<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<!-- 상태표시줄 로고 -->
<head>
<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/logo.png">
</head>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<title>wareware : login</title>
	
	<script src="resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="resources/css/main.css" />

	<style>
	
		i {
		
			color : #e89980;
		
		}
	
	</style>
	
	<script>

		$(document).ready(function(){

			$("#login-btn").on("click", function(){

				$("#login-form").submit();

			});

		});

	</script>

</head>

<body class="is-preload">
	
	<div id="page-wrapper">
	
		<!-- Header -->
		
		<header id="header">
			<h1><a href="index">wareware</a> by wareware</h1>
			<nav id="nav">
				<ul>
					<li><a href="index.html">Home</a></li>
					<li><a href="#">Self Analysis</a></li>
					<li><a href="#">News Analysis</a></li>
					<li>
						<a href="myPage" class="icon solid fa-angle-down">MyPage</a>
						<ul>
							<li><a href="generic.html">my profile</a></li>
							<li><a href="contact.html">my resume</a></li>
						</ul>
					</li>
					<c:choose>
						<c:when test="${sessionId != null}">
						<li>${sessionId}님 반갑습니다!</li>
						<li><a href="logout" class="button">Logout</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="login" class="button">Login</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</header>

		<!-- Main -->
		
		<section id="main" class="container small">
			<header>
				<h2>Contact Us</h2>
				<p>Login</p>
			</header>
			<div class="box">
				<form id="login-form" method="post" action="login">	
					<div class="row gtr-50 gtr-uniform">
						<div class="col-12">
							<input type="email" name="email" id="email" value="" placeholder="Email" />
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
			<div class="box">
				<!-- 네이버 로그인 창으로 이동 -->
				<div id="naver_id_login" style="text-align:center"><a href="${url}">
				<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
			</div>
		</section>

		<!-- Footer -->
				
		<footer id="footer">
			<ul class="icons">
				<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
				<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
				<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
				<li><a href="#" class="icon brands fa-github"><span class="label">Github</span></a></li>
				<li><a href="#" class="icon brands fa-dribbble"><span class="label">Dribbble</span></a></li>
				<li><a href="#" class="icon brands fa-google-plus"><span class="label">Google+</span></a></li>
			</ul>
			<ul class="copyright">
				<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
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