<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">	
		<title>WAREWARE : 뉴스 감성 분석</title>
		<link rel="stylesheet" href="resources/css/main.css">
<style>
#columns{
	column-width:240px;
	column-gap: 15px;
	border-radius: 10px;
}
#columns figure{
	display: inline-block;
	border:1px solid rgba(0,0,0,0.2);
	margin:0;
	margin-bottom: 15px;
	padding:10px;
	box-shadow: 2px 2px 5px rgba(0,0,0,0.5);
	border-radius: 10px;
}
#columns figure img{
	width:100%; 
	border-radius: 10px;
}
#columns figure figcaption{
    border-top:1px solid rgba(0,0,0,0.2);
    padding:10px;
    margin-top:9px;  
}
div#columns:hover figure:not(:hover) {
	opacity: 0.65;	
	border-radius: 10px;
}
.btn {
	color: #fff;
	background: #2d4ca580;
	padding: .4rem .3rem;
	border-radius: 10px;
	transition-duration: .25s;
	border: none;
	font-size: 14px;
	text-decoration: none;
	margin: 0 0 .5em 0;
}
div#ex1 {
	max-width: 800px;
	background: #fff;
}

</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<!-- jQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
$(function(){
	$('#searchButton').on('click',function(){
		var html = '';
		$.ajax({
			url : "searchFromWord",
			type : "GET",
			data : $('#searchForm').serialize(),
			success : function(searchList){
			console.log(searchList.length)

			for(var i = 0; i<searchList.length; i++){
				html += '<figure id=news'+searchList[i].newsno+'>';
				html += '<img src="'+searchList[i].imgurl+'">';
				html += '<figcaption>'+searchList[i].subject+'</figcaption>';
				html += '<a class="btn" href="#ex1" rel="modal:open" onclick="ModalArticle(\'' + searchList[i].subject + '\',\''+ searchList[i].article + '\')">뉴스전문</a>'		
				html += '</figure>';
			}
			// console.log(html);
			$("#columns").html(html);
			for(var i = 0; i<searchList.length; i++){
				if(searchList[i].sentiment == 0){
					$("#news"+searchList[i].newsno).css('background-color','lightcoral');
				}
				else if(searchList[i].sentiment == 2){
					$("#news"+searchList[i].newsno).css('background-color','lightgreen')
				}
			}
			
			}
		
		});
	});
// 날짜리스트
	$('#dateButton').on('click', function(){
		var html='';
		$.ajax({
			url : "getDate",
			type : "GET",
			data : $('#dateForm').serialize(),
			success : function(dateList){
				console.log(dateList.length);
				
				for(var i = 0; i<dateList.length; i++){
					html += '<figure id=news'+dateList[i].newsno+'>';
					html += '<img src="'+dateList[i].imgurl+'">';
					html += '<figcaption>'+dateList[i].subject+'</figcaption>';
					html += '<a class="btn" href="#ex1" rel="modal:open" onclick="ModalArticle(\'' + dateList[i].subject + '\',\''+ dateList[i].article + '\')">뉴스전문</a>'		
					html += '</figure>';
				}
				// console.log(html);
				$("#columns").html(html);
				for(var i = 0; i<dateList.length; i++){
					if(dateList[i].sentiment == 0){
						$("#news"+dateList[i].newsno).css('background-color','lightcoral');
					}
					else if(dateList[i].sentiment == 2){
						$("#news"+dateList[i].newsno).css('background-color','lightgreen')
					}
				}
			}
		});
	});
//카테고리리스트
	$('#popularButton').on('click', function(){
		var html='';
		$.ajax({
			url : "getPopular",
			type : "GET",
			data : $('#popularForm').serialize(),
			success : function(popularList){
				console.log(popularList.length);
				
				for(var i = 0; i<popularList.length; i++){
					html += '<figure id=news'+popularList[i].newsno+'>';
					html += '<img src="'+popularList[i].imgurl+'">';
					html += '<figcaption>'+popularList[i].subject+'</figcaption>';
					html += '<a class="btn" href="#ex1" rel="modal:open" onclick="ModalArticle(\'' + popularList[i].subject + '\',\''+ popularList[i].article + '\')">뉴스전문</a>'		
					html += '</figure>';
				}
				// console.log(html);
				$("#columns").html(html);
				
				for(var i = 0; i<popularList.length; i++){
					if(popularList[i].sentiment == 0){
						$("#news"+popularList[i].newsno).css('background-color','lightcoral');
					}
					else if(popularList[i].sentiment == 2){
						$("#news"+popularList[i].newsno).css('background-color','lightgreen')
					}
					
				}
				
					$('#wordcloud').on('click', function(){
						var result = '동해물과백두산이마르고닳도록하느님이보우하사우리나라만세';
						$.ajax({
							url : "wordcloud",
							type : "GET",
							data : result,
							success : function(javaParsed){
								console.log(javaParsed.length)
							}
							
						});
					});
			}
		});
	});
});
function ModalArticle(title, content){
	$('#title').text(title);
	$('#content').text(content);
}

</script>
</head>
<body class="is-preload">
	<div id="page-wrapper">
		<header id="header">
			<h1><a href="index">wareware</a> by wareware</h1>
				<nav id="nav">
					<ul>
						<li><a href="index">Home</a></li>
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
					<h2>News Analysis</h2>
					<p>최신 기업 동향을 뉴스 검색을 통해 알아보세요.</p>
				</header>
				
				<form id="dateForm" method="get">	
					<input type="date" name="newsdate" >
					<input type="button" id="dateButton" value="날짜로검색" >
				</form>
				
				<form id="popularForm" method="get">	
					<select name  = "popular">
						<option value="society" >사회</option>
						<option value="economic" >경제</option>
						<option value="politics" >정치</option>
						<option value="culture" >문화</option>
						<option value="foreign" >해외</option>
						<option value="digital" >IT</option>
					</select>		
				<input type="button" id="popularButton" value="카테고리로검색" >
				</form>		
				
				<form id="searchForm" method="get">
					<input type="text" name="searchWord">
					<input type="button" id="searchButton" value="키워드로검색">
				</form>
				
				<!-- 뉴스카드 -->
				<div id="columns"></div>
				<div id="ex1" class="modal">
					<h3 id="title">Title</h3>
					<p id="content">Content</p>
					<button id="wordcloud" value="워드클라우드">워드클라우드</button>
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