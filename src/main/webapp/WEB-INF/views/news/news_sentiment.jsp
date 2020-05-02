<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">	
		<title>WAREWARE - News Analysis</title>
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css">
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
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
			div#wordcloud{
				max-width: 600px;
			}
			a { text-decoration:none ; color:#000000}
			
			/* 워드클라우드 스타일 */
			section > form {
				display: inline-block;
    			width: 33%;
    			margin-right: 1em;
			}
			
			#dateForm > input[type="date"] {
				margin-right: 0.5em;
    			width: 50%;
    			height: 3em;
    			background-color: #f8f8f8;
    			border-radius: 6px;
			}
			
			#popularForm > select {
				width: 35%;
				display: inline;
    			margin-right: 0.5em;
			}
			
			#searchForm > input[type="text"] {
				width: 30%;
    			display: inline;
    			margin-right: 0.5em;
			}
			
			footer {
				position: fixed;
   	 			width: 100%;
    			bottom: 0;
			}
		</style>
		<!-- jQuery Modal -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
		<!-- 워드클라우드 d3.js -->
		<script src="http://d3js.org/d3.v3.min.js"></script>
		<script src="https://rawgit.com/jasondavies/d3-cloud/master/build/d3.layout.cloud.js" type="text/JavaScript"></script>
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
							html += '<a href="'+searchList[i].linkurl+'" target="_blank">';
							html += '<figure id=news'+searchList[i].newsno+'>';
							html += '<img src="'+searchList[i].imgurl+'">';
							html += '<figcaption>'+searchList[i].subject+'</figcaption>';		
							html += '<a class ="btn" id="btn2" href="#ex2" rel="modal:open" onclick="ModalWordcloud(\''+searchList[i].article + '\')">워드클라우드</a>'
							html += '</figure>';
							html += '</a>';
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
								html += '<a href="'+dateList[i].linkurl+'" target="_blank">';
								html += '<figure id=news'+dateList[i].newsno+'>';
								html += '<img src="'+dateList[i].imgurl+'">';
								html += '<figcaption>'+dateList[i].subject+'</figcaption>';		
								html += '<a class ="btn" id="btn2" href="#ex2" rel="modal:open" onclick="ModalWordcloud(\''+dateList[i].article + '\')">워드클라우드</a>'
								html += '</figure>';
								html += '</a>';
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
							console.log(popularList)
							
							
							for(var i = 0; i<popularList.length; i++){
								html += '<a href="'+popularList[i].linkurl+'" target="_blank">';
								html += '<figure id=news'+popularList[i].newsno+'>';
								html += '<img src="'+popularList[i].imgurl+'">';
								html += '<figcaption>'+popularList[i].subject+'</figcaption>';		
								html += '<a class ="btn" id="btn2" href="#ex2" rel="modal:open" onclick="ModalWordcloud(\''+popularList[i].article + '\')">워드클라우드</a>'
								html += '</figure>';
								html += '</a>';
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
						}
					});
				});
			});			
			
			function ModalWordcloud(result){
				var data = {"result" : result}
				$.ajax({
						url : "wordcloud",
						type : "POST",
						data : data,
						dataType : "json",
						success : function(list){
							console.log(list)			
			// 			워드클라우드화
							var width = 450;
								height = 450;
							var color = d3.scale.category20();
				    		d3.layout.cloud().size([width, height])
				            .words(list.map(function(d) {
				                return {text: d, size: 10 + Math.random() * 70};
				                }))
				            .rotate(0)
				            .fontSize(function(d) { return d.size; })
				            .on("end", draw)
				            .start();
				
					   			function draw(words) {
						   			$("#wordcloud").empty();
					      			d3.select("#wordcloud").append("svg")
					                .attr("width", width)
					                .attr("height", height)
					                .attr("class", "wordcloud")
					                .append("g")
					                .attr("transform", "translate(" +(width /3 )+ "," +(height /2) + ")")
					                .selectAll("text")
					                .data(words)
					                .enter().append("text")
					                .style("font-family", "overwatch")
					                .style("font-size", function(d) { return (d.size) + "px"; })
					                .style("fill", function(d, i) { return color(i); })
					                .attr("transform", function(d) {
					                    return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
					                })
					                .text(function(d) { return d.text.text; });
					    		}
						}	
				});
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
							<a href="myPage" class="icon solid fa-angle-down">MyPage</a>
							<ul>
								<li><a href="resumeList">my profile</a></li>
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
					<h2>News Analysis</h2>
					<p>최신 기업 동향을 뉴스 검색을 통해 알아보세요.</p>
				</header>
				<form id="dateForm" method="get">	
					<input type="date" name="newsdate" >
					<input type="button" id="dateButton" value="날짜로검색" >
				</form>
				<form id="popularForm" method="get"  style="width: 30%">	
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
				<form id="searchForm" method="get"  style="margin-right: 0">
					<input type="text" name="searchWord">
					<input type="button" id="searchButton" value="키워드로검색">
				</form>
				<!-- 뉴스카드 -->
				<div id="columns"></div>
				<div id="ex1" class="modal">
					<h3 id="title">Title</h3>
					<p id="content">Content</p>
				</div>
				<div id="ex2" align="center" class="modal" >
					<h3>Wordcloud Analysis</h3>
					<div id="wordcloud" align="center" ></div>
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