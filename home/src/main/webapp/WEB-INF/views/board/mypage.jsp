<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 
<%@page import="java.util.*"%>
<%
 
    request.setCharacterEncoding("UTF-8");
 
%>
<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/nav.jsp"%>
<%@ include file="../login/mypage.jsp"%>
<style>


table{
	 border-collapse:collapse;
	 marign :auto	
}
td,th{
text-align:center;
padding:10%;
height:15px;
width:100px;
}
thead{
background:
color: yellow;
}
.material-button {
    position: relative;
    top: 0;
    z-index: 1;
    width: 70px;
    height: 70px;
    font-size: 1.5em;
    color: #fff;
    background: #2C98DE;
    border: none;
    border-radius: 50%;
    box-shadow: 0 3px 6px rgba(0,0,0,.275);
    outline: none;
}

.option .option3 {
    filter: blur(5px);
    -webkit-filter: blur(5px);
    -webkit-transition: all .175s;
    transition:         all .175s;
}
.option .option3 {
    -webkit-transform: translate3d(-90px,90px,0) scale(.8,.8);
    transform:         translate3d(-90px,90px,0) scale(.8,.8);
}
.option.scale-on .option3 {
    filter: blur(0);
    -webkit-filter: blur(0);
    -webkit-transform: none;
    transform:         none;
    -webkit-transition: all .175s;
    transition:         all .175s;
}

</style>



<table class="table table-striped table-condensed">
                  <thead>
                  <tr>
            <th>제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>답변완료</th>
			<th>읽기</th>
                     
                  </tr>
              </thead> 
              <tbody>
		<c:forEach var="board" items="${QnA}">
			<tr>
				
				<td>
				 <c:out	value="${board.title }" /></td>
				 
				<td> <c:out	value="${board.content }" /></td>
				<td>${board.writer }</td>
				<td><c:if test="${board.replyCnt ne 0 }">
			<span style="color:red;">[
			<c:out value="답변 완료"/>]</span>
				</c:if>
			</td>
				<td><fmt:formatDate value="${board.regdate }"
						pattern="yyyy-MM-dd" /></td>
						
						
				<td>
				<c:if test="${member.user_name == board.writer}">
				<a href="/board/get?pageNum=1&amount=10&type=&keyword=&bno=${board.bno } ">
				<button class="btn btn-sm btn-primary btn-block" style="WIDTH: 60pt; HEIGHT: 25pt">읽기 </button></a>
				</c:if>
				</td>
				
			</tr>

			</c:forEach>
	</tbody>
              
    
            </table>







<div id="footer"><%@ include file="../includes/footer.jsp"%></div>