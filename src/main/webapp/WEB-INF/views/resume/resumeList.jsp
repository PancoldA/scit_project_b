<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>

<html>

	<head>
		<title>WAREWARE : ResumeList</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css" />
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
		
		<script type="text/javascript">

			$(document).ready(function(){

				init();
		
			});

			function listprint (response) {

				var text = "";

				if(response == null) {

					text = "<p>등록된 자기소개서가 없습니다.</p>";
					$("#table-wrapper").html(text);
					return;

				}

				text += "<table><thead><tr><th>일련번호</th><th>선택역량</th><th>제목</th><th>등록일</th><th>수정일</th></tr></thead>";

				$.each(response, function(index, item){

					text += "<tboby><tr class='clickList' data-num='" + item.resume_no + "'><td>" + item.resume_no + "</td><td>" + item.category_list + "</td><td>" + item.resume_title + "</td>";
					text += "<td>" + item.resume_regist_date.substring(0,10) + "</td><td>" + item.resume_modify_date.substring(0,10) + "</td></tr></a></tbody>";

				});

				$("#table-wrapper").html(text);
				$(".clickList").on("click", goList);

			}

			function init() {

				$.ajax({

					method : "POST"
					, url : "resumeList"
					, success : listprint
					, error : function(response) {

					}

				});

			}

			function goList () {

				var resume_no = $(this).attr("data-num");
				location.href = "resumePrint?resume_no=" + resume_no;
			}

		</script>
		
	</head>
	
	<body class="is-preload">
	
		<div id="page-wrapper">

		<!-- Header -->
		
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
			
			<section id="main" class="container">
				
				<header>
					<h2>Resume List</h2>
				</header>
				
				<div class="box">
				
					<div id="table-wrapper" class="table-wrapper">
					
					</div>
					
				</div>
				
			</section>
	
				<!-- Footer -->
				
			<footer id="footer">
				<ul class="copyright">
					<li>Copyright &copy; WAREWARE. All rights reserved.</li>
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