<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>

<style>

.jjy{
	margin-left:50px;
	padding:35px 0 60px;
	margin-right:50px;

}
.delete button{
    font-size: 22px;
    padding: 5px 10px;
    border: 1px solid #eee;
    background: #eee;
    margin-right: 10px;

} 
.allCheck label{
    margin-left: 10px;
    width: 105px;
}
section#content ul li {
    border: 5px solid #eee;
    padding: 10px 20px;
    margin-bottom: 20px;
    margin-top: 30px;
}



</style>
<section class="jjy" id="content">
 
 <ul>
 
  <li>
  <div class="allCheck">
   <input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
  </div>
  
  <script>
$("#allCheck").click(function(){
 var chk = $("#allCheck").prop("checked");
 if(chk) {
  $(".chBox").prop("checked", true);
 } else {
  $(".chBox").prop("checked", false);
 }
});
</script>
  
  <div class="delBtn"> 
   <button type="button" class="selectDelete_btn">선택 삭제</button> 
  </div>
  
 </li>
 
 <c:set var="sum" value="0"/>
  <c:forEach items="${cartList}" var="cartList">
  <li>
  
  <div class="checkBox">
   <input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNum}" />
  </div>
  
  <script>
 $(".chBox").click(function(){
  $("#allCheck").prop("checked", false);
 });
</script>
  
   <div class="thumb">
    <img src="${cartList.img}" />
   </div>
   <div class="gdsInfo">
    <p>
     <span>상품명 : </span>${cartList.proName}<br />
     <span>개당 가격 : </span><fmt:formatNumber pattern="###,###,###" value="${cartList.price}" />원<br />
     <span>구입 수량 : </span>${cartList.cartStock}<br />
     <span>최종 가격 : </span><fmt:formatNumber pattern="###,###,###" value="${cartList.price * cartList.cartStock}" />개
    </p>    
    
     <div class="delete">
      <button type="button" class="delete_${cartList.cartNum}_btn" 
      data-cartNum="${cartList.cartNum}">삭제</button>
 
     <script>
 $(".delete_${cartList.cartNum}_btn").click(function(){
  var confirm_val = confirm("정말 삭제하시겠습니까?");
  
  if(confirm_val) {
   var checkArr = new Array();
   
   checkArr.push($(this).attr("data-cartNum"));
              
   $.ajax({
    url : "/store/deleteCart",
    type : "post",
    data : { chbox : checkArr },
    success : function(result){
     if(result == 1) {            
      location.href = "/store/cartList";
     } else {
      alert("삭제 실패");
     }
    }
   });
  } 
 });
</script>
     
<script>
 $(".selectDelete_btn").click(function(){
  var confirm_val = confirm("정말 삭제하시겠습니까?");
  
  if(confirm_val) {
   var checkArr = new Array();
   
   $("input[class='chBox']:checked").each(function(){
    checkArr.push($(this).attr("data-cartNum"));
   });
    
   $.ajax({
    url : "/store/deleteCart",
    type : "post",
    data : { chbox : checkArr },
    success : function(result){
              
         if(result == 1) {          
             location.href = "/store/cartList";
            } else {
             alert("삭제 실패");
            }     
     
    }
   });
  } 
 });
</script> 
       </div>
      </div>
   
   
  </li>
  <c:set var="sum" value="${sum + (cartList.price * cartList.cartStock)}" />
  
  </c:forEach>
 </ul>
 <div class="listResult">
 <div class="sum">
  총 합계 : <fmt:formatNumber pattern="###,###,###" value="${sum}" />원
 </div>
 <div class="orderOpne">
  <button type="button" class="orderOpne_bnt">주문 정보 입력</button>
  
  <script>
 $(".orderOpne_bnt").click(function(){
  $(".orderInfo").slideDown();
  $(".orderOpne_bnt").slideUp();
 });      
</script>
 </div>
</div>
 
 <div class="orderInfo">
 <form role="form" method="post" autocomplete="off">
    
  <input type="hidden" name="amount" value="${sum}" />
    
  <div class="inputArea">
   <label for="">수령인</label>
   <input type="text" name="orderRec" id="orderRec" value='<c:out value="${member.user_name}"/>' required="required" />
  </div>
  
  <div class="inputArea">
   <label for="orderPhon">수령인 연락처</label>
   <input type="text" name="orderPhon" id="orderPhon" value='<c:out value="${member.user_phone}"/>' required="required" />
  </div>
  
  <div class="inputArea">
   <label for="userAddr1">우편번호</label>
   <input type="text" name="userAddr1" id="userAddr1"  value='<c:out value="${member.addr1}"/>' required="required" />
  </div>
  
  <div class="inputArea">
   <label for="userAddr2">1차 주소</label>
   <input type="text" name="userAddr2" id="userAddr2" value='<c:out value="${member.addr2}"/>'  required="required" />
  </div>
  
  <div class="inputArea">
   <label for="userAddr3">2차 주소</label>
   <input type="text" name="userAddr3" id="userAddr3" value='<c:out value="${member.addr3}"/>'  required="required" />
  </div>
  
  <div class="inputArea">
   <button type="submit" class="order_btn">주문</button>
   <button type="button" class="cancel_btn">취소</button> 
   <script>
$(".cancel_btn").click(function(){
 $(".orderInfo").slideUp();
 $(".orderOpne_bnt").slideDown();
});      
</script>
  </div>
  
 </form> 
</div>
 
 
 
 
</section>

<%@ include file="../includes/footer.jsp"%>