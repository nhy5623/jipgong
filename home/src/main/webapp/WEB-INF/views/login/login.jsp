<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c로 표시 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 동일 
fmt : formatter 형식 맞춰서 표시, 표시형식을 바꾼다는 의미-->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ include file="../includes/header.jsp"%>
<script>
	$(function() {
		$("#find_id_btn").click(function() {
			location.href = '../login/find_id_Form';
		});
	});
	$(function() {
		$("#find_pw_btn").click(function() {
			location.href = '../login/find_pw_Form';
		});
	});
	$(function() {
		$("#signup_btn").click(function() {
			location.href = '../login/signup';
		});
	});
</script>

<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>LogIn</h3>
			</div>
			<div>
				<form action="../login/login" method="post">
					<p>
						<label>ID</label> <input class="w3-input" id="user_id"
							name="user_id" type="text" required>
					</p>
					<p>
						<label>Password</label> <input class="w3-input" id="user_pw"
							name="user_pw" type="password" required>
					</p>

					<span class="w3-right w3-button w3-hover-white" title="아이디찾기"
						id="find_id_btn">아이디찾기</span> <span
						class="w3-right w3-button w3-hover-white" title="비밀번호찾기"
						id="find_pw_btn">비밀번호찾기</span> <span
						class="w3-right w3-button w3-hover-white" title="회원가입"
						id="signup_btn">회원가입</span>


					<p class="w3-center">
						<button type="submit"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Login</button>
						<button type="button"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"
							onclick="history.go(-1)">Cancel</button>
					</p>

					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>
</body>
</html>


