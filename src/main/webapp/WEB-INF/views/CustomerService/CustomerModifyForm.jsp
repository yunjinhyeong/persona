<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		
		<form action="/CS/CSModify" method="post" enctype="multipart/form-data" name="frm">
		<input type="hidden" name="pageNum" value="${ pageNum }">
		<input type="hidden" name="num" value="${ csNoticeVo.num }">
		<table>
			<tr>
				<th class="borderTitle">작성자</th>
				<td class="borderBottom"><input type="text" name="id" value="${ csNoticeVo.id }" readonly></td>
			</tr>
			<tr>
				<th class="borderTitle">구분</th>
				<td class="borderBottom">
				<select name="rank">
					<option value="1">공지사항</option>
					<option value="2">영화관 관련</option>
					<option value="3">영화 관련</option>
				</select>
				</td>
			</tr>
			<tr>
				<th class="borderTitle">글제목</th>
				<td class="borderBottom"><input type="text" name="csSubject" value="${ csNoticeVo.csSubject }"></td>
			</tr>
			<tr>
				<th class="borderTitle">글내용</th>
				<td class="borderBottom"><textarea rows="13" cols="40" name="csContents">${ csNoticeVo.csContents }</textarea></td>
			</tr>
		</table>
	
		<div class="btns">
			<input type="submit" value="글수정" class="btn">
			<input type="reset" value="다시쓰기" class="btn">
			<input type="button" value="목록보기" class="btn" onclick="location.href = '/CS/CustomerNotice?pageNum=${ pageNum }'">
		</div>
		</form>
		
	</article>
    
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script src="/script/jquery-3.5.1.js"></script>
<script>
const maxFileCount = 5;  // 최대 첨부파일 갯수
var fileCount = ${ fn:length(attachList) };  // 현재 첨부된 파일 갯수

// [첨부파일 추가] 버튼을 클릭할 때
$('#btnAddFile').click(function () {

	if (fileCount >= maxFileCount) {
		alert('첨부파일은 최대 5개 까지만 가능합니다.')
		return;
	}
	
	// 백틱 문자열 안에서 변수값을 표현할때는
	// \${}로 표현함
	var str = `
		<div>
			<input type="file" name="filename">
			<span class="delete-addfile">X</span>
		</div>
	`;

	$('div#newFileBox').append(str);
	
	fileCount++;
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

    