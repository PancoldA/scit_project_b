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
	<title>wareware : index</title>
	
	<script src="resources/js/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="resources/css/main.css" />
	
	<c:if test="${not empty naver_message}">
	<script type="text/javascript">
		alert("${naver_message}");
	</script>
	</c:if>
	
	<script type="text/javascript">

		$(document).ready({


		});

	</script>
	
	<style>
	
 		#wareware_icon {
		
			width : 100px;
		
		
		} 
	
	
	</style>
	
</head>

<body class="landing is-preload">

	<div id="page-wrapper">
	
		<!-- Header -->
		
		<header id="header" class="alt">
		
			<h1><a href="index"><span class="image fit"><img id="wareware_icon" src="resources/images/icons/wareware_icon.png"></span></a></h1>
			<nav id="nav">
				<ul>
					<li><a href="index">Home</a></li>
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
	
		<!-- Banner -->
		
		<section id="banner">
			<h2>WAREWARE</h2>
			<h3>자신의 프로필 및 자소서 분석 통한 채용 공고 추천<br/>최신 기업 동향을 뉴스 검색을 통해 알아보세요</h3>
			<ul class="actions special">
				<li><a href="#" class="button primary">Start Self Analysis</a></li>
			</ul>
		</section>
			
		<section id="main" class="container">

			<section class="box special">
				<header class="major">
					<h2>Introducing the ultimate mobile app<br />for doing stuff with your phone</h2>
					<p>Blandit varius ut praesent nascetur eu penatibus nisi risus faucibus nunc ornare<br />
					adipiscing nunc adipiscing. Condimentum turpis massa.</p>
				</header>
				<span class="image featured"><img src="resources/images/wareware_image.png" alt="" /></span>
			</section>

					<section class="box special features">
						<div class="features-row">
							<section>
								<span class="icon solid major fa-bolt accent6"></span>
								<h3>1단계. 프로필 정보 대조</h3>
								<p>자신이 등록한 프로필과 조건이 맞는 채용 공고 선별</p>
							</section>
							<section>
								<span class="icon solid major fa-chart-area accent3"></span>
								<h3>2단계. 자기 소개서 분석</h3>
								<p>자기 소개서의 핵심 키워드와 채용 공고의 핵심 키워드 비교 분석을을 통한 순위 매김</p>
							</section>
						</div>
						<div class="features-row">
							<section>
								<span class="icon solid major fa-cloud accent4"></span>
								<h3>Sed feugiat</h3>
								<p>Integer volutpat ante et accumsan commophasellus sed aliquam feugiat lorem aliquet ut enim rutrum phasellus iaculis accumsan dolore magna aliquam veroeros.</p>
							</section>
							<section>
								<span class="icon solid major fa-lock accent5"></span>
								<h3>Enim phasellus</h3>
								<p>Integer volutpat ante et accumsan commophasellus sed aliquam feugiat lorem aliquet ut enim rutrum phasellus iaculis accumsan dolore magna aliquam veroeros.</p>
							</section>
						</div>
					</section>

					<div class="row">
						<div class="col-6 col-12-narrower">

							<section class="box special">
								<span class="image featured"><img src="resources/images/pic02.jpg" alt="" /></span>
								<h3>Sed lorem adipiscing</h3>
								<p>Integer volutpat ante et accumsan commophasellus sed aliquam feugiat lorem aliquet ut enim rutrum phasellus iaculis accumsan dolore magna aliquam veroeros.</p>
								<ul class="actions special">
									<li><a href="#" class="button alt">Learn More</a></li>
								</ul>
							</section>

						</div>
						<div class="col-6 col-12-narrower">

							<section class="box special">
								<span class="image featured"><img src="resources/images/pic03.jpg" alt="" /></span>
								<h3>Accumsan integer</h3>
								<p>Integer volutpat ante et accumsan commophasellus sed aliquam feugiat lorem aliquet ut enim rutrum phasellus iaculis accumsan dolore magna aliquam veroeros.</p>
								<ul class="actions special">
									<li><a href="#" class="button alt">Learn More</a></li>
								</ul>
							</section>

						</div>
					</div>

				</section>
				
			<!-- CTA -->
				<section id="cta">

					<h2>Sign up for beta access</h2>
					<p>Blandit varius ut praesent nascetur eu penatibus nisi risus faucibus nunc.</p>

					<form>
						<div class="row gtr-50 gtr-uniform">
							<div class="col-8 col-12-mobilep">
								<input type="email" name="email" id="email" placeholder="Email Address" />
							</div>
							<div class="col-4 col-12-mobilep">
								<input type="submit" value="Sign Up" class="fit" />
							</div>
						</div>
					</form>

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