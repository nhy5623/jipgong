<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../includes/header.jsp"%>

<style>
.inputArea { margin:10px 0; }
select { width:100px; }
label { display:inline-block; width:70px; padding:5px; }
label[for='gdsDes'] { display:block; }
input { width:150px; }
textarea#gdsDes { width:400px; height:180px; }
</style>
<!--관리자 업로드폼  -->

<form role="form" method="post" autocomplete="off" enctype="multipart/form-data">

<c:forEach var="communityList" items="${communityList }">
<td>${communityList.community_bno }</td>
<input class="form-control"name="community_bno" value='<c:out value="${communityList.community_bno }"/>'readonly="readonly">
</c:forEach>


<div class="inputArea">
 <label for="community_thema">테마</label>
 <input type="text" id="community_thema" name="community_thema" />
</div>

<div class="inputArea">
 <label for="community_id">닉내임</label>
 <input id="community_id" name="community_id"value='<c:out value="${member.user_name}"/>'readonly="readonly">
</div>



<div class="inputArea">
 <label for="community_review">글내용</label>
<textarea rows="5" cols="50"id="community_review" name="community_review"></textarea>
</div>



<div class="row">
<div class="col-lg-12">
<div class="panel panel-default">

<div class="panel-heading"></div>

 <!--이미지 첨부  -->
<div class="inputArea">
 <label for="gdsImg">이미지</label>
 <input type="file" id="gdsImg" name="file" />
 <div class="select_img"><img src="" /></div>
 
 <script>
  $("#gdsImg").change(function(){
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    reader.onload = function(data) {
     $(".select_img img").attr("src", data.target.result).width(500);        
    }
    reader.readAsDataURL(this.files[0]);
   }
  });
 </script>
 
 	
  			<div class="display-none">
					<label for="link1">링크 추가</label>
					<input type="text" id="link1" name="link1" />
			</div>
			
			<div class="display-none">
 				<label for="link2">링크 추가</label>
 					<input type="text" id="link2" name="link2" />
			</div>
			
			<div class="display-none">
 				<label for="link3">링크 추가</label>
 					<input type="text" id="link3" name="link3" />
			</div>
			
			<div class="display-none">
 				<label for="link4">링크 추가</label>
 					<input type="text" id="link4" name="link4" />
			</div>
			
			<div class="display-none">
 				<label for="link5">링크 추가</label>
 					<input type="text" id="link5" name="link5" />
			</div>
 		<div class="display-none">
 			<label for="community_admin">일반사용자사서1들어감</label>
 			<input id="community_admin" name="community_admin"value='<c:out value="${1}"/>'>
		</div>
			
 </div>
<!--이미지첨부 끝  -->

<div class="inputArea">
 <button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
</div>
<div class="uploadResult">
<ul></ul>
</div>
</div>

</div>
</div>

</form>



<%@ include file="../includes/footer.jsp"%>