<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../include/header.jsp"%>
<%@ include file="../include/nav2.jsp"%>
<section id="content">

 <div class="orderInfo">
  <c:forEach items="${orderView}" var="orderView" varStatus="status">
  
  <c:if test="${status.first}">
   <p><span>주문자</span>${orderView.user_id}</p>
   <p><span>수령인</span>${orderView.orderRec}</p>
   <p><span>주소</span>(${orderView.userAddr1}) ${orderView.userAddr2} ${orderView.userAddr3}</p>
   <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.amount}" /> 원</p>
   
  <div class="deliveryChange">
 <form role="form" method="post" class="deliveryForm">
 
  <input type="hidden" name="orderId" value="${orderView.orderId}" />
  <input type="hidden" name="delivery" class="delivery" value="" />
  
  <button type="button" class="delivery1_btn">배송 중</button>
  <button type="button" class="delivery2_btn">배송 완료</button>
  
  <script>
   $(".delivery1_btn").click(function(){
    $(".delivery").val("배송 중");
    run();
   });
   
   $(".delivery2_btn").click(function(){
    $(".delivery").val("배송 완료");
    run();
    
   });
   
   function run(){
    $(".deliveryForm").submit();
   }
  
  </script>
 </form>
</div>
  </c:if>
  
 </c:forEach>
</div>

<ul class="orderView">
 <c:forEach items="${orderView}" var="orderView">     
 <li>
<%--   <div class="thumb">
   <img src="${orderView.ThumbImg}" />
  </div> --%>
  <div class="gdsInfo">
   <p>
    <span>상품명</span>${orderView.proName}<br />
    <span>개당 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.price}" /> 원<br />
    <span>구입 수량</span>${orderView.cartStock} 개<br />
    <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.price * orderView.cartStock}" /> 원                  
   </p>
  </div>
 </li>     
 </c:forEach>
</ul>
</section>

<%@ include file="../include/footer.jsp"%>