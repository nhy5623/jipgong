<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
<style>
.inputArea {
	margin: 10px 0;
}

select {
	width: 100px;
}

label {
	display: inline-block;
	width: 70px;
	padding: 5px;
}

label[for='gdsDes'] {
	display: block;
}

input {
	width: 150px;
}

textarea#gdsDes {
	width: 400px;
	height: 180px;
}

.select_img img {
	width: 500px;
	margin: 20px 0;
}
</style>
<!--관리자 업로드폼  -->


<form role="form" method="post" autocomplete="off"
	enctype="multipart/form-data">

	<div class="inputArea">
		<label for="Community_bno">게시물<br></label> <input
			class="form-control" name="community_bno"
			value='<c:out value="${CommunityViewList.community_bno }"/>'
			readonly="readonly">
	</div>

	<div class="inputArea">
		<label for="Community_thema">테마</label> <input type="text"
			id="Community_thema" name="Community_thema"
			value="${CommunityViewList.community_thema}" />
	</div>

	<div class="inputArea">
		<label for="Community_id">아이디</label> <input type="text"
			id="Community_id" name="Community_id"
			value="${CommunityViewList.community_id}" readonly="readonly" />
	</div>

	<div class="inputArea">
		<label for="Community_good">좋아요</label> <input type="text"
			id="Community_good" name="Community_good"
			value="${CommunityViewList.community_good}" readonly="readonly" />
	</div>

	<div class="inputArea">
		<label for="Community_review">글내용</label>
		<textarea rows="5" cols="50" id="Community_review"
			name="Community_review">${CommunityViewList.community_review}</textarea>
	</div>

	<div class="inputArea">
		<label for="Community_viewcount">조회수</label> <input type="text"
			id="Community_viewcount" name="Community_viewcount"
			value="${CommunityViewList.community_viewcount}" readonly="readonly" />
	</div>
	<!--이미지 첨부  -->
	<div class="inputArea">
		<label for="gdsImg">이미지</label> <input type="file" id="gdsImg"
			name="file" />
		<div class="select_img">
			<img src="${CommunityViewList.gdsImg}" /> <input type="hidden"
				name="gdsImg" value="${CommunityViewList.gdsImg}" /> <input
				type="hidden" name="gdsThumbImg"
				value="${CommunityViewList.gdsThumbImg}" />

		</div>





		<div class="inputArea">
			<button type="submit" id="update_Btn" class="btn btn-primary">완료</button>
			<button type="submit" id="back_Btn" class="btn btn-warning">취소</button>
			
			
			
			<script>
			$("#back_Btn").click(
					function() {
					//history.back();
					location.href = "/community/communityModify?community_bno="	+${CommunityViewList.community_bno};
			});
			</script>
		</div>



		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">

					<div class="panel-heading"></div>




					<script>
						$("#gdsImg").change(
								function() {
									if (this.files && this.files[0]) {
										var reader = new FileReader;
										reader.onload = function(data) {
											$(".select_img img").attr("src",
													data.target.result).width(
													500);
										}
										reader.readAsDataURL(this.files[0]);
									}
								});
					</script>
					
						<div class="display-none">
					<label for="link1">링크 추가</label>
					<input type="text" id="link1" name="link1" />
			</div>
			
			<div class="display-none">
 				<label for="link2">링크 추가</label>
 					<input type="text" id="link2" name="link2" />
			</div>
			
			<div class="display-none">
 				<label for="link3">링크 추가</label>
 					<input type="text" id="link3" name="link3" />
			</div>
			
			<div class="display-none">
 				<label for="link4">링크 추가</label>
 					<input type="text" id="link4" name="link4" />
			</div>
			
			<div class="display-none">
 				<label for="link5">링크 추가</label>
 					<input type="text" id="link5" name="link5" />
			</div>
					<div class="display-none">
 			<label for="community_admin">일반사용자사서1들어감</label>
 			<input id="community_admin" name="community_admin"value='<c:out value="${1}"/>'>
		</div>
				</div>
				<!--이미지첨부 끝  -->


				<div class="uploadResult">
					<ul></ul>
				</div>
			</div>

		</div>
	</div>

</form>



<%@ include file="../includes/footer.jsp"%>