<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c로 표시 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 동일 
fmt : formatter 형식 맞춰서 표시, 표시형식을 바꾼다는 의미-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/nav2.jsp"%>


<h2>회원 목록</h2>
<table class="table table-bordered" id="dataTable" width="100%"
	cellspacing="0">
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>가입일자</th>
			
		</tr>
	</thead>
	<tbody>
		<c:forEach var="login" items="${list }">
			<tr>
				<td>${login.user_id }</td>
				<td><a
					href="${path}/admin/login/memberView?user_id=${login.user_id}">${login.user_name }</td>
				<td>${login.user_email }</td>
				<td><fmt:formatDate value="${login.regdate }"
						pattern="yyyy-MM-dd" /></td>
				

			</tr>
		</c:forEach>
	</tbody>
</table>
<%@ include file="../include/footer.jsp"%>