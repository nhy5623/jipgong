<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
	<%@ include file="../includes/nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
.btn {
    
}
.info{
float:right; width:500px; font-size:22px;
}
.img{
 float:left; width:500px; 
}
.addCart_btn {
    color: #fff;
    background-color: #f0ad4e;
    border-color: #eea236;
    display: inline-block;
    padding: 8px 20px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
}
.panel-body{
float:center;
padding: 5px 450px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <div class="row">
      <div class="col-lg-12">
         <div class="panel panel-default">
          
            <div class="panel-body">

               <div class="inputArea">
                  <label for="img"></label>
                  <p></p>
                  <img src="${store.img}" class="img" />
               </div>
               <div class="info">
               <div class="form-group">
                  제품명<input class="form-control" name="proName" value="${store.proName }" readonly="readonly">
               </div>
               <div class="form-group">
                  가격<input class="form-control" name="price" value="${store.price }"
                     readonly="readonly">
               </div>
               <p class="cartStock">
                  <span>구입 수량</span>
                  <button type="button" class="plus">+</button>
                  <input type="number" class="numBox" min="1" max="${store.stock}" value="1" readonly="readonly" />
                  <button type="button" class="minus">-</button>

                  <script>
                    $(".plus").click(function(){
                        var num = $(".numBox").val();
                        var plusNum = Number(num) + 1;
   
                        if(plusNum >= ${store.stock}) {
                         $(".numBox").val(num);
                        } else {
                         $(".numBox").val(plusNum);          
                        }
                    });
  
                    $(".minus").click(function(){
                        var num = $(".numBox").val();
                        var minusNum = Number(num) - 1;
                           if(minusNum <= 0) {
                      $(".numBox").val(num);
                        } else {
                      $(".numBox").val(minusNum);          
                        }
                    });
 </script>

               </p>
                  <div class="form-group">
                  <input class="form-control" name="des" value="${store.des }"
                     readonly="readonly">
               </div>
                  <p class="addToCart">
      <button type="button" class="addCart_btn">장바구니</button>
      <button type="button" class="btn btn-info">바로구매</button>
               </div>
            
               <form id="operForm" action="/store/storeDetail" method="get">
                  <input type="hidden" id="proNo" name="proNo"
                     value="${store.proNo }" /> <input type="hidden" name="pageNum"
                     value="${cri.pageNum }" /> <input type="hidden" name="amount"
                     value="${cri.amount }" />
               </form>
            </div>


            <!-- 폼을 생성해서 게시물번호를 숨김 값으로 전달.나중에 현재 페이지 번호, 페이지당 게시물수, 검색어, 검색타입 추가 예정  -->
         </div>
      </div>
   </div>
      <script>
  $(".addCart_btn").click(function(){
   var proNo = $("#proNo").val();
   var cartStock = $(".numBox").val();
      
   var data = {
     proNo : proNo,
     cartStock : cartStock
     };

   $.ajax({
    url : "/store/addCart",
    type : "post",
    data : data,
    success : function(result){
        if(result == 1) {
            if(confirm("상품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?")==true){
               location.href = "/store/cartList";
              
       
            }else{
               return false;
            }
            
            $(".numBox").val("1");
           } else {
            alert("회원만 사용할 수 있습니다.")
            $(".numBox").val("1");
           }
    },
    error : function(){
     alert("카트 담기 실패");
    }
   });
  });
 </script>
   </p>

   <script>
      var select_cateCode = '${goods.cateCode}';
      var select_cateCodeRef = '${goods.cateCodeRef}';
      var select_cateName = '${goods.cateName}';

      if (select_cateCodeRef != null && select_cateCodeRef != '') {
         $(".category1").val(select_cateCodeRef);
         $(".category2").val(select_cateCode);
         $(".category2").children().remove();
         $(".category2").append("<option value='" + select_cateCode + "'>" + select_cateName + "</option>");
      } else {
         $(".category1").val(select_cateCode);
         //$(".category2").val(select_cateCode);
         // select_cateCod가 부여되지 않는 현상이 있어서 아래 코드로 대체
         $(".category2").append("<option value="' + select_cateCode + '" selected='selected'>전체</option>");
      }
      $(document).ready(function() {
         console.log("history.state : " + history.state);
      });
   </script>
   <script>
      $(document).ready(function() {
         var operForm = $("#operForm");
         $("button[data-oper='cartList']").on("click", function(e) {
            operForm.attr("action", "/store/cartList").submit();
         });
         $("button[data-oper='storeList']").on("click", function(e) {
            operForm.find("#proNo").remove();
            operForm.attr("action", "/store/cartList");
            operForm.submit();
         });
         /* 폼에서 어떤 버튼이 눌렸는지 확인하여,
         액션을 변경하거나, 일부 값을 삭제하여 전송.*/
      });
      /* $(document).ready(function() {
      var formObj = $("form[role='form']");
         $("#modify_Btn").click(function() {
            formObj.attr("action", "/admin/goods/modify");
            formObj.attr("method", "get")
            formObj.submit();
            });
         $("#delete_Btn").click(function() {
            formObj.attr("action", "/admin/store/remove");
            formObj.submit();
         });
         $("#storeList_Btn").click(function() {
            formObj.attr("action", "/admin/store/storeList");
            formObj.attr("method", "get")
            formObj.submit();
         });
      }); */
   </script>
</body>
</html>