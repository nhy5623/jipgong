<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<html>
<head>
<meta charset="UTF-8">
<script>
	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) { // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다. 
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수 
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외) // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				} // 건물명이 있고, 공동주택일 경우 추가한다. 
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				} // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다. 
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				} // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				} // 우편번호와 주소정보를 해당 필드에 넣는다. 
				console.log(data.zonecode);
				console.log(fullRoadAddr);

				$("[name=addr1]").val(data.zonecode);
				$("[name=addr2]").val(fullRoadAddr);
				/* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리
				새우편번호 사용 document.getElementById('signUpUserCompanyAddress').value =
				fullRoadAddr;
				document.getElementById('signUpUserCompanyAddressDetail').value =
				data.jibunAddress; */
			}
		}).open();
	}
</script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
<div id="mypage"><%@ include file="../login/mypage.jsp"%></div>

>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<p>${member.user_name }님의정보</p>
			</div>
			<div>
				<form id="myForm" action="../login/update_mypage" method="post">
					<p>
						<label>아이디</label> <input class="w3-input" type="text"
							id="user_id" name="user_id" readonly value="${ member.user_id }">
					</p>
					<p>
						<label>이름</label> <input class="w3-input" type="text"
							id="user_name" name="user_name" value="${ member.user_name }"
							required>
					</p>
					<p>
						<label>이메일</label> <input class="w3-input" type="text"
							id="user_email" name="user_email" value="${ member.user_email }"
							required>
					</p>

					<p>
						<label>전화번호</label> <input class="w3-input" type="text"
							id="user_phone" name="user_phone" value="${ member.user_phone }"
							required>
					</p>

					<p>
						<label>우편번호</label> <input class="w3-input" type="text" id="addr1"
							name="addr1" value="${ member.addr1 }" required>
						<button type="button" class="btn btn-default"
							onclick="execPostCode();">
							<i class="fa fa-search"></i> 우편번호 찾기
						</button>
					</p>
					<p>
						<label>주소</label> <input class="w3-input" type="text" id="addr2"
							name="addr2" value="${ member.addr2 }" required>
					</p>
					<p>
						<label>상세주소</label> <input class="w3-input" type="text" id="addr3"
							name="addr3" value="${ member.addr3 }" required>
					</p>
					<p class="w3-center">
						<button type="submit"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">회원정보
							변경</button>
					</p>
				</form>

				<br />

				<form id="pwForm" action="../login/update_pw" method="post">
					<input type="hidden" name="user_id" value="${ member.user_id }">
					<p>
						<label>새로운 비밀번호</label> <input class="w3-input" id="user_pw"
							name="user_pw" type="password">
					</p>
					<p>
						<label>비밀번호 확인</label> <input class="w3-input" type="password"
							id="user_pw2" type="password">
					</p>
					<p class="w3-center">
						<button type="submit" id="joinBtn"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">비밀번호
							변경</button>
					</p>
				</form>

				<br />
				<form id="wdForm" action="../login/withdrawal" method="post">
					<input type="hidden" name="user_id" value="${ member.user_id }">
					<p>
						<label>비밀번호</label> <input class="w3-input" name="user_pw"
							type="password" required>
					</p>
					<p class="w3-center">
						<button type="submit" id="withdrawalBtn"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">회원탈퇴
						</button>
					</p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

<%@ include file="../includes/footer.jsp"%>