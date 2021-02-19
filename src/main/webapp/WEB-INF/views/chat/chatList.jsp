<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>

<link href="/css/fileContent.css" rel="stylesheet">
<link href="/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<jsp:include page="/WEB-INF/views/include/head.jsp" />

<style type="text/css">
div#chatbox {
	width: 400px;
	height: 300px;
	border: 1px solid black;
	background-color: lightgray;
	overflow: auto;
}
</style>
</head>
<body>

	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
	<div class="chatImg">
		
		<img alt="" src="/imgs/chat1.jpg">
		<div id="app" class="appChat">
		<h1>채팅방 목록</h1>
		<hr>

		<table border="1">
			<thead>
				<tr>
					<th width="20%">방번호 아이디</th>
					<th width="60%">방 제목</th>
					<th>입장 버튼</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${ fn:length(roomList) gt 0 }">

						<c:forEach var="room" items="${ roomList }">
						<tr>
							<td>${ room.roomId }</td>
							<td>${ room.title }</td>
							<td>
								<input type="button" value="채팅방 입장하기" onclick="location.href = '/chat/room/${ room.roomId }'">
							</td>
						</tr>
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="3">현재 개설된 채팅방이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>

			</tbody>
		</table>

		<a href="/chat/new">새로운 채팅방 만들기</a>
	</div>
	<img alt="" src="/imgs/chat2.jpg">
</div>

		<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />


<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
<script>

</script>
</body>
</html>





