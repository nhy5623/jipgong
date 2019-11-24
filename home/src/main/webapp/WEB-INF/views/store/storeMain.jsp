<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
<!DOCTYPE html>
<html>
<style>
body {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	/* font-size: 14px; */
	line-height: 1.42857143;
	color: #333;
	text-align: center;
	background-color: #ffffff
}

</style>
<body>
	<div>
		<div class="col-lg-12">
			<button class="btn btn-primary" onclick = "location.href = '/store/table'">테이블</button>
			<button class="btn btn-primary" onclick = "location.href = '/store/chair'">의자</button>
			<button class="btn btn-primary" onclick = "location.href = '/store/light'">조명</button>
			<button class="btn btn-primary" onclick = "location.href = '/store/item'">소품</button>
			<button class="btn btn-primary" onclick = "location.href = '/store/closet'">수납장</button>
			<button class="btn btn-primary" onclick = "location.href = '/store/bedding'">침구류</button>
			<form id="searchForm" action="/store/storeMain" method="get">
				&nbsp;&nbsp;&nbsp;<select name="type">

					<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>
						제품명</option>

				</select> <input type="text" name="keyword" /> <input type="hidden"
					name="pageNum" value="${pageMaker.cri.pageNum }"> <input
					type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<button class="btn btn-warning">Search</button>
			</form>
			
		</div>
	</div>
	<div class="products">

		<div class="container">
			<div class="row">
				<div class="col">
					<div class="product_grid">
						<!-- Product -->
						<c:forEach items="${StoreList }" var="store">
							<div class="product">
								<div class="product_content">
									<div class="product-image">
										<a href="${store.proNo }" class="move"> <img
											src="${store.img }" width="300px">
										</a>
									</div>
								</div>
								<div class="product-title">
									<a href="${store.proNo }" class="move"> <c:out
											value="${store.proName }" /></a>
								</div>
								<div class="product_price">
									<fmt:formatNumber value="${store.price }" pattern="###,###,###" />
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<form id="actionForm" action="/store/storeMain" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	</form>


	<div>
		<ul class="pagination justify-content-center">
			<c:if test="${pageMaker.prev }">
				<li class="page-item previous"><a
					href="${pageMaker.startPage-1 }" class="page-link">이전</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }">
				<li class='page-item ${pageMaker.cri.pageNum==num?"active":"" }'>
					<a href="${num }" class="page-link"> ${num }</a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next }">
				<li class="page-item next"><a href="${pageMaker.endPage+1 }"
					class="page-link">다음</a></li>
			</c:if>

		</ul>
	</div>


	<form id="actionForm" action="/store/storeMain" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	</form>
	<script>
		// 컨트롤러에서 데이터 받기
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
	</script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var result = '<c:out value="${result}"/>';
							console.log("history.state : " + history.state);
							console.log("result : " + result);
							checkModal(result);
							history.replaceState({}, null, null);
							// 스택구조에 누적된 히스토리 객체를 지워라
							// 3개의 인자는 state객체, 제목, url
							function checkModal(result) {
								if (result === '' || history.state != null) {
									/* 결과가 없거나 히스토리가 있다면 */
									// 값과 타입도 검사. 형태도 맞고 값도 맞는다면
									// 넘겨 받은 값이 있다면,
									// 스택구조로 쌓인 정보가 있다면
									return;
								}

							}

							var actionForm = $("#actionForm");
							// 클래스 page-item 에 a 링크가 클릭 된다면,
							$(".page-item a").on(
									"click",
									function(e) {
										e.preventDefault();
										// 기본 이벤트 동작을 막고,

										console.log("click");
										// 웹 브라우저 검사 창에 클릭을 표시		
										actionForm
												.find("input[name='pageNum']")
												.val($(this).attr("href"));
										// 액션폼 인풋태그에 페이지넘 값을 찾아서,
										// href로 받은 값으로 대체함.
										actionForm.submit();
									});
							$(".move")
									.on(
											"click",
											function(e) {
												e.preventDefault();
												actionForm
														.append("<input type='hidden' name='proNo' "
																+ "value='"
																+ $(this).attr(
																		"href")
																+ "'>");
												actionForm.attr("action",
														"/store/storeDetail");
												actionForm.submit();
											});
						});
	</script>
	<script>
		$(document).ready(function() {
			$('#dataTable').DataTable({
				"order" : [ [ 0, "desc" ] ], //정렬 0컬럼의 내림차순으로
				"paging" : false, // 페이징 표시 안함.
				"bFilter" : false, // 검색창 표시 안함.
				"info" : false
			// 안내창 표시 안함.
			})
		})
	</script>
</body>
</html>