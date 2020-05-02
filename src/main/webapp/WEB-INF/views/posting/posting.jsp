<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">	
		<title>WAREWARE - Job Explorer</title>
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css">
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
						<li>
							<a href="myPage" class="icon solid fa-angle-down">MyPage</a>
							<ul>
								<li><a href="resumeList">resume list</a></li>
							</ul>
						</li>
						<c:choose>
							<c:when test="${sessionId != null}">
								<li>${sessionId}님 반갑습니다!</li>
								<li><a href="logout" class="button">Logout</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="login" class="button">Login / Sign Up</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</header>
			<section id="main" class="container">
				<header>
					<h2>Job Explorer</h2>
					<p>관심사를 통해 채용공고를 추천해드립니다</p>
				</header>
				<div class="row">
					<div class="col-12">
						<section class="box">
							<h3>탐색 필터</h3>
							<form>
								<div class="row">
									<h4 class="col-12">구분</h4>
									<div class="col-6 col-12-narrower">
										<input type="radio" id="newman" name="experience" value="newman">
										<label for="newman">신입</label>
									</div>
									<div class="col-6 col-12-narrower">
										<input type="radio" id="oldman" name="experience" value="oldman">
										<label for="oldman">경력</label>
									</div>
									<h4 class="col-12">학력</h4>
									<div class="col-4 col-12-narrower">
										<input type="radio" id="MI" name="education" value="MI">
										<label for="MI">중학교졸업</label>
									</div>
									<div class="col-4 col-12-narrower">
										<input type="radio" id="HI" name="education" value="HI">
										<label for="HI">고등학교졸업</label>
									</div>
									<div class="col-4 col-12-narrower">
										<input type="radio" id="C" name="education" value="C">
										<label for="C">대학교졸업(2,3년)</label>
									</div>
									<div class="col-4 col-12-narrower">
										<input type="radio" id="U" name="education" value="U">
										<label for="U">대학교졸업(4년)</label>
									</div>
									<div class="col-4 col-12-narrower">
										<input type="radio" id="M" name="education" value="M">
										<label for="M">석사졸업</label>
									</div>
									<div class="col-4 col-12-narrower">
										<input type="radio" id="D" name="education" value="D">
										<label for="D">박사졸업</label>
									</div>
									<h4 class="col-12">지역</h4>
									<h5 class="col-12" style="padding-left: 2.5em">국내</h5>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="allkorea" name="location" value="allkorea">
										<label for="allkorea">전국</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="seoul" name="location" value="seoul">
										<label for="seoul">서울</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="gyeonggi" name="location" value="gyeonggi">
										<label for="gyeonggi">경기</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="gwangju" name="location" value="gwangju">
										<label for="gwangju">광주</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="daegu" name="location" value="daegu">
										<label for="daegu">대구</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="daejeon" name="location" value="daejeon">
										<label for="daejeon">대전</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="pusan" name="location" value="pusan">
										<label for="pusan">부산</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="ulsan" name="location" value="ulsan">
										<label for="ulsan">울산</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="incheon" name="location" value="incheon">
										<label for="incheon">인천</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="gangwon" name="location" value="gangwon">
										<label for="gangwon">강원</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="gyeongnam" name="location" value="gyeongnam">
										<label for="gyeongnam">경남</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="gyeongbuk" name="location" value="gyeongbuk">
										<label for="gyeongbuk">경북</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="jeonnam" name="location" value="jeonnam">
										<label for="jeonnam">전남</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="jeonbuk" name="location" value="jeonbuk">
										<label for="jeonbuk">전북</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="chungbuk" name="location" value="chungbuk">
										<label for="chungbuk">충북</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="chungnam" name="location" value="chungnam">
										<label for="chungnam">충남</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="jeju" name="location" value="jeju">
										<label for="jeju">제주</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="sejong" name="location" value="sejong">
										<label for="sejong">세종</label>
									</div>
									<h5 class="col-12" style="padding-left: 2.5em">해외</h5>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="usa" name="location" value="usa">
										<label for="usa">미국</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="japan" name="location" value="japan">
										<label for="japan">일본</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="china" name="location" value="china">
										<label for="china">중국.홍콩</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="asia" name="location" value="asia">
										<label for="asia">아시아·중동</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="northamerica" name="location" value="northamerica">
										<label for="northamerica">북·중미</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="southamerica" name="location" value="southamerica">
										<label for="southamerica">남미</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="europe" name="location" value="europe">
										<label for="europe">유럽</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="oceania" name="location" value="oceania">
										<label for="oceania">오세아니아</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="africa" name="location" value="africa">
										<label for="africa">아프리카</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="antarctica" name="location" value="antarctica">
										<label for="antarctica">남극대륙</label>
									</div>
									<div class="col-3 col-12-narrower">
										<input type="checkbox" id="etcover" name="location" value="etcover">
										<label for="etcover">기타해외</label>
									</div>
									<div class="col-12">
										<ul class="actions special">
											<li><input id="start" type="button" value="start"></li>
											<li><input type="reset" value="Reset" class="alt"></li>
										</ul>
									</div>
								</div>
							</form>
						</section>
					</div>
				</div>
				<div class="row">
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
		<script src="resources/js/posting.js"></script>
	</body>
</html>