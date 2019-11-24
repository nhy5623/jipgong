<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<style type="text/css">


.box-part{
   
    border-radius:0;
    padding:60px 10px;
    margin:30px 0px;
}
.text{
    margin:20px 0px;
}

.fa{
     color:#4183D7;
}
body, hmtl{background: #ffffff; font-family: 'Anton', sans-serif;}
</style>
</head>



</body>
 <div class="box">
    <div class="container">
     	<div class="row">
			 
			    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
                        
                       
                        
						<div class="title">
							<h4>내 정보</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/내정보.JPG">
						</div>
                        
						<a href="/login/member">내정보</a>
                        
					 </div>
				</div>	 
				
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
					    
					    
                    
						<div class="title">
							<h4>내 게시글</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/MC.JPG" height=" 80" width="100">
						</div>
                        
						<a href="/community/getUserCommunityList">내 게시글</a>
                        
					 </div>
				</div>	 
				
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
                        
                     
                        
						<div class="title">
							<h4>Q&A</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/mq.JPG" height=" 100" width="100">
						</div>
                        
						<a href="/board/mypage">Q&A</a>
                        
					 </div>
				</div>	 
				
				<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
                        
						<div class="title">
							<h4>배송/주문 조회</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/주문조회.JPG" height=" 100" width="100">
						</div>
                        
						<a href="/store/orderList">배송/주문 조회</a>
                        
					 </div>
				</div>	 
				
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
					    
					   
						<div class="title">
							<h4>장바구니</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/장바구니.JPG" height=" 100" width="100">
						</div>
                        
						<a href="/store/cartList">장바구니</a>
                        
					 </div>
				</div>	 
				
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
                        
                        
						<div class="title">
							<h4>구매 목록</h4>
						</div>
                        
						<div class="text">
							<span>Lorem ipsum dolor sit amet, id quo eruditi eloquentiam. Assum decore te sed. Elitr scripta ocurreret qui ad.</span>
						</div>
                        
						<a href="#">Learn More</a>
                        
					 </div>
				</div>
		
		</div>		
    </div>
</div>
 
 

<%@ include file="../includes/footer.jsp"%>