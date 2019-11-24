<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/nav2.jsp"%>


<style>
pageing{
	
}


</style>
<a href="/board/register">게시물 작성</a>


<table class="table table-bordered" id="dataTable" width="100%"
	cellspacing="0">
	<thead>
		<tr>
			<th>#번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>작성일</th>
			
			
			<!-- <th>Salary</th> -->
		</tr>
	</thead>

	<tbody>
		<c:forEach var="board" items="${list}">
			<tr>
				<td>${board.bno }</td>
				
				<td>
				<a href="${board.bno }" class="move">
				<c:out value="${board.title }" /></a><c:if test="${board.replyCnt ne 0 }">
			<span style="color:red;">[
			<c:out value="답변 완료"/>]</span>
				</c:if>	
				</td>

				<td>${board.content }</td>
				<td>${board.writer }</td>
				<td><fmt:formatDate value="${board.regdate }"
						pattern="yyyy-MM-dd" /></td>
				
						
			</tr>
		</c:forEach>
	</tbody>
</table>

<div>
	<div class="col-lg-12">
		<form id="searchForm" action="/admin/board/QnA" method="get">
			&nbsp;&nbsp;&nbsp;<select name="type">
				<option value="" ${pageMaker.cri.type==null?"selected":"" }>
					--</option>
				<option value="T" ${pageMaker.cri.type eq "T"?"selected":"" }>
					제목</option>
				<option value="C" ${pageMaker.cri.type eq "C"?"selected":"" }>
					내용</option>
				<option value="W" ${pageMaker.cri.type eq "W"?"selected":"" }>
					작성자</option>
				<option value="TC" ${pageMaker.cri.type eq "TC"?"selected":"" }>
					제목+내용</option>
				<option value="TW" ${pageMaker.cri.type eq "TW"?"selected":"" }>
					제목+작성자</option>
				<option value="WC" ${pageMaker.cri.type eq "WC"?"selected":"" }>
					내용+작성자</option>
				<option value="TWC" ${pageMaker.cri.type eq "TWC"?"selected":"" }>
					제목+내용+작성자</option>
			</select> <input type="text" name="keyword" /> <input type="hidden"
				name="pageNum" value="${pageMaker.cri.pageNum }"> <input
				type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<button class="btn btnwarning">Search</button>
		</form>
	</div>
</div>
 

<div id="paging"> 
<div>
	<ul class="pagination justify-content-center" style="float:left;">
		<c:if test="${pageMaker.prev }">
			<li class="page-item previous"><a
				href="${pageMaker.startPage-1 }" class="page-link">prev</a></li>
		</c:if>

		<c:forEach var="num" begin="${pageMaker.startPage }"
			end="${pageMaker.endPage }">
			<li class='page-item ${pageMaker.cri.pageNum==num?"active":"" }'>
				<a href="${num }" class="page-link"> ${num }</a>
			</li>
		</c:forEach>

		<c:if test="${pageMaker.next }">
			<li class="page-item next"><a href="${pageMaker.endPage+1 }"
				class="page-link">next</a></li>
		</c:if>

	</ul>
</div>
</div>

<form id="actionForm" action="/admin/board/QnA" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>




<!-- Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body" align="center">a</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">close</button>
			</div>
		</div>
	</div>
</div>



<script type="text/javascript">
	$(document)
			.ready(
					function() {
						/* modal.modal("myModal"); */
						
						var result = '<c:out value="${result}"/>';
						console.log("history.state : " + history.state);
						console.log("result : " + result);
						/* checkModal(result); */

						/* history.replaceState({}, null, null); */
						// 스택구조에 누적된 히스토리 객체를 지워라
						// 3개의 인자는 state객체, 제목, url
						checkModal(result);
						history.replaceState({}, null, null);
						function checkModal(result) {
							if (result === '' || history.state != null) {
								/* 결과가 없거나																						히스토리가 있다면 */
								// 값과 타입도 검사. 형태도 맞고 값도 맞는다면
								// 넘겨 받은 값이 있다면,
								// 스택구조로 쌓인 정보가 있다면
								return;
							}
							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result) + "번이 등록");
								// 모달 바디에 주어진 문장으로 대체
							}
							/* $("#myModal").modal("show");// 모달 표시. */
						}
						$("#regBtn").on("click", function() {
							self.location = "/admin/board/register";
							/* 아이디 regBtn 을 클릭한다면
							 현재창의 위치를 쓰기로 변경 */
						});
						var actionForm = $("#actionForm");
						// 클래스 page-item 에 a 링크가 클릭 된다면,
						$(".page-item a").on(
								"click",
								function(e) {
									e.preventDefault();
									// 기본 이벤트 동작을 막고,
									//	console.log("click");
									// 웹 브라우저 검사 창에 클릭을 표시
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									// 액션폼 인풋태그에 페이지넘 값을 찾아서,
									// href로 받은 값으로 대체함.
									actionForm.submit();
								});

						$(".move").on("click",function(e) {
											e.preventDefault();
											actionForm.append("<input type='hidden' name='bno'value='"+ $(this).attr("href")+ "'>");
											actionForm.attr("action","/admin/board/get");
											actionForm.submit();
										});

						var searchForm = $("#searchForm");
						$("#searchForm button").on(
								"click",
								function(e) {
									if (!searchForm.find("option:selected")
											.val()) {
										alert("검색 종류를 선택하세요.");
										return false;
									}
									if (!searchForm.find(
											"input[name='keyword']").val()) {
										alert("키워드를 입력하세요.");
										return false;
									}

									searchForm.find("input[name='pageNum']")
											.val(1);
									e.preventDefault();
									searchForm.submit();

								});

					});
</script>

<%@ include file="../include/footer.jsp"%>
