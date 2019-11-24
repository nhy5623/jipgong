<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/nav2.jsp"%>
<script>
	$(document).ready(function() {
		$("#btnUpdate").click(function() {
			if (confirm("회원목록으로 이동하시겠습니까?")) {
				document.form1.action = "/admin/login/memberUpdate";
				document.form1.submit();
			}
		});
	});
	$(document).ready(function() {
		$("#btnDelete").click(function() {
			if (confirm("삭제하시겠습니까?")) {
				document.form1.action = "/admin/login/delete";
				document.form1.submit();
			}
		});
	});
</script>

<div class="w3-content w3-container w3-margin-top">
	<div class="w3-container w3-card-4">
		<div class="w3-center w3-large w3-margin-top">
			<p>회원정보상세</p>
		</div>
		<div>
			<form name="form1" method="post">
				<p>
					<label>아이디</label> <input class="w3-input" id="user_id"
						name="user_id" readonly value="${ vo.user_id }">
				</p>
				<%-- <p>
						<label>비밀번호</label> <input class="w3-input" id="user_name"
							name="user_pw" readonly value="${ member.user_pw }">
					</p> --%>

				<p>
					<label>이름</label> <input class="w3-input" "
							id="user_name"
						name="user_name" readonly value="${ vo.user_name }">
				</p>
				<p>
					<label>이메일</label> <input class="w3-input" id="user_email"
						name="user_email" readonly value="${ vo.user_email }">
				</p>

				<p>
					<label>전화번호</label> <input class="w3-input" id="user_phone"
						name="user_phone" readonly value="${ vo.user_phone }">
				</p>

				<p>
					<label>우편번호</label> <input class="w3-input" id="addr1" name="addr1"
						readonly value="${ vo.addr1 }">


				</p>
				<p>
					<label>도로명 주소</label> <input class="w3-input" id="addr2"
						name="addr2" readonly value="${ vo.addr2 }">
				</p>
				<p>
					<label>상세 주소</label> <input class="w3-input" type="text" id="addr3"
						name="addr3" readonly value="${ vo.addr3 }">
				</p>

				<p class="w3-center">
					<button type="submit"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round"
						id="btnUpdate">목록</button>
					<button type="submit"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round"
						id="btnDelete">삭제</button>
				</p>

				<%-- <td colspan="2" align="center"><input type="button" value="목록"
						id="btnUpdate"> <input type="button" value="삭제"
						id="btnDelete">
						<div style="color: red;">${message }</div></td> <a href="memberList"></a>
					</tr> --%>
			</form>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp"%>