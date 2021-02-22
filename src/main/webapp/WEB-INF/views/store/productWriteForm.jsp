<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/fileWMR.css" rel="stylesheet">
<link href="/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<article>

		<form action="/store/write" method="post" enctype="multipart/form-data" name="frm">
		<input type="hidden" name="pageNum" value="${ pageNum }">
		<table>
			<tr>
				<th class="borderTitle">작성자</th>
				<td class="borderBottom"><input type="text" name="id" value="${ id }" readonly></td>
			</tr>
			<tr>
				<th class="borderTitle">상품 이름</th>
				<td class="borderBottom"><input type="text" name="name"></td>
			</tr>
			<tr>
				<th class="borderTitle">구성 물품</th>
				<td class="borderBottom"><textarea rows="13" cols="42" name="content"></textarea></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="num" name="price"></td>
			</tr>
			<tr>
				<th class="borderTitle">사진</th>
				<td class="borderBottom">
					<input type="button" value="첨부파일 추가" id="btnAddFile" class="btn btn-info pull-left" style="width : 400px">
					<div id="fileBox">
						<div>
							<input type="file" name="filename">
							<span class="file-delete">X</span>
						</div>
					</div>
				</td>
			</tr>
		</table>

		<div class="btns">
			<input type="submit" value="글쓰기" class="btn">
			<input type="reset" value="다시쓰기" class="btn">
			<input type="button" value="목록보기" class="btn" onclick="location.href = '/fileNotice/list?pageNum=${ pageNum }'">
		</div>
		</form>

	</article>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script src="/script/jquery-3.5.1.js"></script>
<script>
	let fileCount = 1;

	// 정적 이벤트 연결
	$('#btnAddFile').on('click', function () {
		if (fileCount >= 1) {
			alert('첨부파일은 최대 1개 까지만 첨부할 수 있습니다.');
			return;
		}

		let str = `
			<div>
				<input type="file" name="filename">
				<span class="file-delete">X</span>
			</div>
		`;

		$('#fileBox').append(str);

		fileCount++;
	});


	// 동적 이벤트 연결 (이벤트 등록을 위임하는 방식)
	$('div#fileBox').on('click', 'span.file-delete', function () {
		//alert('span X 클릭됨');

		//$(this).closest('div').remove();
		$(this).parent().remove();

		fileCount--;
	});

</script>
</body>
</html>





