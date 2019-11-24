<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="./includes/header.jsp"%>
<%@ include file="./includes/nav.jsp"%> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="favicon.ico">
<title> 집 공 </title>
<!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Custom styles for this template -->
<link href="resources/css/style.css" rel="stylesheet">
<style>
body{
 font-family:'Malgun Gothic';
} 
h2,p{
 font-family:'Malgun Gothic';

}
 

@import url(https://fonts.googleapis.com/css?family=Lato:400,700,900,300);
@import url(http://sarahcarneycreative.com/codepens/webfonts/font-awesome-4.5.0/css/font-awesome.min.css);

body { 
	height: 100%; width: 100%; 
	margin: 0;
	color: whitesmoke; 
	font-size: 16px; 
	font-family: 'Lato';
	background: url(http://sarahcarneycreative.com/codepens/images/bgs/stardust.png);
} 

h1 { 
	padding-bottom: 10px;
	font-size: 32px; 
	border-bottom: 1px solid tomato; 
}
h2 { font-size: 26px; }
h3 { font-size: 18px; }
p { margin: 15px 0; line-height: 24px; color: gainsboro; }
a { color: dodgerblue; text-decoration: none;  }
a:hover { color: tomato; }

.container { 
	max-width: 1045px; 
	height: 100%;
	margin: 0 auto; 
	padding: 20px;
}


	.gallery {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
	}

	/* combining styles common to every image */
	.gallery .pic,
	.gallery.two .pic, 
	.gallery.three .pic {
		display: block;
		height: 300px; width: 33.33%;
		background-position: top center, 0 0;
		background-blend-mode: color;
		cursor: pointer;
		transition: 0.5s;
	}

/* Images */
	.gallery .pic:nth-child(1) { 
		background: 
			linear-gradient(black, rgba(0,0,0,0)),
			url(https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-156593811497898382.jpg/640/640);
		background-size: 300px 1000px, cover;
	}
	.gallery .pic:nth-child(2) { 
		background: 
			linear-gradient(black, rgba(0,0,0,0)),
			url(https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-157114415358800095.jpg/640/640);
		background-size: 300px 1000px, cover;
	}
	.gallery .pic:nth-child(3) { 
		background: 
			linear-gradient(black, rgba(0,0,0,0)),
			url(https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-1520396569809_Xty.jpg/640/640);
		background-size: 300px 1000px, cover;
	}
	.gallery .pic:nth-child(4) { 
		background: 
			linear-gradient(black, rgba(0,0,0,0)),
			url(https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-1478798459410_QIwYFiAz.jpg/640/640);
		background-size: 300px 1000px, cover;
	}
	.gallery .pic:nth-child(5) { 
		background: 
			linear-gradient(black, rgba(0,0,0,0)),
			url(https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-1560486601685_xW.jpg/640/640);
		background-size: 300px 1000px, cover;
	}
	.gallery .pic:nth-child(6) { 
		background: 
			linear-gradient(black, rgba(0,0,0,0)),
			url(https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-productions-1527137912985_ugq8BBzY.jpg/640/640);
		background-size: 300px 1000px, cover;
	}

	
	.gallery .pic:hover,
	.gallery.two .pic:hover, 
	.gallery.three .pic:hover {	background-position: bottom center, 0 0; }

	@media (max-width: 800px) {
		.gallery .pic,
		.gallery.two .pic,
		.gallery.three .pic { width: 50%; }}

	@media (max-width: 580px) {
		.gallery .pic
		.gallery.two .pic,
		.gallery.three .pic { width: 100%; }}





</style>
</head>
<body id="page-top">
<!-- 형님 가구 -->
<div class="container">
	<div class="section-title">
		<h2> STORE </h2>
	</div>
	
	
	<div class="gallery">
		<div class="pic"></div>
		<div class="pic"></div>
		<div class="pic"></div>
		<div class="pic"></div>
		<div class="pic"></div>
		<div class="pic"></div>
	</div>
	
</div>

		
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<!--이미지 슬라이드  -->
<div id="wrapper">
		<div id="slider-wrap">
			<ul id="slider">
				<li data-color="#1abc9c">
					<div>
					<a href="/store/table">
						<h3>의자</h3>
						<span>상세보기</span> </a>
					</div>
					<a href="/store/table">
					 <img src="/resources/images/a.PNG">
					 </a>
				</li>
 
				<li data-color="#3498db">
					<div>
					<a href="/store/table">
						<h3>침구</h3>
						<span>상세보기</span>
					</a>
					</div>
					<a href="/store/table">
					 <img src="/resources/images/b.PNG">
					 </a>
				</li>

				<li data-color="#9b59b6">
					<div>
					<a href="/store/table">
						<h3>쿠션</h3>
						<span>상세보기</span>
					</a>
					</div> <a href="/store/table"><img src="/resources/images/c.PNG"></a>
				</li>

				<li data-color="#34495e">
					<div>
					<a href="/store/table">
						<h3>주방</h3>
						<span>상세보기</span>
					</a>
					</div><a href="/store/table"> <img src="/resources/images/e.PNG"></a>
				</li>

				<li data-color="#e74c3c">
					<div>
					<a href="/store/table">
						<h3>소파</h3>
						<span>상세보기</span>
					</a>
					</div> <a href="/store/table"><img src="/resources/images/sofa.PNG"></a>
				</li>
	

			</ul>

			<!--controls-->
			<div class="btns" id="next">
				<i class="fa fa-arrow-right"></i>
			</div>
			<div class="btns" id="previous">
				<i class="fa fa-arrow-left"></i>
			</div>
			<div id="counter"></div>

			<div id="pagination-wrap">
				<ul>
				</ul>
			</div>
			<!--controls-->

		</div>

	</div>
	<!-- 슬라이드 끝 -->
<section id="portfolio">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="section-title">
						<h2 >Community</h2>
						<p>추천 테마</p>
					</div>
				</div>
			</div>

			<div class="row row-0-gutter">


				<!-- start  item -->

				<c:forEach var="communityList" items="${communityList }">
					<c:if test="${communityList.community_admin == 0 }">
						<!-- 관리자 글만 출력  -->
						<div class="col-md-6 col-0-gutter">
							<div class="ot-portfolio-item">
								<figure class="effect-bubba">
									<a
										href="/community/getCommunityViewList?community_bno=${communityList.community_bno }">
										<img src="${communityList.gdsImg}" height=" 400" width="600" />
									</a>

									<figcaption>
										<h2>${communityList.community_thema}</h2>
										<!--테마   -->
										<p>Reference</p>
										<a href="#" data-toggle="modal"
											data-target="#Modal-${communityList.community_bno }">View
											more</a>
									</figcaption>
								</figure>
							</div>
						</div>
					</c:if>
				</c:forEach>

				<!-- end portfolio item -->
				<!--준영 수정끝  -->



			</div>
		</div>
		<!-- container -->
	</section>
		
	

	<script>
	//current position
	var pos = 0;
	//number of slides
	var totalSlides = $('#slider-wrap ul li').length;
	//get the slide width
	var sliderWidth = $('#slider-wrap').width();


	$(document).ready(function(){
	    
	    
	    /*****************
	     BUILD THE SLIDER
	    *****************/
	    //set width to be 'x' times the number of slides
	    $('#slider-wrap ul#slider').width(sliderWidth*totalSlides);
	    
	    //next slide    
	    $('#next').click(function(){
	        slideRight();
	    });
	    
	    //previous slide
	    $('#previous').click(function(){
	        slideLeft();
	    });
	    
	    
	    
	    /*************************
	     //*> OPTIONAL SETTINGS
	    ************************/
	    //automatic slider
	    var autoSlider = setInterval(slideRight, 3000);
	    
	    //for each slide 
	    $.each($('#slider-wrap ul li'), function() { 

	       //create a pagination
	       var li = document.createElement('li');
	       $('#pagination-wrap ul').append(li);    
	    });
	    
	    //counter
	    countSlides();
	    
	    //pagination
	    pagination();
	    
	    //hide/show controls/btns when hover
	    //pause automatic slide when hover
	    $('#slider-wrap').hover(
	      function(){ $(this).addClass('active'); clearInterval(autoSlider); }, 
	      function(){ $(this).removeClass('active'); autoSlider = setInterval(slideRight, 3000); }
	    );
	    
	    

	});//DOCUMENT READY
	    


	/***********
	 SLIDE LEFT
	************/
	function slideLeft(){
	    pos--;
	    if(pos==-1){ pos = totalSlides-1; }
	    $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));    
	    
	    //*> optional
	    countSlides();
	    pagination();
	}


	/************
	 SLIDE RIGHT
	*************/
	function slideRight(){
	    pos++;
	    if(pos==totalSlides){ pos = 0; }
	    $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos)); 
	    
	    //*> optional 
	    countSlides();
	    pagination();
	}



	    
	/************************
	 //*> OPTIONAL SETTINGS
	************************/
	function countSlides(){
	    $('#counter').html(pos+1 + ' / ' + totalSlides);
	}

	function pagination(){
	    $('#pagination-wrap ul li').removeClass('active');
	    $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
	}
	
	</script>


	

	


	<p id="back-top">
		<a href="#top"><i class="fa fa-angle-up"></i></a>
	</p>
	<!-- Modal for portfolio item 1 -->

	<c:forEach var="communityList" items="${communityList }">
		<div class="modal fade" id="Modal-${communityList.community_bno }"
			tabindex="-1" role="dialog" aria-labelledby="Modal-label-1">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<!-- <span aria-hidden="true">&times;</span> -->
						</button>
						<h4 class="modal-title" id="Modal-label-1">${communityList.community_thema}</h4>
						<!-- 테마 -->
					</div>
					<div class="modal-body">
						<img src="${communityList.gdsImg}" alt="img01"
							class="img-responsive" />
						<div class="modal-works">
							<span>추천 테마</span><span>자세히 보실려면 상세보기를 눌러주세요</span>
						</div>
						<p>${communityList.community_review}</p>
						<!--글내용  -->
					</div>
					<div class="modal-footer">
						<a
							href="/community/getCommunityViewList?community_bno=${communityList.community_bno}">
							<button type="button" class="btn btn-default">상세보기</button>
						</a>

						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>


	<!-- 모달끝 -->
</c:forEach>

	

	</div>
	</div>
	</div>


</body>
</html>

<%@ include file="./includes/footer.jsp"%>