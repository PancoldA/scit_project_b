<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">	
		<title>WAREWARE : 채용공고 추천</title>
		<link rel="stylesheet" href="resources/css/main.css">
	</head>
	<body class="is-preload">
		<div id="page-wrapper">
			<header id="header">
				<h1><a href="index">wareware</a> by wareware</h1>
				<nav id="nav">
					<ul>
						<li><a href="index">Home</a></li>
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
			<section id="main" class="container">
				<header>
					<h2>Job Explorer</h2>
					<p>프로필과 관심사를 통해 채용공고를 추천해드립니다.</p>
				</header>
				<div class="row">
					<div class="col-12">
						<section class="box">
							<h3>탐색 필터</h3>
							<form method="post" action="#">
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
											<li><input type="submit" value="start"></li>
											<li><input type="reset" value="Reset" class="alt"></li>
										</ul>
									</div>
								</div>
							</form>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<section class="box">
							<h3>추천받고 싶은 채용공고와 관련된 분야를 선택해주세요</h3>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">주방용품에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">기업분석·심사에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">감리원에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">샤시·베란다에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">Embedded에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">자재구매에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">Java·JSP에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">IOS앱개발에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">.NET에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">모바일UI에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<section class="box">
							<h3>추천할 채용공고는 다음과 같습니다</h3>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4><b>[Tech Startup 두잉랩] Android, iOS, 웹, 딥러닝 개발자 채용</b> <a href="http://www.saramin.co.kr/zf_user/jobs/relay/view?rec_idx=37824013&utm_source=job-search-api&utm_medium=api&utm_campaign=saramin-job-search-api" class="button more small">more</a></h4>
								</div>
								<div class="col-4">
									<h4><b>(주)두잉랩</b></h4>
								</div>
							</div>
							<div class="row job-condition">
								<div class="col-12">
									<span>서울 강남구</span>
									<span>|</span>
									<span>신입·경력</span>
									<span>|</span>
									<span>대학교졸업(4년)이상</span>
									<span>|</span>
									<span>정규직, 인턴직</span>
								</div>
							</div>
							<div class="row job-category">
								<div class="col-12">
									<span>웹개발,응용프로그램개발,인공지능(AI)·빅데이터</span>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">채용공고에 만족하십니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<section class="box">
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">지하철광고에 관련된 분야입니까?</h4>
								</div>
								<div class="col-2" style="text-align: left">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<section class="box">
							<h3>추천할 채용공고는 다음과 같습니다</h3>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4><b>종합광고대행, AE, 온라인 오프라인 광고 영업,기획 관리자모집</b> <a href="http://www.saramin.co.kr/zf_user/jobs/relay/view?rec_idx=37885917&utm_source=job-search-api&utm_medium=api&utm_campaign=saramin-job-search-api" class="button more small">more</a></h4>
								</div>
								<div class="col-4">
									<h4><b>(주)좋은광고에스엠</b></h4>
								</div>
							</div>
							<div class="row job-condition">
								<div class="col-12">
									<span>서울 강남구</span>
									<span>|</span>
									<span>경력무관</span>
									<span>|</span>
									<span>고등학교졸업이상</span>
									<span>|</span>
									<span>정규직</span>
								</div>
							</div>
							<div class="row job-category">
								<div class="col-12">
									<span>일반영업,광고영업,영업기획·관리·지원</span>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4 style="line-height: 2em">채용공고에 만족하십니까?</h4>
								</div>
								<div class="col-2" style="text-align: left;">
									<a href="#" class="button small">Yes</a>
								</div>
								<div class="col-2" style="text-align: end">
									<a href="#" class="button alt small">No</a>
								</div>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<section class="box">
							<h3>비슷한 채용공고는 다음과 같습니다</h3>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4><b>온라인광고,마케팅 AE기획 전략</b> <a href="http://www.saramin.co.kr/zf_user/jobs/relay/view?rec_idx=38056428&utm_source=job-search-api&utm_medium=api&utm_campaign=saramin-job-search-api" class="button more small">more</a></h4>
								</div>
								<div class="col-4">
									<h4><b>제이솔루션</b></h4>
								</div>
							</div>
							<div class="row job-condition">
								<div class="col-12">
									<span>서울 금천구</span>
									<span>|</span>
									<span>경력무관</span>
									<span>|</span>
									<span>대학교졸업(4년)이상</span>
									<span>|</span>
									<span>정규직</span>
								</div>
							</div>
							<div class="row job-category">
								<div class="col-12">
									<span>마케팅·광고·분석,광고영업,웹기획·PM</span>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4><b>미디어렙 / 미디어플래너 / 매체기획자 모집</b> <a href="http://www.saramin.co.kr/zf_user/jobs/relay/view?rec_idx=38051405&utm_source=job-search-api&utm_medium=api&utm_campaign=saramin-job-search-api" class="button more small">more</a></h4>
								</div>
								<div class="col-4">
									<h4><b>(주)에이원퍼포먼스팩토리</b></h4>
								</div>
							</div>
							<div class="row job-condition">
								<div class="col-12">
									<span>서울 강남구</span>
									<span>|</span>
									<span>신입/경력</span>
									<span>|</span>
									<span>대학교졸업(4년)이상</span>
									<span>|</span>
									<span>정규직</span>
								</div>
							</div>
							<div class="row job-category">
								<div class="col-12">
									<span>마케팅·광고·분석,광고영업</span>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-8">
									<h4><b>모바일 앱 퍼블리싱 플랫폼 서비스 신규 기획 및 운영</b> <a href="http://www.saramin.co.kr/zf_user/jobs/relay/view?rec_idx=38029472&utm_source=job-search-api&utm_medium=api&utm_campaign=saramin-job-search-api" class="button more small">more</a></h4>
								</div>
								<div class="col-4">
									<h4><b>(주)티피엠엔</b></h4>
								</div>
							</div>
							<div class="row job-condition">
								<div class="col-12">
									<span>서울 강남구</span>
									<span>|</span>
									<span>신입/경력</span>
									<span>|</span>
									<span>대학교졸업(4년)이상</span>
									<span>|</span>
									<span>정규직</span>
								</div>
							</div>
							<div class="row job-category">
								<div class="col-12">
									<span>기획·전략·경영,마케팅·광고·분석,광고영업</span>
								</div>
							</div>
						</section>
					</div>
				</div>
			</section>
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
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<script src="resources/js/jquery.dropotron.min.js"></script>
		<script src="resources/js/jquery.scrollex.min.js"></script>
		<script src="resources/js/browser.min.js"></script>
		<script src="resources/js/breakpoints.min.js"></script>
		<script src="resources/js/util.js"></script>
		<script src="resources/js/main.js"></script>
	</body>
</html>