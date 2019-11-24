<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/nav2.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="/resources/ckeditor/ckeditor.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">글 수정</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"></div>
				<div class="panel-body">
					<form role="form" action="/admin/store/modify" method="post"
						autocomplete="off" enctype="multipart/form-data">
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token}" /> <input type="hidden" name="pageNum"
							value="${cri.pageNum }" /> <input type="hidden" name="amount"
							value="${cri.amount }" />
						<div class="inputArea">
							<label>1차 분류</label> <select class="category1">
								<option value="">전체</option>
							</select> <label>2차 분류</label> <select class="category2" name="cateCode">
								<option value="">전체</option>
							</select>
						</div>
						<div class="inputArea">
							<label for="proNo">제품 번호</label> <input type="text" id="proNo"
								name="proNo" value="${store.proNo}" />
						</div>
						<div class="inputArea">
							<label for="proName">제품명</label> <input type="text" id="proName"
								name="proName" value="${store.proName}" />
						</div>
						<div class="inputArea">
							<label for="price">제품가격</label> <input type="text" id="price"
								name="price" value="${store.price}" />
						</div>
						<div class="inputArea">
							<label for="stock">재고수량</label> <input type="text" id="stock"
								name="stock" value="${store.stock}" />
						</div>
						<div class="inputArea">
							<label for="des">상품소개</label>
							<textarea rows="5" cols="50" id="des" name="des">${store.des}</textarea>
							<script>
								var ckeditor_config = {
									resize_enaleb : false,
									enterMode : CKEDITOR.ENTER_BR,
									shiftEnterMode : CKEDITOR.ENTER_P,
									filebrowserUploadUrl : "/admin/store/ckUpload"
								};

								CKEDITOR.replace("des", ckeditor_config);
							</script>
						</div>
						<div class="inputArea">
							<label for="img">대표 이미지</label> <input type="file" id="img"
								name="file" />
							<div class="select_img">
								<img src="${store.img}" /> <input type="hidden" name="img"
									value="${store.img}" /> <input type="hidden" name="ThumbImg"
									value="${ThumbImg}" />
							</div>
						</div>
						<button type="submit" data-oper="modify" class="btn btn-warning">수정</button>
						<button type="button" data-oper="remove" class="btn btn-danger">삭제</button>
						<button type="button" data-oper="storeList" class="btn btn-info">목록
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		$("#img")
				.change(
						function() {
							if (this.files && this.files[0]) {
								var reader = new FileReader;
								reader.onload = function(data) {
									$(".select_img img").attr("src",
											data.target.result).width(500);
								}
								reader.readAsDataURL(this.files[0]);
							}
						});
	</script>
	<script>
		var jsonData = JSON.parse('${category}');
		console.log(jsonData);

		var cate1Arr = new Array();
		var cate1Obj = new Object();

		// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
		for (var i = 0; i < jsonData.length; i++) {

			if (jsonData[i].level == "1") {
				cate1Obj = new Object(); //초기화
				cate1Obj.cateCode = jsonData[i].cateCode;
				cate1Obj.cateName = jsonData[i].cateName;
				cate1Arr.push(cate1Obj);
			}
		}

		// 1차 분류 셀렉트 박스에 데이터 삽입
		var cate1Select = $("select.category1")

		for (var i = 0; i < cate1Arr.length; i++) {
			cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
					+ cate1Arr[i].cateName + "</option>");
		}
		$(document)
				.on(
						"change",
						"select.category1",
						function() {

							var cate2Arr = new Array();
							var cate2Obj = new Object();
							// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
							for (var i = 0; i < jsonData.length; i++) {
								if (jsonData[i].level == "2") {
									cate2Obj = new Object(); //초기화
									cate2Obj.cateCode = jsonData[i].cateCode;
									cate2Obj.cateName = jsonData[i].cateName;
									cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;
									cate2Arr.push(cate2Obj);
								}
							}
							var cate2Select = $("select.category2");
							/*  for(var i = 0; i < cate2Arr.length; i++) {
							cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
							+ cate2Arr[i].cateName + "</option>");
							}  */
							cate2Select.children().remove();
							$("option:selected", this)
									.each(
											function() {
												var selectVal = $(this).val();
												cate2Select
														.append("<option value='" + selectVal + "'>전체</option>");

												for (var i = 0; i < cate2Arr.length; i++) {
													if (selectVal == cate2Arr[i].cateCodeRef) {
														cate2Select
																.append("<option value='" + cate2Arr[i].cateCode + "'>"
																		+ cate2Arr[i].cateName
																		+ "</option>");
													}
												}
											});
						});
		var select_cateCode = '${goods.cateCode}';
		var select_cateCodeRef = '${goods.cateCodeRef}';
		var select_cateName = '${goods.cateName}';

		if (select_cateCodeRef != null && select_cateCodeRef != '') {
			$(".category1").val(select_cateCodeRef);
			$(".category2").val(select_cateCode);
			$(".category2").children().remove();
			$(".category2").append(
					"<option value='" + select_cateCode + "'>"
							+ select_cateName + "</option>");
		} else {
			$(".category1").val(select_cateCode);
			$(".category2").val(select_cateCode);
		}
	</script>
	<script>
		$(document).ready(
				function() {
					console.log("history.state : " + history.state);
					var formObj = $("form");/* form 객체를 변수에 할당. */
					$('button').on(
							"click",
							function(e) {
								/* 버튼이 클릭된다면, */
								e.preventDefault();/* 버튼의 기본 기능을 막고 */
								var operation = $(this).data("oper");
								/* 버튼에서 data oper 를 가져와서 변수에 할당. */
								console.log(operation);
								/* 웹브라우저 콘솔로 해당 변수 출력 */
								if (operation === 'remove') {
									formObj.attr("action",
											"/admin/store/remove");
									/* 삭제라면 액션을 변경함. */
								} else if (operation === 'storeList') {
									formObj.attr("action",
											"/admin/store/storeList").attr(
											"method", "get");
									var pageNumTag = $("input[name='pageNum']")
											.clone();
									var amountTag = $("input[name='amount']")
											.clone();
									formObj.empty();//폼의 내용들 비우기.     
									//self.location = "/store/storeList";     
									//return;     
									/* 페이지를 이동하고 진행 중지. */
									formObj.append(pageNumTag);
									formObj.append(amountTag);
									// 수정시 필요했던 여러가지 정보들 중에서,     
									// 페이지번호와 페이지당 게시물수 값만 남기고 지우기.     
									// 그 다음에 목록으로 이동.    
								}

								formObj.submit();
							});
				});
	</script>


</body>
</html>