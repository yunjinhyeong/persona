<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/findPWID.css" rel="stylesheet">
<title>아이디 찾기</title>
</head>
<body>	
	<form action="/member/findID" method="post" name="frm">
		<h2>😁아이디 찾기😁</h2>
		<input id="name" name="name" type="text" placeholder="이름" required>		
		<input id="email" name="email" type="email" placeholder="이메일" required>
		<input type="submit" value="아이디 찾기">
	</form>
</body>
</html>