<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/findPWID.css" rel="stylesheet">
<title>패스워드 찾기</title>
</head>
<body>	
	<form action="/member/findPW" method="post" name="frm">
		<h2>😍패스워드 찾기😍</h2>
		<input id="id" name="id" type="text" placeholder="아이디" required>
		<input id="name" name="name" type="text" placeholder="이름" required>		
		<input id="email" name="email" type="email" placeholder="이메일" required>
		<input type="submit" value="패스워드 찾기">
	</form>
</body>
</html>