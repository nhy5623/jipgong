<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/nav2.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>상품 상세</h1>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"></div>
				<div class="panel-body">
					
					<div class="form-group">
						<label>분류</label> <span class="form-control">${store.cateCode}</span>
					</div>
					<div class="form-group">
						<label for="img">이미지</label>
						<p>썸네일</p>
						<img src="${store.img}" class="img" />
					</div>
					
					<div class="form-group">
						제품명<input class="form-control" name="proName"
							value='<c:out value="${store.proName }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						가격<input class="form-control" name="price"
							value='<c:out value="${store.price }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						재고 수량<input class="form-control" name="stock"
							value='<c:out value="${store.stock }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						제품 소개<input class="form-control" name="des"
							value='<c:out value="${store.des }"/>' readonly="readonly">
					</div>
					
					<button data-oper="modify" class="btn btn-warning">수정</button>
					<button data-oper="storeList" class="btn btn-info">목록</button>

					<form id="operForm" action="admin/store/modify" method="get">
						<input type="hidden" id="proNo" name="proNo" value="${store.proNo }" /> 
						<input type="hidden" name="pageNum" value="${cri.pageNum }" />
						<input type="hidden" name="amount" value="${cri.amount }" />
					</form>
				</div>
				<!-- 폼을 생성해서 게시물번호를 숨김 값으로 전달.나중에 현재 페이지 번호, 페이지당 게시물수, 검색어, 검색타입 추가 예정  -->
			</div>
		</div>
	</div>

	<script>
		var select_cateCode = '${goods.cateCode}';
		var select_cateCodeRef = '${goods.cateCodeRef}';
		var select_cateName = '${goods.cateName}';

		if (select_cateCodeRef != null && select_cateCodeRef != '') {
			$(".category1").val(select_cateCodeRef);
			$(".category2").val(select_cateCode);
			$(".category2").children().remove();
			$(".category2").append(
					"<option value='"
	       + select_cateCode + "'>"
							+ select_cateName + "</option>");
		} else {
			$(".category1").val(select_cateCode);
			//$(".category2").val(select_cateCode);
			// select_cateCod가 부여되지 않는 현상이 있어서 아래 코드로 대체
			$(".category2")
					.append(
							"<option value="' + select_cateCode + '" selected='selected'>전체</option>");
		}
		$(document).ready(function() {
			console.log("history.state : " + history.state);
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			var result = '<c:out value="${result}"/>';
			console.log("history.state : " + history.state);
			console.log("result : " + result);
			checkModal(result);
			history.replaceState({}, null, null);
			// 스택구조에 누적된 히스토리 객체를 지워라
			// 3개의 인자는 state객체, 제목, url
			function checkModal(result) {
				if (result === '' || history.state != null) {/* 결과가 없거나
																								히스토리가 있다면 */
					// 값과 타입도 검사. 형태도 맞고 값도 맞는다면
					// 넘겨 받은 값이 있다면,
					// 스택구조로 쌓인 정보가 있다면
					return;
				}
				if (parseInt(result) > 0) {
					$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록");
					// 모달 바디에 주어진 문장으로 대체
				}
				$("#myModal").modal("show");// 모달 표시.
			}

		});
	</script>
	<script>
		$(document).ready(function() {
			var operForm = $("#operForm");
			$("button[data-oper='modify']").on("click", function(e) {
				operForm.attr("action", "/admin/store/modify").submit();
			});
			$("button[data-oper='storeList']").on("click", function(e) {
				operForm.find("#proNo").remove();
				operForm.attr("action", "/admin/store/storeList");
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
	<!-- <script>
		/* $(document).ready(function() {
			console.log("history.state : " + history.state);
		}); */
		$(document).ready(function() {
			var operForm = $("#operForm");
			$("button[data-oper='modify']").on("click", function(e) {
				operForm.attr("action", "admin/store/modify").submit();
			});
			$("button[data-oper='storeList']").on("click", function(e) {
				operForm.find("#proNo").remove();
				operForm.attr("action", "admin/store/storeList");
				operForm.submit();
			});
			/* 폼에서 어떤 버튼이 눌렸는지 확인하여,
			액션을 변경하거나, 일부 값을 삭제하여 전송.*/
		});-->

</body>
</html>