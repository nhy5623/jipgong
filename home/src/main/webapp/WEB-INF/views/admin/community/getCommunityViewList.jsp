<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../include/header.jsp"%>


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
.hero {
  padding: 6.25rem 0px !important;
  margin: 0px !important;
}
.cardbox {
  border-radius: 3px;
  margin-bottom: 20px;
  padding: 0px !important;
}

/* ------------------------------- */
/* Cardbox Heading
---------------------------------- */
.cardbox .cardbox-heading {
  padding: 16px;
  margin: 0;
}
.cardbox .btn-flat.btn-flat-icon {
 border-radius: 50%;
 font-size: 24px;
 height: 32px;
 width: 32px;
 padding: 0;
 overflow: hidden;
 color: #fff !important;
 background: #b5b6b6;
 
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
text-align: center;
}
.cardbox .float-right .dropdown-menu{
  position: relative;
  left: 13px !important;  
}
.cardbox .float-right a:hover{
  background: #f4f4f4 !important;	
}
.cardbox .float-right a.dropdown-item {
  display: block;
  width: 100%;
  padding: 4px 0px 4px 10px;
  clear: both;
  font-weight: 400;
  font-family: 'Abhaya Libre', serif;
  font-size: 14px !important;
  color: #848484;
  text-align: inherit;
  white-space: nowrap;
  background: 0 0;
  border: 0;
}

/* ------------------------------- */
/* Media Section
---------------------------------- */
.media {
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: start;
  align-items: flex-start;
}
.d-flex {
  display: -ms-flexbox !important;
  display: flex !important;
}
.media .mr-3{
  margin-right: 1rem !important;
}
.media img{
  width: 48px !important;
  height: 48px !important;
  padding: 2px;
  border: 2px solid #f4f4f4;
} 
.media-body {
  -ms-flex: 1;
  flex: 1;
  padding: .4rem !important;
}
.media-body p{
  font-family: 'Rokkitt', serif;	
  font-weight: 500 !important;
  font-size: 14px;
  color: #88898a;
}
.media-body small span{
  font-family: 'Rokkitt', serif;	
  font-size: 12px;
  color: #aaa;
  margin-right: 10px;
}


/* ------------------------------- */
/* Cardbox Item
---------------------------------- */
.cardbox .cardbox-item {
    position: relative;
    display: block;
}
.cardbox .cardbox-item img{
    width: 790px;
   	margin-bottom: 15px;
}
.img-responsive{
    display: block;
    max-width: 90%;
    height: auto;
}	
.fw {
    width: 100% !important;
	height: auto;
}


/* ------------------------------- */
/* Cardbox Base
---------------------------------- */
.cardbox-base{
 border-bottom: 2px solid #f4f4f4;
}	
.cardbox-base ul{
 margin: 10px 0px 10px 15px!important; 
 padding: 10px !important;
 font-size: 0px;	
  display: inline-block;
}
.cardbox-base li {
  list-style: none;
  margin: 0px 0px 0px -8px !important;
  padding: 0px 0px 0px 0px !important;
  display: inline-block;
}

.cardbox-base li a{
  margin: 0px !important;
  padding: 0px !important;
}
.cardbox-base li a i{
 position: relative;
 top: 4px; 
 font-size: 16px;
 color: #8d8d8d;
 margin-right: 15px;
}
.cardbox-base li a span{
 font-family: 'Rokkitt', serif;
 font-size: 14px;
 color: #8d8d8d;
 margin-left: 20px;
 position: relative;
 top: 5px; 
}
.cardbox-base li a em{
 font-family: 'Rokkitt', serif;
 font-size: 14px;
 color: #8d8d8d;
 position: relative;
 top: 3px; 
}
.cardbox-base li a img{
  width: 25px;
  height: 25px;
  margin: 0px !important;
  border: 2px solid #fff;
}


/* ------------------------------- */
/* Cardbox Comments
---------------------------------- */
.cardbox-comments{
  padding: 10px 40px 20px 40px !important;
  font-size: 0px;	
  text-align: center;
  display: inline-block;
}
.cardbox-comments .comment-avatar img{
  margin-top: 1px;
  margin-right: 10px;
  position: relative;
  display: inline-block;
  text-align: center;
  width: 40px;
  height: 40px;
}
.cardbox-comments .comment-body {
  overflow: auto;
}
.search {
 position: relative;
 right: -60px;
 top: -40px;
 margin-bottom: -40px;
 border: 2px solid #f4f4f4;	
 width: 100%;
 overflow: hidden;
}
.search input[type="text"] {
 background-color: #fff;
 line-height: 10px;
 padding: 15px 60px 20px 10px;
 border: none;
 border-radius: 4px;
 width: 350px;
 font-family: 'Rokkitt', serif;
 font-size: 14px;
 color: #8d8d8d;
 height: inherit;
 font-weight: 700;
}
.search button {
 position: absolute;
 right: 0;
 top: 0px;
 border: none;
 background-color: transparent;
 color: #bbbbbb;
 padding: 15px 25px;
 cursor: pointer;
 
 display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
text-align: center;
}
.search button i {
 font-size: 20px;
 line-height: 30px;
 display: block;
}


/* ------------------------------- */
/* Author
---------------------------------- */
.author a{

 font-size: 16px;
 color: #00C4CF;
}
.author p{
 font-family: 'Rokkitt', serif;
 font-size: 16px;
 color: #8d8d8d;
}
.col-lg-3{
	float: right;	
}
.viewcount{
	width: 30px;
	background-color: transparent;
    border: 0 solid black;
    text-align: right;
}
</style>


<form id="operForm" method="post" autocomplete="off">
	<input type="hidden" id="community_bno" name="community_bno"
		value="${CommunityViewList.community_bno }" />

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"></div>
				<div class="panel-body">
	
				
<!--겟 리스트   -->
  <section class="hero">
         <div class="container">
          <div class="row">	
		  
		   <div class="col-lg-6 offset-lg-3">
			
			<div class="cardbox shadow-lg bg-white">
			 
			 <div class="cardbox-heading">
			  <!-- START dropdown-->
			  <div class="dropdown float-right">
			   
			   <div class="dropdown-menu dropdown-scale dropdown-menu-right" role="menu" style="position: absolute; transform: translate3d(-136px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
				<a class="dropdown-item" href="#">Hide post</a>
				<a class="dropdown-item" href="#">Stop following</a>
				<a class="dropdown-item" href="#">Report</a>
			   </div>
			  </div><!--/ dropdown -->
			  <div class="media m-0">
			   <div class="d-flex mr-3">
				<img class="img-fluid rounded-circle" src="http://www.themashabrand.com/templates/bootsnipp/post/assets/img/users/4.jpg" alt="User">
			   </div>
			   <div class="media-body">
			    <p class="m-0">${CommunityViewList.community_id }</p>
				
				
			   </div>
			  </div><!--/ media -->
			 </div><!--/ cardbox-heading -->
			  
			 <div class="cardbox-item">
			  <img class="img-fluid" src="${CommunityViewList.gdsImg}" alt="Image">
			  
			  
			 </div><!--/ cardbox-item -->
			  <div class="col-lg-3">
			<div class="shadow-lg p-4 mb-2 bg-white author">
			 <c:if test="${CommunityViewList.link1 != null }">
						 <a href="<c:out value='${CommunityViewList.link1 }'/>">
								<input class="form-control" name="link1" type="button"
								value='의자' />
								 <!--사진으로 넘어가거나 번호를 준다.	널값이면 숨길수있게 설정  -->
							</a>
						</c:if>
			 
			</div>
		   </div><!--/ col-lg-3 -->
		   
		     <div class="col-lg-3">
		     
		     
			<div class="shadow-lg p-4 mb-2 bg-white author">
			 <c:if test="${CommunityViewList.link2 != null }">
						 <a href="<c:out value='${CommunityViewList.link2 }'/>">
								<input class="form-control" name="link1" type="button"
								value='침대' />
								 <!--사진으로 넘어가거나 번호를 준다.	널값이면 숨길수있게 설정  -->
							</a>
						</c:if>
			 
			</div>
		   </div><!--/ col-lg-3 -->
		   
		     <div class="col-lg-3">
		     
		     
			<div class="shadow-lg p-4 mb-2 bg-white author">
			 <c:if test="${CommunityViewList.link3 != null }">
						 <a href="<c:out value='${CommunityViewList.link3 }'/>">
								<input class="form-control" name="link1" type="button"
								value='테이블' />
								 <!--사진으로 넘어가거나 번호를 준다.	널값이면 숨길수있게 설정  -->
							</a>
						</c:if>
			 
			</div>
		   </div><!--/ col-lg-3 -->
		   
		   
		     <div class="col-lg-3">
		     
		     
			<div class="shadow-lg p-4 mb-2 bg-white author">
			 <c:if test="${CommunityViewList.link4 != null }">
						 <a href="<c:out value='${CommunityViewList.link4 }'/>">
								<input class="form-control" name="link1" type="button"
								value='조명' />
								 <!--사진으로 넘어가거나 번호를 준다.	널값이면 숨길수있게 설정  -->
							</a>
						</c:if>
			 
			</div>
		   </div><!--/ col-lg-3 -->
		   
		   
		     <div class="col-lg-3">
		     
		     
			<div class="shadow-lg p-4 mb-2 bg-white author">
			 <c:if test="${CommunityViewList.link5 != null }">
						<a href="<c:out value='${CommunityViewList.link5 }'/>">
								<input class="form-control" name="link1" type="button"
								value='수납장' />
								 <!--사진으로 넘어가거나 번호를 준다.	널값이면 숨길수있게 설정  -->
							</a>
						</c:if>
			 
			</div>
		   </div><!--/ col-lg-3 -->
		
	
			  	  			  			   
			 </div><!--/ cardbox-base -->
					 <div>
						조회수 :<input class="viewcount" name="community_viewcount"
							value='<c:out value="${CommunityViewList.community_viewcount }"/>'
							readonly="readonly">
					 </div>
					
					
					
					
			 	 <div style="text-align: right">좋아요 수 :<c:out value="${CommunityViewList.community_good }"/>
     					  <a class="btn btn-outline-dark heart">좋아요<img id="heart" src=""></a>
 				</div>
			  
			 <script>
    $(document).ready(function () {

        var heartval = ${heart};
              
        if(heartval>1) {
            console.log(heartval);
            $("#heart").prop("src", "/resources/images/like1.png");
            $(".heart").prop('name',heartval)
        }
        else {
            console.log(heartval);
            $("#heart").prop("src", "/resources/images/like2.png");
            $(".heart").prop('name',heartval)
        }

        $(".heart").on("click", function () {

            var that = $(".heart");

            var sendData = {
            		"community_bno" : "${CommunityViewList.community_bno }",
            		'heart' : that.prop('name')};
            
            $.ajax({url :"/admin/community/getCommunityViewList/heart",                
                type :'POST',
                data : sendData,
                success : function(data){
                    that.prop('name',data);
                    if(data==1) {
                        $('#heart').prop("src","/resources/images/like1.png");
                    }
                    else{
                        $('#heart').prop("src","/resources/images/like2.png");
                    }

                    
                }
            });
        });
    });
</script>
			 
			 
			 
			 
					<div class="form-group">
						글내용
						<textarea rows="5" cols="50" class="form-control"
							name="community_review" readonly="readonly"><c:out
								value="${CommunityViewList.community_review }" /></textarea>

					</div>
		<div id="reply">

						<c:if test="${member.user_id == null }">
							<!--로그인 이랑 연동  -->
							<p>
								소감을 남기시려면 <a href="/login/login">로그인 </a>해주세요
							</p>
						</c:if>

						<c:if test="${member.user_id != null}">
							<section class="replyForm">
								<form role="form" method="post" autocomplete="off">

									<input type="hidden" name="community_bno" id=community_bno
										value="${CommunityViewList.community_bno}">

									<div class="input_area">
										<textarea name="repCon" id="repCon"></textarea>
									</div>

									<div class="input_area">
										<button type="button" id="reply_btn">댓글 추가</button>
								<!-- 댓글 추가 버튼 스크립트 -->
								<script>
									$("#reply_btn").click(function() {
														var formObj = $(".replyForm form[role='form']");
														var community_bno = $("#community_bno").val();
														var repCon = $("#repCon").val()
														var data = {
															community_bno : community_bno,
															repCon : repCon
														};
										$.ajax({url : "/admin/community/getCommunityViewList/registReply",
											type : "post",
											data : data,
											success : function() {
												replyList();
												$("#repCon").val("");
											}
										});															
									});
								</script>
									
									</div>


								</form>
							</section>
						</c:if>

					</div>
					
					
					
						<!-- 댓글 출력  -->
						<section class="replyList">
							<ol>
							</ol>				
						
							<script>
								replyList();
							</script>
						</section>
							
							
							
<!-- 덧글  삭제 스크립트  -->							
<script>
 $(document).on("click", ".delete", function(){
	 
  var deletConfirm = confirm("정말로 삭제하시겠습니까?");
	 
  if(deletConfirm){
	  
  var data = {repNum : $(this).attr("data-repNum")};
   
  $.ajax({
   url : "/admin/community/getCommunityViewList/deleteReply",
   type : "post",
   data : data,
   success : function(result){  
	   
    
     replyList();
  
   },
   error : function(){
 	   alert("로그인하셔야합니다.")
   }
  });
  
  
  }
 });
</script>		  
					
			</div><!--/ cardbox -->

           </div><!--/ col-lg-6 -->	
           
		  
		   
			
          </div><!--/ row -->
         </div><!--/ container -->
        </section>


					</div>
					</div>
					</div>
					</div>
					<!--댓글 div끝  -->

					<!--수정, 삭제  -->
					<a
						href="/admin/community/communityModify?community_bno=${CommunityViewList.community_bno }">
						<button data-oper="modify" class="btn btn-warning">수정</button>
					</a>


					<button type="button" id="delete_Btn" class="btn btn-danger">삭제</button>

					<a href="/community/communityList">
						<button data-oper="list" class="btn btn-info" type="button">
							목록</button>
					</a>
</form>
<br />


<!--리플 수정 모달  -->
<div class="replyModal">
 <div class="modalContent">
    <div>
   <textarea class="modal_repCon" name="modal_repCon"></textarea>
  </div>
    <div>
   <button type="button" class="modal_modify_btn">수정</button>
   <button type="button" class="modal_cancel">취소</button>
  </div>
   </div>
 <div class="modalBackground"></div>
</div>

<script>
$(".modal_cancel").click(function(){
// $(".replyModal").attr("style", "display:none;");
$(".replyModal").fadeOut(200);
});
</script>



<script>
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/admin/community/communityModify")
			operForm.attr("method", "get")
			operForm.submit();
		});
		/* 수정 */

		/*글 삭제 */
		$("#delete_Btn").click(function() {
			operForm.attr("action", "/admin/community/communityDelete");
			operForm.submit();
		});

	});
</script>



<script>
	$("#reply_btn").click(function() {

		var formObj = $(".replyForm form[role='form']");
		var community_bno = $("#community_bno").val();
		var repCon = $("#repCon").val()

		var data = {
			community_bno : community_bno,
			repCon : repCon
		};

		$.ajax({
			url : "/admin/community/getCommunityViewList",
			type : "post",
			data : data,
			success : function() {
				replyList();
				$("#repCon").val("");
			}
		});
	});
</script>


<!--덧글 수정 스크립트  -->
<script >
$(".modal_modify_btn").click(function(){
 var modifyConfirm = confirm("정말로 수정하시겠습니까?");
 
 if(modifyConfirm) {
  var data = {
     repNum : $(this).attr("data-repNum"),
     repCon : $(".modal_repCon").val()
    };  // ReplyVO 형태로 데이터 생성
  
  $.ajax({
   url : "/admin/community/getCommunityViewList/modifyReply",
   type : "post",
   data : data,
   success : function(result){
    
   
     replyList();
     $(".replyModal").fadeOut(200);
    
   },
   error : function(){
    alert("로그인하셔야합니다.")
   }
  });
 }
 
});

</script>
<!-- 덧글  수정 스크립트  -->						
<script>							
$(document).on("click", ".modify", function(){
 //$(".replyModal").attr("style", "display:block;");
 $(".replyModal").fadeIn(200);
 
 var repNum = $(this).attr("data-repNum");
 var repCon = $(this).parent().parent().children(".replyContent").text();
 
 $(".modal_repCon").val(repCon);
 $(".modal_modify_btn").attr("data-repNum", repNum);
 
});							
</script>							


<script>
	function replyList() {

		var community_bno = ${CommunityViewList.community_bno};
		$.getJSON("/community/getCommunityViewList/replyList"+ "?community_bno=" + community_bno,function(data) {
							var str = "";
							$(data).each(
											function() {
												console.log(data);
												var repDate = new Date(
														this.repDate);
												repDate = repDate
														.toLocaleDateString("ko-US")
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


<%@ include file="../include/footer.jsp"%>