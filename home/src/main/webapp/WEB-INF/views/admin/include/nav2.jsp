<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Navbar</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Raleway:400,500,500i,700,800i"
	rel="stylesheet">
<!-- Bootstrap core CSS -->
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="../resources/css/style.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<nav class="navbar navbar-expand-sm   navbar-light bg-light">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo03"
			aria-controls="navbarTogglerDemo03" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarTogglerDemo03">
			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">

				<li  class="nav-item"><a class="nav-link" href="/admin/community/communityList">Community</a></li>
				<li	class="nav-item"><a class="nav-link" href="/admin/store/storeList"> STORE </a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/board/QnA">QnA</a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/login/memberList">회원 정보 관리</a></li>
				<li 	class="nav-item"><a class="nav-link" href="/admin/store/orderList">주문 승인</a></li>

	
				


				<c:if test="${member != null}">
					<li id="2"class="nav-item"><a class="nav-link" href="/" >일반 화면</a></li>
					<li id="2"class="nav-item"><a class="nav-link" href="/login/logout" >로그아웃</a></li>

				</c:if>

			</ul>

		</div>
	</nav>
	<script type="text/javascript">
		$(document).ready(
				function() {
					$('.navbar-light .dmenu').hover(
							function() {
								$(this).find('.sm-menu').first().stop(true,
										true).slideDown(150);
							},
							function() {
								$(this).find('.sm-menu').first().stop(true,
										true).slideUp(105)
							});
				});
	</script>
</body>
</html>