<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<style type="text/css">
* {
    margin-bottom: 30px;
    padding: 0;
    list-style: none;
}

#munubar {
	background: black;
}

#menubar ul {
	margin: 0;
	padding: 0;
	width: 567px;
	float: right;

}

#menubar ul li {
	display: inline-block;
	list-style-type: none;
	padding: 0px 5px;
}

#menubar ul li a {
	color: black;
	text-decoration: none;
}

#menubar ul li a:hover {
	color: blue;
}
</style>
</head>
<body>
	<nav id="menubar">
		<ul>
			<li><a href="/login/member">내정보</a></li>
			<li><a href="/community/getUserCommunityList">내 게시글</a></li>
			<li><a href="/board/mypage">Q&A</a></li>
			<li><a href="/store/orderList">배송/주문 조회</a></li>
			<li><a href="/store/cartList">장바구니</a></li>
			<li><a href="#">구매목록</a></li>
		</ul>
	</nav>
</body>
</html>

