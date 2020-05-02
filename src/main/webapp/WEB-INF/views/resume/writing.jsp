<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>WAREWARE - Writing Resume</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css">
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
		<script type="text/javascript">
			$(document).ready(function(){

				$("#resume_content").on("keyup", function(){

					var text = "";
					var resume = $(this).val();
					
					var textLength = resume.length;

					text = textLength + " / 1000";

					if(textLength > 1000)
						$("#textLength").html(text).css("color", "red");
					else if(textLength < 300)
						$("#textLength").html(text).css("color", "red");
					else
						$("#textLength").html(text).css("color", "green");

				});

			});

			function save() {

				var resume_content = $("#resume_content").val();
				var resume_title = $("#resume_title").val();
				var category_list =  $("input:radio[name='category_type']:checked").val();
				var data = {"resume_title" : resume_title , "resume_content" : resume_content , "category_list" : category_list };
				
				$.ajax({

					method : "POST"
					, url : "saveResume"
					, data : data
					, success : function(response){

						if(response == "success") {

							var result = confirm("저장이 완료되었습니다. 계속 진행하시려면 '예'를, 아니면 '아니오'를 눌러주세요.");

							if(!result)
								window.location.replace("/wareware/resumeList");
								
						}
						
					}
					, error : function(response){
					}
					
				});

			}

			function analysis() {

				var resume_content = $("#resume_content").val();
				var category_type =  $("input:radio[name='category_type']:checked").val();

				if(resume_content.trim().length < 300) {

					alert("300자 미만일 경우 제대로 된 값이 나오질 않습니다. 다시 작성해주세요.");
					return;

				}

				if(resume_content.trim().length > 1001) {

					var bool = confirm("1000자 이상일 경우 데이터 처리에 소요되는 시간이 많이 걸리거나 말하고자 하는 바가 흩어질 수 있습니다. 이대로 진행하시겠습니까?");

					if(!bool)
						return; 
					
				}

				$("form").submit();

			}
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
							<a href="#" class="icon solid fa-angle-down">MyPage</a>
							<ul>
								<li><a href="resumeList">resume list</a></li>
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
					<h2>Writing Resume</h2>
				</header>
				<form id="form" method="POST" action="analysisResume">
					<div class="box special">
						<input type="radio" id="comunication" name="category_type" value="의사소통">
						<label for="comunication">의사소통</label>
						<input type="radio" id="solution" name="category_type" value="문제해결">
						<label for="solution">문제해결</label>
						<input type="radio" id="control" name="category_type" value="자원관리" checked="checked">
						<label for="control">자원관리</label>
						<input type="radio" id="challenge" name="category_type" value="도전정신">
						<label for="challenge">도전정신</label>
						<input type="radio" id="leadership" name="category_type" value="주체지향">
						<label for="leadership">주체지향</label>
					</div>
					<div class="box">
						<div class="col-12">
							<input type="text" id="resume_title" name="resume_title" placeholder="title">
						</div>
						<hr>
						<textarea id="resume_content" name="resume_content" rows="20" style="resize:none;">
						</textarea>
						<div class="col-12">
							<p id="textLength">0 / 1000</p>
						</div>	
					</div>
				</form>
				<ul class="actions special">
					<li><a href="javascript:void(0);" onclick="save();" class="button">저장</a></li>
					<li><a href="javascript:void(0);" onclick="analysis();" class="button">분석</a></li>
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