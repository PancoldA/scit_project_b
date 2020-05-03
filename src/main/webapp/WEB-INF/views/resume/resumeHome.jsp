<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<title>WAREWARE - Self Analysis</title>
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css" />
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
	</head>
	<body class="is-preload">
		<div id="page-wrapper">
			<header id="header">
				<h1><a href="/wareware/"><span class="image fit"><img id="wareware_icon" src="resources/images/icons/wareware_icon.png"></span></a></h1>
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
			<!-- Main -->
			<section id="main" class="container medium">
				<header>
					<h2>Self Analysis</h2>
					<p>자기소개서를 통한 역량 분석과 채용공고를 추천해드립니다.</p>
				</header>
				<div class="box">
					<div class="row">
						<div class="col-12">
						<h3>자기소개서 작성 방법</h3>
						<br>
						<p>1. 역량을 선택한다.</p>
						<blockquote>
						의사소통 : 커뮤니케이션, 조직력, 친화력, 사교성, 대인관계 등등에 관한 역량<br>
						문제해결 : 문제 해결 능력, 위기 대처 능력, 업무 처리 능력 등등에 관한 역량<br>
						자원관리 : 시간 관리 능력, 효율성 추구, 물자 관리 및 운용 능력 등등에 관한 역량<br>
						도전정신 : 새로운 시도, 과감한 판단, 높은 이상 등등에 관한 가치관적인 모습<br>
						주체지향 : 주도적인 행동, 리더쉽, 솔선수범 등등에 관한 가치관적인 모습
						</blockquote>
						<p>2. 전하고자하는 바를 정확히한다.</p>
						<blockquote>
						전하고자 하는 내용을 간결하고 정확하게 전달하자.<br>
						 또, 앞뒤의 문맥에 어색함이 없도록 하자.<br>
						자신이 강조하려고 한 역량에 관련된 내용으로 구성한다.<br>
						문장의 수가 너무 짧으면 수집할 표본이 줄어든어 분석 결과의 신뢰도가 떨어진다.
						</blockquote>
						</div>
					</div>
					
				</div>
				<ul class="actions special">
					<li><a href="writing" class="button">Start</a></li>
				</ul>
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