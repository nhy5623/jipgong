<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>



<div class="container">

	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-body p-0">
					<c:forEach items="${orderView}" var="orderView" varStatus="status">
						<c:if test="${status.first}">
							<div class="row p-5">
								<div class="col-md-6">
									<div class="thumb">
										<img src="${orderView.img}">
									</div>
								</div>
							</div>
							<hr class="my-5">
							<div class="row pb-5 p-5">
								<div class="col-md-6">
									<p class="font-weight-bold mb-4">배송 정보</p>
									<p class="mb-1">수령인 : ${orderView.orderRec}</p>
									<p>주소</p>
									<p>번지 - ${orderView.userAddr1}</p>
									<p class="mb-1">주소 -${orderView.userAddr2}</p>
									<p class="mb-1">상세주소 - ${orderView.userAddr3}</p>
									<p class="mb-1">배송 상태 : ${orderView.delivery}</p>
								</div>

								<div class="col-md-6 text-right">
									<p class="font-weight-bold mb-4">결제 수단</p>
									<p class="mb-1">
										<span class="text-muted">VAT: </span> 카드
									</p>
									<p class="mb-1">
										<span class="text-muted">VAT ID: </span> 1000-2536-4222
									</p>
									<p class="mb-1">
										<span class="text-muted">Payment Type: </span> 일시불
									</p>
									<p class="mb-1">
										<span class="text-muted">결제자 명: ${orderView.orderRec}</span>
									</p>
								</div>
							</div>
<br><br><br><hr>
							<div class="d-flex flex-row-reverse bg-dark text-white p-4">
								<div class="py-3 px-5 text-right">
								
									<div class="mb-2">총 가격</div>
									<div class="h2 font-weight-light"><fmt:formatNumber pattern="###,###,###"
													value="${orderView.amount}" />원</div>
								</div>
							</div>

						</c:if>
					</c:forEach>

					<!-- 제품 정보  -->
					<div class="row p-5">
						<div class="col-md-12">
							<table class="table">
								<thead>
									<tr>
										<th class="border-0 text-uppercase small font-weight-bold">상품 목록 </th>
										<th class="border-0 text-uppercase small font-weight-bold">상품명</th>

										<th class="border-0 text-uppercase small font-weight-bold">수량</th>
										<th class="border-0 text-uppercase small font-weight-bold">가격</th>
										<th class="border-0 text-uppercase small font-weight-bold">Total</th>
									</tr>
								</thead>

								<c:forEach items="${orderView}" var="orderView">

									<tbody>
										<tr>
											<td>${orderView.proName}</td>
											<td>${orderView.proName}</td>

											<td>${orderView.cartStock}개</td>
											<td><fmt:formatNumber pattern="###,###,###"
													value="${orderView.price}" /> 원</td>
											<td><fmt:formatNumber pattern="###,###,###"
													value="${orderView.price * orderView.cartStock}" /> 원 </td>
										</tr>

									</tbody>

								</c:forEach>


							</table>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
</div>

<%--    <div class="orderInfo">
  <c:forEach items="${orderView}" var="orderView" varStatus="status">
   
   <c:if test="${status.first}">
    <p><span>수령인</span>${orderView.orderRec}</p>
    <p><span>주소</span>(${orderView.userAddr1}) ${orderView.userAddr2} ${orderView.userAddr3}</p>
    <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.amount}" /> 원</p>
    <p><span>상태</span>${orderView.delivery}</p>
   </c:if>
   
  </c:forEach>
 </div> --%>




<!--주문자 정보  -->

<%--     <div class="row pb-5 p-5">
                        <div class="col-md-6">
                            <p class="font-weight-bold mb-4">배송 정보</p>
                            <p class="mb-1">수령인 : ${orderView.orderRec}</p>
                            <p>주소</p>
                            <p>${orderView.userAddr1}</p>
                            <p class="mb-1">${orderView.userAddr2}</p>
                            <p class="mb-1">${orderView.userAddr3}</p>
                             <p class="mb-1">배송 상태 ${orderView.delivery}</p>
                        </div>

                        <div class="col-md-6 text-right">
                            <p class="font-weight-bold mb-4">Payment Details</p>
                            <p class="mb-1"><span class="text-muted">VAT: </span> 1425782</p>
                            <p class="mb-1"><span class="text-muted">VAT ID: </span> 10253642</p>
                            <p class="mb-1"><span class="text-muted">Payment Type: </span> Root</p>
                            <p class="mb-1"><span class="text-muted">Name: </span> John Doe</p>
                        </div>
                    </div>
    --%>




<%@ include file="../includes/footer.jsp"%>