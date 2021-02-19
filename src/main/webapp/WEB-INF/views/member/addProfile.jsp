<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/member/addProfile?id=${memberVo.getId() }" method="post" enctype="multipart/form-data" name="frm">
		<table align="center">
			<tr>
				<td>사진을 선택 해주세요</td>
			</tr>
			<tr>
				<td><input type="file" name="filename"></td>
			</tr>
			<tr>
				<td><input type="submit" value="등록하기"  id="register"/></td>
			</tr>
			<tr>
				<td><input type="hidden" value="${memberVo.getId() }" /> </td>
			</tr>
		</table>
	</form>

<script src="/script/jquery-3.5.1.js"></script>
<script>
$("#register").on("click", function(){
	window.close();

})

</script>
</body>
</html>