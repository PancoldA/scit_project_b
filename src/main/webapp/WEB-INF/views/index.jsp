<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>WAREWARE</title>
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css">
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
		<c:if test="${not empty naver_message}">
			<script type="text/javascript">
				alert("${naver_message}");
			</script>
		</c:if>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#footer').css('background','initial');
			});
		</script>
		<style>	
			footer {
				position: fixed;
			    width: 100%;
			    bottom: 0;
			    z-index: 999;
			}
			
			#footer .copyright {
				color: #fff;
			}		
			
			#banner {
				position: absolute;
			    top: 0%;
			    width: 100%;
			    z-index: 999;
			    background-color: initial;
			    background-image: initial;
			}
		</style>
	</head>
	<body class="landing is-preload">
		<div id="page-wrapper">
			<header id="header" class="alt">
				<h1><a href="/wareware/"><span class="image fit"><img id="wareware_icon" src="resources/images/icons/wareware_icon.png"></span></a></h1>
				<nav id="nav">
					<ul>
						<li><a href="/wareware/">Home</a></li>
						<li><a href="resumeHome">Self Analysis</a></li>
						<li><a href="posting">Job Explorer</a></li>
						<li><a href="news_sentiment">News Analysis</a></li>
						<li>
							<a href="myPage" class="icon solid fa-angle-down">MyPage</a>
							<ul>
								<li><a href="resumeList">resume list</a></li>
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
			<div id="video">
				<div class="overlay"></div>
				<video playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
		            <source src="resources/video/Internet-Cafe-156.mp4" type="video/mp4">
		            <source src="resources/video/Internet-Cafe-156.webm" type="video/webm">
		                  죄송합니다. 동영상이 지원되지 않습니다.
				</video>
			</div>
			<section id="banner">
				<h2>WAREWARE</h2>
				<h3>당신을 위한 취업 솔루션</h3>
			</section>
			<section id="solutions">
				<div class="features-row">
					<section>
						<span class="icon solid major fa-lock accent6"></span>
						<h3>1단계 : 회원가입</h3>
					</section>
					<section>
						<span class="icon solid major fa-align-left accent3"></span>
						<h3>2단계 : 자기소개서 분석</h3>
					</section>
					<section>
						<span class="icon solid major fa-search accent4"></span>
						<h3>3단계 : 관심사 분석</h3>
					</section>
					<section>
						<span class="icon solid major fa-newspaper accent5"></span>
						<h3>4단계 : 뉴스 분석</h3>
					</section>
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