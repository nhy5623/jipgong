<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로
표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="./include/header.jsp"%>
<%@ include file="./include/nav.jsp"%>
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
<title>Treviso - Clean & Elegant Onepage Multipurpose Bootstrap
	HTML</title>
<!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Custom styles for this template -->
<link href="resources/css/style.css" rel="stylesheet">
<style type="text/css">

.box{
    padding:60px 0px;
}

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
<body>
<div class="box">
    <div class="container">
     	<div class="row">
			 
			    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
                        
                        
                        
						<div class="title">
							<h4>회원 정보</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/내정보.JPG">
						</div>
                        
						<a href="/admin/login/memberList">회원 정보</a>
                        
					 </div>
				</div>	 
				
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
					    
					     
                    
						<div class="title">
							<h4>Community</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/MC.JPG" height=" 80" width="100">
						</div>
                        
						<a href="/admin/community/communityList">커뮤니티</a>
                        
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
                        
						<a href="/admin/board/QnA">Q&A</a>
                        
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
                        
						<a href="/admin/store/orderList">배송/주문 조회</a>
                        
					 </div>
				</div>	 
				
				 
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
                        
                        
						<div class="title">
							<h4>주문 승인</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/1111.JPG" height=" 100" width="100">
						</div>
                        
						<a href="/admin/store/orderList">주문 승인</a>
                        
					 </div>
				</div>
				
				 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
               
					<div class="box-part text-center">
                        
                        
						<div class="title">
							<h4>스토어</h4>
						</div>
                        
						<div class="text">
							<img src="/resources/images/그림판.JPG" height=" 100" width="100">
						</div>
                        
						<a href="/admin/store/storeList">스토어</a>
                        
					 </div>
				</div>
		
		</div>		
    </div>
</div>


</body>
</html>
<%@ include file="./include/footer.jsp"%>