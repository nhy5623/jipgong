<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
<section id="content">
 
<ul class="orderList">
  <c:forEach items="${orderList}" var="orderList">
  <li>
  <div>
   <p><span>주문번호</span><a href="/store/orderView?n=${orderList.orderId}">${orderList.orderId}</a></p>
   <p><span>수령인 : </span>${orderList.orderRec}</p>
   <p><span>주소 - </span>(${orderList.userAddr1}) ${orderList.userAddr2} ${orderList.userAddr3}</p>
   <p><span>가격 : </span><fmt:formatNumber pattern="###,###,###" value="${orderList.amount}" /> 원</p>
   <p><span>상태 - </span>${orderList.delivery }</p>
  </div>
  </li>
  </c:forEach>
 </ul>
 
 
 
</section>







<%@ include file="../includes/footer.jsp"%>