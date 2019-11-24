<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>

<style>
.ul
 
img
</style>


<div class="row">
   <div class="col-lg-12">
      <h1 class="page-header">글 읽기</h1>
   </div>
</div>
<div class="row">
   <div class="col-lg-12">
      <div class="panel panel-default">
         <div class="panel-heading"></div>
         <div class="panel-body">
            <div class="form-group">
               게시물 번호<input class="form-control" name="bno"
                  value='<c:out value="${board.bno }"/>' readonly="readonly">
            </div>
            <div class="form-group">
               제목<input class="form-control" name="title"
                  value='<c:out value="${board.title }"/>' readonly="readonly">
            </div>
            <div>
               <div class="row">
                  <div class="col-lg-12">
                     <div class="panel panel-default">
                        <div class="panel-heading">첨부파일</div>
                        <div class="panel-body">
                           <div class="uploadResult">
                              <ul></ul>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>


            <div class="form-group">
               내용
               <textarea rows="3" class="form-control" name="content"
                  readonly="readonly"><c:out value="${board.content }" /></textarea>
            </div>
            <div class="form-group">
               작성자<input class="form-control" name="writer"
                  value='<c:out value="${board.writer }"/>' readonly="readonly">
            </div>
            <button data-oper="modify" class="btn btn-warning">수정</button>
            <button data-oper="QnA" class="btn btn-info">
               <!--       <a href="/board/QnA"> 목록</a> -->
               목록
            </button>
            <form id="operForm" action="/board/modify" method="get">
               <input type="hidden" id="bno" name="bno" value="${board.bno }" />
               <input type="hidden" name="pageNum" value="${cri.pageNum }" /> <input
                  type="hidden" name="amount" value="${cri.amount }" /> <input
                  type="hidden" name="type" value="${cri.type }"> <input
                  type="hidden" name="keyword" value="${cri.keyword }">

            </form>

         </div>
      </div>
   </div>
</div>

<br />

<!-- 덧글 시작 -->
<br />
<div class="row">
   <div class="col-lg-12">
      <div class="panel panel-default">
         <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i>Reply
            <button id="addReplyBtn" class="btn btn-primary btn-xs float-right">댓글쓰기</button>
         </div>
         <br />
         <div class="panel-body">
            <ul class="chat">
               <li>댓글이 없습니다.</li>
            </ul>
         </div>
         <div class="panel-footer"></div>
      </div>
   </div>
   <!-- 덧글 끝 -->
</div>

<!-- Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"
               aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">덧글 창</h4>
         </div>
         <div class="modal-body">
            <div class="form-group">
               <label>댓글</label> <input class="form-control" name="reply"
                  value="새 덧글">
            </div>
            <div class="form-group">
               <label>작성자</label> <input class="form-control" name="replyer"
                  value="replyer">
            </div>
            <div class="form-group">
               <label>덧글 작성일</label> <input class="form-control" name="replyDate"
                  value="">
            </div>
         </div>
         <div class="modal-footer">
            <button id="modalModBtn" type="button" class="btn btnwarning">수정</button>
            <button id="modalRemoveBtn" type="button" class="btn btndanger">삭제</button>
            <button id="modalRegisterBtn" type="button" class="btn btnprimary">등록</button>
            <button id="modalCloseBtn" type="button" class="btn btndefault">닫기</button>
         </div>
      </div>
   </div>
</div>


<script type="text/javascript" src="/resources/js/reply.js"></script>



<script>
$(document).ready(function(){
   var bnoValue = '<c:out value="${board.bno}"/>';
   var replyUL = $(".chat");
   // reply Unorderd List
   

   showList(1);
   
   function showList(page){
      replyService.getList(
            {bno:bnoValue,page:page||1}, 
            function(replyCnt,list){
               console.log("replyCnt : "+replyCnt);
               
               if(page== -1){
                  // 페이지 번호가 음수 값 이라면,
                  pageNum 
                  = Math.ceil(replyCnt/10.0);
                  // 덧글의 마지막 페이지 구하기.
                  showList(pageNum);
                  // 덧글 목록 새로고침(갱신)
                  return;
               }
               
               var str="";
               if(list==null || 
                     list.length==0){
                  //replyUL.html("");
                  return;
               }
            for(var i=0, 
                  len=list.length||0;
            i<len;i++){
                  //console.log(list[i]);
                  str+="<li class='left ";
                  str+="clearfix' data-rno='";
                  str+=list[i].rno+"'>";
                  str+="<div><div class='header' ";
                  str+="><strong class='";
                  str+="primary-font'>";
                  str+=list[i].replyer+"</strong>";
                  str+="<small class='float-sm-right '>";
                  //str+="text-muted'>";
                  str+=replyService.displayTime(list[i].replyDate)+"</small></div>";
                  str+="<p>"+list[i].reply;
                  str+="</p></div></li>";
               }
            replyUL.html(str);
            
            });
   }// end_showList

                  var modal = $("#myModal"); // 덧글 용 모달.
                  var modalInputReply = modal.find("input[name='reply']");
                  // 모달에 입력되는 내용을 조작하기 위해서 변수로 선언.
                  var modalInputReplyer = modal.find("input[name='replyer']");
                  var modalInputReplyDate = modal.find("input[name='replyDate']");
                  var modalModBtn = $("#modalModBtn");
                  var modalRemoveBtn = $("#modalRemoveBtn");
                  var modalRegisterBtn = $("#modalRegisterBtn");
                  // 모달창 각 버튼도 변수 선언 및 할당.
                  $("#modalCloseBtn").on("click", function(e) {
                     modal.modal("hide");
                     // 모달 닫기 라는 버튼을 클릭한다면 모달창을 숨김.
                  });
                  $("#addReplyBtn").on("click", function(e) {
                     // 덧글 쓰기 버튼을 클릭한다면,
                     modal.find("input").val("");
                     // 모달의 모든 입력창을 초기화
                     modalInputReplyDate.closest("div").hide();
                     // closest : 선택 요소와 가장 가까운 요소를 지정.
                     // 즉, modalInputReplyDate 요소의 가장 가까운
                     // div를 찾아서 숨김. (날짜창 숨김)
                     modal.find("button[id != 'modalCloseBtn']").hide();
                     // 모달창에 버튼이 4개 인데, 닫기 버튼을 제외하고 숨기기.
                     modalRegisterBtn.show(); // 등록 버튼은 보여라.
                     $("#myModal").modal("show");// 모달 표시.
                  });
                  modalRegisterBtn.on("click", function(e) {

                     // 덧글 등록 버튼을 눌렀다면,
                     var reply = {
                        reply : modalInputReply.val(),
                        replyer : modalInputReplyer.val(),
                        bno : bnoValue
                     }; // ajax로 전달할 reply 객체 선언 및 할당.

                     replyService.add(reply, function(result) {
                        alert(result);
                        // ajax 처리후 결과 리턴.

                        modal.find("input").val(""); // 모달창 초기화
                        modal.modal("hide");// 모달창 숨기기
                        modalInputReplyDate.closest("div").show();

                        //showList(1); // 덧글 목록 갱신.
                        showList(-1); // 목록 자동 새로고침.
                     });
                  });
                  $(".chat").on("click","li",
                              function(e) {

                                 //클래스 chat 을 클릭하는데, 하위 요소가 li라면,

                                 var rno = $(this).data("rno");
                                 // 덧글에 포함된 값들 중에서 rno를 추출하여 변수 할당.
                                 console.log("rno:" + rno);
                                 // 콘솔 출력.
                                 replyService.get(rno,function(reply) {
                                                modalInputReply.val(reply.reply);
                                                modalInputReplyer.val(reply.replyer);
                                                modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
                                                // 댓글 목록의 값들을 모달창에 할당.
                                                modal.data("rno",reply.rno);
                                                modal.find("button[id !='modalCloseBtn']").hide();
                                                modalModBtn.show();
                                                modalRemoveBtn.show();
                                                // 버튼 보이기 설정.
                                                $("#myModal").modal("show");
                                             });
                              });
                  modalModBtn.on("click", function(e) {
                     var reply = {
                        rno : modal.data("rno"),
                        reply : modalInputReply.val()
                     };
                     replyService.update(reply, function(result) {
                        alert(result);
                        modal.modal("hide");
                        showList(1);
                     });
                  });
                  modalModBtn.on("click", function(e) {
                     var reply = {
                        rno : modal.data("rno"),
                        reply : modalInputReply.val()
                     };
                     replyService.update(reply, function(result) {
                        alert(result);
                        modal.modal("hide");
                        showList(1);
                     });
                  });
                  modalRemoveBtn.on("click", function(e) {
                     var rno = modal.data("rno");
                     replyService.remove(rno, function(result) {
                        alert(result);
                        modal.modal("hide");
                        showList(-1);
                     });
                  });

               });//end_class;
</script>

<script>
   /* $(document).ready(function() {
      console.log("history.state : " + history.state);
   }); */

   $(document).ready(function() {
      var operForm = $("#operForm");
      $("button[data-oper='modify']").on("click", function(e) {
         operForm.attr("action", "/board/modify").submit();
      });
      $("button[data-oper='QnA']").on("click", function(e) {
         operForm.find("#bno").remove();
         operForm.attr("action", "/admin/board/QnA");
         operForm.submit();
      });
      /* 폼에서 어떤 버튼이 눌렸는지 확인하여,
      액션을 변경하거나, 일부 값을 삭제하여 전송.*/
   });
</script>

<script>
   $(document).ready(function() {(function() {
                     var bno = '<c:out value="${board.bno}"/>';
                     // 화면상에 공유된 bno 값 가져와 사용 준비.
                     $.getJSON("/board/getAttachList",
                                 {bno : bno},
                                 function(arr) {
                                    console.log(arr);

                                    var str = "";
                                    $(arr).each(function(i,attach) {
                                    str += "<li data-path='"+attach.uploadPath+"'data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'></div>";
                                    str += "<img class='QnAImg' src='/upload/"+attach.uploadPath+"/"+ attach.uuid +"_"+ attach.fileName+"'/>";
                                    str += "</div></li>";
                                    });
                                    $(".uploadResult ul").html(str);

                                 });
                  })();
                  // bno를 전달하여 콘트롤러에서 처리후, 첨부파일 목록을 콘솔로 출력.

               });
</script>

<script>
   $("#uploadResult").change(
         function() {
            if (this.files && this.files[0]) {
               var reader = new FileReader;
               reader.onload = function(data) {
                  $(".select_img img").attr("src", data.target.result)
                        .width(500);
               }
               reader.readAsDataURL(this.files[0]);
            }
         });
</script>



<%@ include file="../include/footer.jsp"%>