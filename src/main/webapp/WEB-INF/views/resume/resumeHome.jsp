<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>

<html>

	<!-- 상태표시줄 로고 -->
	
	<head>
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/logo.png">
	</head>

	<head>
		<title>WAREWARE : ResumeHome</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css" />
		
		<style type="text/css">
	
		#wareware_icon {
			width : 100px !important;
		} 
	
		</style>
		
	</head>
	
	<body class="is-preload">
	
		<div id="page-wrapper">

		<!-- Header -->
		
		<header id="header">
		
			<h1><a href="index"><span class="image fit"><img id="wareware_icon" src="resources/images/icons/wareware_icon.png"></span></a></h1>
			<nav id="nav">
				<ul>
					<li><a href="index">Home</a></li>
					<li><a href="resumeHome">Self Analysis</a></li>
					<li><a href="posting">Job Explorer</a></li>
					<li><a href="#">News Analysis</a></li>
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
							<li><a href="login" class="button">Login / SignUp</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		
		</header>
		
		<!-- Main -->
		
		<section id="main" class="container">
			
			<header>
				<h2>Self Analysis</h2>
				<p>자기소개서를 통한 역량 분석과 채용공고를 추천해드립니다.</p>
			</header>
			
			<div class="box special">
			
				<div class="row">
					
					<div class="col-12">
					<h3>자기소개서 작성 방법</h3>
					</div>
				</div>
			</div>
			
			<ul class="actions special">
				<li><a href="writing" class="button">Start</a></li>
			</ul>
			
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

		<!-- Scripts -->
		
		<script src="resources/js/jquery.dropotron.min.js"></script>
		<script src="resources/js/jquery.scrollex.min.js"></script>
		<script src="resources/js/browser.min.js"></script>
		<script src="resources/js/breakpoints.min.js"></script>
		<script src="resources/js/util.js"></script>
		<script src="resources/js/main.js"></script>

	</body>
</html>