<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="refresh" content="5;url=${pageContext.request.contextPath}/">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<title>WAREWARE - Error Page</title>
		<script src="resources/js/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="resources/css/main.css" />
		<link rel="shortcut icon" type="image⁄x-icon" href="resources/images/icons/wareware_icon.png">
	</head>
	<body class="is-preload">
		<div id="page-wrapper">
			<header id="header">
			</header>
			<!-- Main -->
			<section id="main" class="container medium">
				<header>
					<h2>Error Page</h2>
					<p>예상치 못 한 오류가 발생했습니다. 잠시 후 메인 페이지로 이동합니다.</p>
				</header>
				<div class="box">
					<div class="row">
						<div class="col-12">
							<p>${error}</p>
						</div>
					</div>
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