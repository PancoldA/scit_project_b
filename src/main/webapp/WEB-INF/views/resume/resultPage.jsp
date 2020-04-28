<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>WAREWARE - Resume Result</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="resources/css/main.css">
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
		<style type="text/css">
			b {
				font-weight : bold;
			}
		</style>
		<script type="text/javascript">
			$(document).ready(function(){

				var category_type = "${category_type}";
				var resultMapJson = ${resultMapJson};
				var rankMapJson = ${rankMapJson};

				var text = "";

				text += "당신의 역량은 " + "<b>" + rankMapJson["0"] + "</b>" + " 입니다.";

				$("#resultP").html(text);

				var barChartData = {   
						             
						labels: ["의사소통", "문제해결", "자원관리", "도전정신", "주체지향"],         
						datasets: [{             
							label: 'Pass',   
							type : "bar",          
							backgroundColor: "#1E90FF",             
							data: [
								                
								resultMapJson["의사소통"]*100,                 
								resultMapJson["문제해결"]*100,                 
								resultMapJson["자원관리"]*100,                 
								resultMapJson["도전정신"]*100,                
								resultMapJson["주체지향"]*100,                           
								]   
						      
						}
  
				]};  

				Chart.defaults.global.legend.display = false;
				    
				var ctx = $('#chart').get(0).getContext("2d");   
				  
				window.theChart = new Chart(ctx, {   
					       
					type: 'bar',          
					data: barChartData,          
					options: {
						
						scales: {
							yAxes: [{
								ticks: {
									min: 0,
									max: 100,
									fontSize : 14
								}
							}]
						}
					}  
				
				}); 

				
				
			});
		</script>
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
			<section id="main" class="container">
				<header>
					<h2>Self Analysis Result</h2>
				</header>
				<div class="box special">
					<h3>자기소개서에 표현된 역량</h3>
					<p id="resultP"></p>
					<c:if test="${result == 'success'}">
						<p>
							표현하고자 하는 역량을 충분히 표현했습니다!
						<p>
					</c:if>
					<c:if test="${result == 'fail'}">
						<p>
							표현하고자 하는 역량을 충분히 표현하지 못 했습니다!
						</p>
					</c:if>
				</div>
				<div class="box special">
					<canvas id="chart"></canvas> 
				</div>
				<div class="box">
					<textarea id="resume" name="resume_content" rows="20" readonly="readonly" style="resize:none;">${resume_content}</textarea>
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