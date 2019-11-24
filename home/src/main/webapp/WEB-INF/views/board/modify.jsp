<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>

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
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="pageNum" value="${cri.pageNum }" /> <input
						type="hidden" name="amount" value="${cri.amount }" /> <input
						type="hidden" name="type" value="${cri.type }"> <input
						type="hidden" name="keyword" value="${cri.keyword }">
					<div class="form-group">
						게시물 번호<input class="form-control" name="bno"
							value='<c:out value="${board.bno }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						제목<input class="form-control" name="title"
							value='<c:out value="${board.title }"/>'>
					</div>
					
				<div class="form-group">
				내용을 새로 추가해주세요.
<div class="row">
<div class="col-lg-12">
<div class="panel panel-default">
<div class="panel-heading"><input id="imgone" type="file" name="uploadFile" multiple></div>
<div class="panel-body">
<div class="form-group uploadDiv">
파일 첨부:  
</div>

</div>
<div class="uploadResult1">
<ul class="select_img"><img src="" multiple /></ul>
</div>
</div>
</div>
</div>
</div>
					
					<div class="form-group">
						내용
						<textarea rows="3" class="formcontrol" name="content"><c:out
								value="${board.content }" /></textarea>
					</div>
					<div class="form-group">
						작성자<input class="form-control" name="writer"
							value='<c:out value="${board.writer }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						등록일<input class="form-control" name="regDate"
							value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }"/>'
							readonly="readonly">
					</div>

					<button type="submit" data-oper="modify" class="btn btn-warning">수정</button>
					<button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
					<button type="submit" data-oper="list" class="btn btn-info">목록
					</button>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		console.log("history.state : " + history.state);
		var formObj = $("form");/* form 객체를 변수에 할당. */
		$('button').on("click", function(e) {
			/* 버튼이 클릭된다면, */
			e.preventDefault();/* 버튼의 기본 기능을 막고 */
			var operation = $(this).data("oper");
			/* 버튼에서 data oper 를 가져와서 변수에 할당. */
			console.log(operation);
			/* 웹브라우저 콘솔로 해당 변수 출력 */
			if (operation === 'remove') {
				formObj.attr("action", "/board/remove");
				/* 삭제라면 액션을 변경함. */
			} else if (operation === 'QnA') {
				formObj.attr("action", "/board/QnA").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				formObj.empty();//폼의 내용들 비우기.
				//self.location = "/board/list";
				//return;
				/* 페이지를 이동하고 진행 중지. */
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				// 수정시 필요했던 여러가지 정보들 중에서,
				// 페이지번호와 페이지당 게시물수 값만 남기고 지우기.
				// 그 다음에 목록으로 이동.
			}else if(operation === 'modify'){
				var str="";
				$(".uploadResult1 ul li").each(function(i,obj){
				var jobj=$(obj);
				console.dir(jobj);
				console.log("-----------------");
				console.log(jobj.data("filename"));

				str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
								str+="<input type='hidden' name='attachList["+i+"].uuid'  value='"+jobj.data("uuid")+"'>";
								str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
								str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				formObj.append(str);
				}
			formObj.submit();
		});
		
	});//read_class
</script>

<script>
$(document).ready(function() {
			

	$(".uploadResult1").on("click", "b", function(e) {
		console.log("delete file");
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		$.ajax({
			url : '/deleteFile',
			data : {
				fileName : targetFile,
				type : type
			},
			dataType : 'text',
			type : 'POST',
			success : function(result) {
				alert(result);
				targetLi.remove();
			}
		})
	});
	
	var maxSize = 5242880; // 5MB
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
						function checkExtension(fileName, fileSize) {
							if (fileSize >= maxSize) {
								alert("파일 크기 초과");
								return false;
							}
							if (regex.test(fileName)) {
								alert("해당 종류의 파일은 업로드 불가.");
								return false;
							}
							return true;
						}
						
						
	$("input[type='file']").change(
										function(e) {
											var formData = new FormData();
											var inputFile = $("input[name='uploadFile']");
											var files = inputFile[0].files;
											for (var i = 0; i < files.length; i++) {
												if (!checkExtension(
														files[i].name,
														files[i].size)) {
													return false;
												}
												formData.append("uploadFile",
														files[i]);
											}

											$.ajax({
												url : '/uploadAjaxAction',
												processData : false,
												contentType : false,
												data : formData,
												type : 'POST',
												dataType : 'json',
												success : function(result) {
													console.log(result);
													showUploadResult(result);
													// 첨부파일 업로드 결과를 json으로 받으면,
													// 그 내용을 화면에 표시.
												}
											});// end_ajax
										});//end_change
										
										function showUploadResult(uploadResultArr) {
											if (!uploadResultArr || uploadResultArr.length == 0) {
												// json 처리 결과가 없다면 함수 종료.
												return;
											}
										
											var uploadUL = $(".uploadResult1 ul");
											var str = "";
											// each 구문은 전달된 배열의 길이 만큼,
											// each 이후의 함수를 반복 처리.
											$(uploadResultArr).each(function(i,obj){
											var fileCallPath= encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
										 
											// encodeURIComponent : 
											// uri 로 전달되는 특수문자의 치환.
											// & ?

							var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");
											// 전달되는 값들 중에서 역슬러시를 찾아서 슬러시로 변경.
							
							str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"' ><div>";
							
							str+="<span>"+obj.fileName+"</span> ";	
							str+="<b data-file='"+fileCallPath+"' data-type='file'>[x]</b>";
							str+="</div></li>";
							
							 
						});
											uploadUL.append(str);
										}// end_showUploadResult			
										
					});//read_end
</script>
<script>
$("#imgone").change(function(){
	 if(this.files && this.files[0]) {
	  var reader =    new FileReader;
	  reader.onload = function(data) {
	   $(".select_img img").attr("src", data.target.result).width(500);        
	  }
	  reader.readAsDataURL(this.files[0]);
	 }
});
</script>

<%@ include file="../includes/footer.jsp"%>