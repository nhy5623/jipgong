<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<%@ include file="../includes/header.jsp"%>

<style>
#signup {
	margin: 100px;
}
</style>

<div id="signup">
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h2>회원가입</h2>
				<br>
				<div>
					<form method="post">
						<!-- 아이디 -->
						<p>
							<label for="user_id">아이디</label> <input class="w3-input"
								style="width: 80%; display: inline;" type="text" id="user_id"
								name="user_id" required placeholder="아이디를 입력해주세요">
							<button type="button" class="idCheck">아이디 확인</button>
						<p class="result">
							<span class="msg">입력하신 아이디를 확인해주세요</span>
						</p>
						</p>

						<!-- 비밀번호 -->
						<p>
							<label for="user_pw">비밀번호</label> <input class="w3-input"
								style="width: 90%; display: inline;" type="password"
								id="user_pw" name="user_pw" required placeholder="비밀번호를 입력해주세요">
						</p>


						<br>
						<!-- 비밀번호 재입력 -->
						<p>
							<label for="user_pw2">비밀번호 확인</label> <input class="w3-input"
								style="width: 85%; display: inline;" type="password"
								id="user_pw2" name="user_pw2" required
								placeholder="비밀번호를 다시 입력해주세요">
						</p>


						<br>

						<!-- 이름 -->
						<p>
							<label for="user_name">이름</label> <input class="w3-input"
								style="width: 90%; display: inline;" type="text" id="user_name"
								name="user_name" required placeholder="이름을 입력해주세요">
						</p>
						<br>

						<!-- 생년월일 -->
						<p>
							<label for="userbirth">생년월일</label> <input class="w3-input"
								style="width: 90%; display: inline;" type="text" id="user_birth"
								name="user_birth" required placeholder="ex) 19990415 ">
						</p>

						<br>
						<!-- 휴대전화 -->
						<p>
							<label for="userphone">전화번호 </label> <input class="w3-input"
								style="width: 90%; display: inline;" type="text" id="user_phone"
								name="user_phone" required
								placeholder="전화번호를 입력해주세요('-' 없이 번호만 입력해주세요)">
						</p>


						<br>
						<!-- 이메일 -->
						<p>
							<label for="user_email">이메일</label> <input class="w3-input"
								style="width: 80%; display: inline;" type="text"
								name="user_email" id="user_email" required
								placeholder="이메일을 입력해주세요">

							<button type="button" class="emailCheck">이메일 확인</button>
						<p class="result2">
							<span class="msg">이메일 형식에 맞춰 작성해주세요</span>
						</p>

						</p>

						<br>
						<!-- 주소 -->
						<p>
							<input class="form-control" placeholder="우편번호" name="addr1"
								style="width: 80%; display: inline;" id="addr1" type="text"
								readonly="readonly">
							<button type="button" class="btn btn-default"
								onclick="execPostCode();">
								<i class="fa fa-search"></i> 우편번호 찾기
							</button>
						</p>
						<p>
							<input class=" w3-input form-control"
								style="width: 100%; display: inline;" placeholder="도로명 주소"
								name="addr2" id="addr2" type="text" readonly="readonly" />
						</p>
						<p>
							<input class="w3-input" placeholder="상세주소" name="addr3"
								style="width: 100%; display: inline;" id="addr3" type="text"
								required />
						</p>

						<p class="w3-center">
							<button type="submit"
								class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Join</button>
							<button type="button" onclick="history.go(-1);"
								class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
						</p>
						<!-- 서버 금지를 풀어줌.(403오류 해결) -->
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }" />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
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
<script>
	$(".idCheck").click(function() {
		var query = {
			user_id : $("#user_id").val()
		};
		if (query.user_id.length) {
			$.ajax({
				url : "/login/signup/idCheck",
				type : "post",
				data : query,
				success : function(result) {
					console.log(result);
					if (result == 1) {
						$(".result .msg").text("사용 불가능한 아이디입니다.");
						$(".result .msg").attr("style", "color:#f00");
						$("#submit").attr("disabled", "disabled");
					} else {
						$(".result .msg").text("사용 가능한 아이디입니다.");
						$(".result .msg").attr("style", "color:#00f");
						$("#submit").removeAttr("disabled");
						console.log(result);
					}
				}
			}); // ajax 끝
		} else {
			alert("아이디 입력을 해주세요.");
		}

	}); // 아이디 체크 끝

	//이메일확인
	$(".emailCheck").click(function() {
		var query = {
			user_email : $("#user_email").val()
		};
		if (query.user_email.length) {
			$.ajax({
				url : "/login/signup/emailCheck",
				type : "post",
				data : query,
				success : function(result2) {
					console.log(result2);
					if (result2 == 1) {
						$(".result2 .msg").text("사용 불가능한 이메일입니다.");
						$(".result2 .msg").attr("style", "color:#f00");
						$("#submit").attr("disabled", "disabled");
					} else {
						$(".result2 .msg").text("사용 가능한 이메일입니다.");
						$(".result2 .msg").attr("style", "color:#00f");
						$("#submit").removeAttr("disabled");
						console.log(result2);
					}
				}
			}); // ajax 끝
		} else {
			alert("이메일을 입력을 해주세요.");
		}

	}); // 아이디 체크 끝

	$(function() {

		//비밀번호 확인
		$('#user_pw2').blur(function() {
			if ($('#user_pw').val() != $('#user_pw2').val()) {
				if ($('#user_pw2').val() != '') {
					alert("비밀번호가 일치하지 않습니다.");
					$('#user_pw2').val('');
					$('#user_pw2').focus();
				}
			}
		})
	});//비밀번호 확인 끝
</script>






