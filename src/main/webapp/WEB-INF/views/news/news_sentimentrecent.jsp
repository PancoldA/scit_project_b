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
	$('#search').on('click', function(){
		var html='';
		$.ajax({
			url : "getList",
			type : "GET",
			data : $('#form').serialize(),
			success : function(list){
				console.log(list.length);
				
				for(var i = 0; i<list.length; i++){
					html += '<figure id=news'+list[i].newsno+'>';
					html += '<img src="'+list[i].imgurl+'">';
					html += '<figcaption>'+list[i].subject+'</figcaption>';
					html += '<a class="btn" href="#ex1" rel="modal:open" onclick="ModalArticle(\'' + list[i].subject + '\',\''+ list[i].article + '\')">뉴스전문</a>'		
					html += '</figure>';
				}
				// console.log(html);
				$("#columns").html(html);
				for(var i = 0; i<list.length; i++){
					if(list[i].sentiment == 0){
						$("#news"+list[i].newsno).css('background-color','lightcoral');
					}
					else if(list[i].sentiment == 2){
						$("#news"+list[i].newsno).css('background-color','lightgreen')
					}
				}
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
						<li><a href="#">News Analysis</a></li>
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
				<form id="form" method="get">	
					<select name  = "popular">
						<option value="society" >사회</option>
						<option value="economic" >경제</option>
						<option value="politics" >정치</option>
						<option value="culture" >문화</option>
						<option value="foreign" >해외</option>
						<option value="digital" >IT</option>
					</select>		
					<input type="date" name="newsdate" >
				</form>		
				<input type="button" id="search" value="일일검색" >
				<div id="columns"></div>
				<div id="ex1" class="modal">
					<h3 id="title">Title</h3>
					<p id="content">Content</p>
				</div>
				<form action="searchNews" method="get">
					<select name="searchItem">
						<option value="subject" ${searchItem == 'subject' ? 'subject':'' }>기사제목</option>
						<option value="article" ${searchItem == 'subject' ? 'article':'' }>기사내용</option>
						<option value="company" ${searchItem == 'subject' ? 'company':'' }>언론사</option>
					</select>
					<input type="text" name="searchWord" value="${searchWord}">
					<input type="submit" value="기사검색">
				
				</form>
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