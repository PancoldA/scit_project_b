<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
      #columns{
        column-width:220px;
        column-gap: 15px;
      }
      #columns figure{
        display: inline-block;
        border:1px solid rgba(0,0,0,0.2);
        margin:0;
        margin-bottom: 15px;
        padding:10px;
        box-shadow: 2px 2px 5px rgba(0,0,0,0.5);
        /* background-color: red */ 
      }
      #columns figure img{
        width:100%;
      }
      #columns figure figcaption{
        border-top:1px solid rgba(0,0,0,0.2);
        padding:10px;
        margin-top:11px;
      }
</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script>
/* $(function(){
	var html='';
	
	$.ajax({
		url : "getList",
		type : "GET",
		success : function(list){
			console.log(list.length);
			
			for(var i = 0; i<list.length; i++){
				html += '<figure id=news'+list[i].newsno+'>';
				html += '<img src="'+list[i].imgurl+'">';
				html += '<figcaption>'+list[i].subject+'</figcaption>';
				html += '</figure>';
			}
			console.log(html);

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
	})
	
}); */

</script>
</head>
<body>

<div id="columns">
	
<c:forEach var="news" items="${list}">
	<figure>	
       	<img src="${news.imgurl}">
       	<figcaption>${news.subject}</figcaption>
   	</figure>
</c:forEach>

</div>
</body>
</html>