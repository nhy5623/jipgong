<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
 
<!--댓글 불러오기  -->
<script>
	function replyList() {

		var community_bno = ${CommunityViewList.community_bno};
		$.getJSON("/community/getCommunityViewList/replyList"+ "?community_bno=" + community_bno,function(data) {
							var str = "";
							$(data).each(function() {
												console.log(data);
												var repDate = new Date(
														this.repDate);
												repDate = repDate.toLocaleDateString("ko-US")
												str += "<li data-repNum='" + this.repNum + "'>"
														+ "<div class='userInfo'>"
														+ "<span class='user_name'>"
														+ this.user_name
														+ "</span>"
														+ "<span class='date'>"
														+ repDate
														+ "</span>"
														+ "</div>"
														+ "<div class='replyContent'>"
														+ this.repCon
														+ "</div>"
														+ "<c:if test='${member != null}'>"
														+ "<div class='replyFooter'>"
														+ "<button type='button' class='modify' data-repNum='" + this.repNum + "'>수정</button>"
														+ "<button type='button' class='delete' data-repNum='" + this.repNum + "'>삭제</button>"
														+ "</div>"
														+ "</c:if>"
														+ "</li>";
											});
							$("section.replyList ol").html(str);
						});
	}
</script>


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
	width: 200px;
	height: 200px;
}

.oriImg {
	width: 200px;
	height: 200px;
}

.thumbImg {
	
}
/* 리스트 스타일 */
.grid figure {
	position: relative;
	float: left;
	overflow: hidden;
	background: #3085a3;
	text-align: center;
	cursor: pointer;
}

.grid figure img {
	position: relative;
	display: block;
	min-height: 100%;
	max-width: 100%;
	opacity: 0.8;
	margin: 0;
}

.grid figure figcaption {
	padding: 2em;
	color: #fff;
	text-transform: uppercase;
	font-size: 1.25em;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
}

.grid figure figcaption::before, .grid figure figcaption::after {
	pointer-events: none;
}

.grid figure figcaption, .grid figure figcaption>a {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.grid figure figcaption>a {
	z-index: 1000;
	text-indent: 200%;
	white-space: nowrap;
	font-size: 0;
	opacity: 0;
}

.grid figure h2 {
	word-spacing: -0.15em;
	font-weight: 300;
}

.grid figure h2 span {
	font-weight: 800;
}

.grid figure h2, .grid figure p {
	margin: 0;
}

.grid figure p {
	letter-spacing: 1px;
	font-size: 68.5%;
}

figure.effect-ravi {
	background: #303fa9;
	margin: 0;
}

.grid [class^="col"] {
	padding: 2px;
}

figure.effect-ravi h2 {
	font-size: 158.75%;
}

figure.effect-ravi h2, figure.effect-ravi p {
	position: absolute;
	top: 50%;
	left: 50%;
	-webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
	transition: opacity 0.35s, transform 0.35s;
	-webkit-transform: translate3d(-50%, -50%, 0);
	transform: translate3d(-50%, -50%, 0);
	-webkit-transform-origin: 50%;
	transform-origin: 50%;
}

figure.effect-ravi figcaption::before {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 120px;
	height: 120px;
	border: 2px solid #fff;
	content: '';
	opacity: 0;
	-webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
	transition: opacity 0.35s, transform 0.35s;
	-webkit-transform: translate3d(-50%, -50%, 0) rotate3d(0, 0, 1, -45deg)
		scale3d(0, 0, 1);
	transform: translate3d(-50%, -50%, 0) rotate3d(0, 0, 1, -45deg)
		scale3d(0, 0, 1);
	-webkit-transform-origin: 50%;
	transform-origin: 50%;
}

figure.effect-ravi p {
	width: 100px;
	text-transform: none;
	font-size: 121%;
	line-height: 2;
}

figure.effect-ravi p a {
	color: #fff;
}

figure.effect-ravi p a:hover, figure.effect-ravi p a:focus {
	opacity: 0.6;
}

figure.effect-ravi p a i {
	opacity: 0;
	-webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
	transition: opacity 0.35s, transform 0.35s;
}

figure.effect-ravi p a:first-child i {
	-webkit-transform: translate3d(-60px, -60px, 0);
	transform: translate3d(-60px, -60px, 0);
}

figure.effect-ravi p a:nth-child(2) i {
	-webkit-transform: translate3d(60px, -60px, 0);
	transform: translate3d(60px, -60px, 0);
}

figure.effect-ravi p a:nth-child(3) i {
	-webkit-transform: translate3d(-60px, 60px, 0);
	transform: translate3d(-60px, 60px, 0);
}

figure.effect-ravi p a:nth-child(4) i {
	-webkit-transform: translate3d(60px, 60px, 0);
	transform: translate3d(60px, 60px, 0);
}

figure.effect-ravi:hover figcaption::before {
	opacity: 1;
	-webkit-transform: translate3d(-50%, -50%, 0) rotate3d(0, 0, 1, -45deg)
		scale3d(1, 1, 1);
	transform: translate3d(-50%, -50%, 0) rotate3d(0, 0, 1, -45deg)
		scale3d(1, 1, 1);
}

figure.effect-ravi:hover h2 {
	opacity: 0;
	-webkit-transform: translate3d(-50%, -50%, 0) scale3d(0.8, 0.8, 1);
	transform: translate3d(-50%, -50%, 0) scale3d(0.8, 0.8, 1);
}

figure.effect-ravi:hover p i:empty {
	-webkit-transform: translate3d(0, 0, 0);
	transform: translate3d(0, 0, 0);
	/* just because it's stronger than nth-child */
	opacity: 1;
}
</style>



<!-- <a href="/community/registerCommunity">글작성</a> -->

		
	<div class="container">
<c:if test="${member.user_id != null}">
			<a href="/community/registerCommunity" style="float:right;">글작성</a>
		</c:if>
<h3>유저 게시물 </h3>

<c:forEach var="communityList" items="${communityList }">
		<c:if test="${communityList.community_admin != 0 }"><!-- 관리자 글만 출력  -->
	<div class="grid">
		<!-- <div class="row"> -->
			<div class="col-md-4">
				<figure class="effect-ravi">
				<a href="/community/getCommunityViewList?community_bno=${communityList.community_bno }">
					<img src="${communityList.gdsImg}" class="oriImg" />	
						<figcaption>
						<h2>${communityList.community_thema}</h2>
						조회수 <span>${communityList.community_viewcount}</span>
						
						
					</figcaption>
				</a>
				</figure>
			</div>
			
		<!-- </div> -->

	</div>
</c:if>
</c:forEach>
</div>

<script>
$(".move").on("click", function(e) {
e.preventDefault();
actionForm.append("<input type='hidden' name='community_bno' "
+"value='"+$(this).attr("href")+"'>");
actionForm.attr("action","/communityList/get");
actionForm.submit();
});
</script>

<%@ include file="../includes/footer.jsp"%>