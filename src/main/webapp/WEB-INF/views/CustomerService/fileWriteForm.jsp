<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/fileWMR.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
	
	<article>		
		
		<form action="/CS/write" method="post" enctype="multipart/form-data" name="frm">
		<input type="hidden" name="pageNum" value="${ pageNum }">
		<table>
			<tr>
				<th class="borderTitle">작성자</th>
				<td class="borderBottom"><input type="text" name="id" value="${ id }" readonly></td>
			</tr>
			<tr>
				<th class="borderTitle">구분</th>
				<td class="borderBottom">
				<select class="selectWrite" name="rank">
					<option value="1">공지사항</option>
					<option value="2">영화관 관련</option>
					<option value="3">영화 관련</option>
				</select>
				</td>
			</tr>
			<tr>
				<th class="borderTitle">글제목</th>
				<td class="borderBottom"><input type="text" name="csSubject"></td>
			</tr>
			<tr>
				<th class="borderTitle">글내용</th>
				<td class="borderBottom"><textarea rows="13" cols="40" name="csContents"></textarea></td>
			</tr>
		</table>
	
		<div class="btns">
			<input type="submit" value="글쓰기" class="btn">
			<input type="reset" value="다시쓰기" class="btn">
			<input type="button" value="목록보기" class="btn" onclick="location.href = '/CS/CustomerNotice?pageNum=${ pageNum }'">
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
		if (fileCount >= 5) {
			alert('첨부파일은 최대 5개 까지만 첨부할 수 있습니다.');
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





    