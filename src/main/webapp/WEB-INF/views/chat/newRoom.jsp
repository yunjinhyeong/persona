<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="/css/fileContent.css" rel="stylesheet">
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
			<h1>새로운 채팅방 만들기</h1>
			<form action="/chat/new" method="post">
				<input type="text" name="title" placeholder="채팅방 제목 입력" required autofocus>
				<br>
				<input type="submit" value="채팅방 생성하기">
				<input type="button" value="목록으로 돌아가기" onclick="location.href = '/chat/list'">
			</form>
			
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





