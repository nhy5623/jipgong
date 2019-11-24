<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/nav2.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">글 쓰기</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading"></div>
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token}" />
					<div class="form-group">
						제목<input class="form-control" name="title">
					</div>
					<div class="form-group">
					<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">  <input type="file" id="imgone" name="uploadFile" multiple></div>

			<div class="panel-body">
			파일 첨부:
				<div class="form-group uploadDiv">
					 		
				</div>
				<div class="uploadResult">
				<ul class="select_img"><img src="" multiple /></ul>
				</div>
			</div>

		</div>
	</div>
</div>
</div>
					
					<div class="form-group">
						내용
						<textarea rows="3" class="form-control" name="content">
</textarea>
					</div>
					<div class="form-group">
						작성자<input class="form-control" name="writer"
						value='<c:out value="${member.user_name}"/>' readonly="readonly">
						<textarea class="form-control" name="writer"></textarea>
						<%-- 	작성자<input class="form-control" name="writer" 
						value='<sec:authentication property
						="principal.username"/>' readonly="readonly"> --%>
					</div>
					<button type="submit" class="btn btn-default">등록</button>
					<button type="reset" class="btn btn-default">취소</button>
				
				</form>
			</div>

		</div>
	</div>
</div>

<br />
 
<script type="text/javascript"></script>
<script >



	$(document).ready(function(e) {
						var formObj = $("form[role='form']");
						$("button[type='submit']").on("click",function(e){
							 
							e.preventDefault();
							console.log("submit clicked");
							
							// 글 등록 버튼을 누르면 첨부파일의 정보도 함께 전송 되도록 수정.
							var str="";
							$(".uploadResult ul li").each(function(i,obj){
								var jobj=$(obj);
								console.dir(jobj);
								console.log("-----------------");
								console.log(jobj.data("filename"));
								
								str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
								str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
								str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
								str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
								str+="<input type='hidden' name='attachList["+i+"].'img' value='"+jobj.data("img")+"'>";
							
							});
							formObj.append(str).submit();
							
							history.go(-1);
							// 첨부파일의 정보들을 li 의 data 값으로 가지고 있다가
							// hidden 으로 폼에 포함.
						});
						
						 
						
						var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
						// 정규표현식. 일부 파일의 업로드 제한.
						//https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/%EC%A0%95%EA%B7%9C%EC%8B%9D
						// https://regexper.com/
						var maxSize = 5242880; // 5MB
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
						 $("input[type='file']").change(function(e) {
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
                           });

										 
						
										   
						function showUploadResult(uploadResultArr) {
							if (!uploadResultArr || uploadResultArr.length == 0) {
								// json 처리 결과가 없다면 함수 종료.
								return;
							}
						
							var uploadUL = $(".uploadResult ul");
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
						$(".uploadResult").on("click", "b", function(e) {
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
					});// end_ready
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
<%@ include file="../include/footer.jsp"%>














