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

<div> ${memberVo.id} </div>
	<article>

		<form action="/store/modify" method="post" enctype="multipart/form-data" name="frm">
		<input type="hidden" name="pageNum" value="${ pageNum }">
		<input type="hidden" name="num" value="${productVo.num }" />
		<table>
			<tr>
				<th class="borderTitle">작성자</th>
				<td class="borderBottom"><input type="text" name="id" value="${id }" readonly></td>
			</tr>
			<tr>
				<th class="borderTitle">상품 이름</th>
				<td class="borderBottom"><input type="text" name="name" value="${productVo.name }" ></td>
			</tr>
			<tr>
				<th class="borderTitle">구성 물품</th>
				<td class="borderBottom"><textarea rows="13" cols="42" name="content" >${productVo.content }</textarea></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="text" name="price" value="${productVo.price }"></td>
			</tr>
			<tr>
				<th class="borderTitle">사진</th>
				<td class="borderBottom">
					<div id="oldFileBox">


						<input type="hidden" name="oldfile" value="${ sattachVo.nnum }">
						<div>
							${ sattachVo.filename }
							<span class="delete-oldfile">X</span>
						</div>


				</div>
				<div id="newFileBox"></div>
				<input type="button" id="btnAddFile" value="첨부파일 추가">
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

		$('div#newFileBox').append(str);

		fileCount++;
	});

	// 동적 이벤트 연결 (이벤트 등록을 위임하는 방식)
	$('div#fileBox').on('click', 'span.file-delete', function () {
		//alert('span X 클릭됨');

		//$(this).closest('div').remove();
		$(this).parent().remove();

		fileCount--;
	});
	// 동적 이벤트 바인딩. 이벤트 바인딩 작업을 이미 존재하는 요소에게 위임하기.
	// 이미 존재하는 div#newFileBox 요소에게
	// 안쪽에 새로운 span.delete-addfile가 들어오면 클릭이벤트 연결하기
	$('div#newFileBox').on('click', 'span.delete-addfile', function () {
		$(this).parent().remove();
		fileCount--;
	});

	// 정적 이벤트 바인딩. 기존 첨부파일에 삭제버튼을 눌렀을때
	$('span.delete-oldfile').on('click', function () {
		// 현재 클릭한 요소의 직계부모(parent)의 앞(prev) 요소
		$(this).parent().prev().prop('name', 'delfile');
		// 현재 클릭한 요소의 직계부모(parent)를 삭제. 현재요소안에 자식요소도 모두 삭제됨
		$(this).parent().remove();
		fileCount--;
	});

</script>
</body>
</html>





