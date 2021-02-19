<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/CustomerService.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
	<div class="tab">
		<h1>1:1문의</h1>
		<hr>
		<jsp:include page="/WEB-INF/views/include/CustomerMenu.jsp" />
		<div class="FAQwrapper">
			<article>
				<form action="/CS/mtmWrite" method="post"
					enctype="multipart/form-data" name="frm">
					<input type="hidden" name="pageNum" value="${ pageNum }">
					<input type="hidden" name="questioner" value="${ id }">
					<table>
						<tr>
							<th class="borderTitle">작성자</th>
							<td class="borderBottom longTitle"><input type="text" name="mid" value="${ id }" readonly></td>
<!-- 							지울것 -->
<!-- 							<th class="borderTitle">문의자</th> -->
<%-- 							<td class="borderBottom longTitle"><input type="text" name="questioner" value="${ id }" readonly></td> --%>
						</tr>
						<tr>
							<th class="borderTitle">분류선택</th>
							<td class="borderBottom">
							<select name="mquestion">
									<option value="1">영화관</option>
									<option value="2">영화</option>
									<option value="3">멤버쉽</option>
									<option value="4">결제</option>
									<option value="5">예약</option>
									<option value="6">이벤트</option>
							</select></td>
							<th class="borderTitle">문의종류</th>
							<td class="borderBottom">
							<select name="mkinds">
									<option value="1">문의</option>
									<option value="2">칭찬</option>
									<option value="3">불만</option>
									<option value="4">건의</option>
									<option value="5">의미없는 악플</option>
							</select></td>
						</tr>
						<tr>
							<th class="borderTitle">문의제목</th>
							<td class="borderBottom longTitle"><input type="text" id="csTitle" name="msubject"></td>
						</tr>
						<tr>
							<th class="borderTitle">문의내용</th>
							<td class="borderBottom">
							<textarea rows="13" cols="40" id="csContents" name="mcontents"></textarea>
							</td>
						</tr>
					</table>

					<div class="btns">
						<input type="submit" value="글 남기기" class="btn" id="submit"> 
						<input type="reset" value="다시쓰기" class="btn"> 
						<c:if test="${ not empty sessionScope.id && id ne 'admin' }">
							<input type="button" value="내가 쓴글 보기" class="btn" onclick="location.href='/CS/NoticeById?id=${ id }&pageNum=${ pageNum }'">
						</c:if>
						<c:if test="${ id eq 'admin' }">
							<input type="button" value="문의 사항 보기" class="btn" onclick="location.href='/CS/mtmNotice?id=${ id }&pageNum=${ pageNum }'">
						</c:if> 
					</div>
				</form>
			</article>
		</div>

	</div>
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
<script>
	$("#submit").click(function(){
		if("#csTitle" eq ""  || "#csContents" eq "" ){
			alert("제목과 내용을 입력해주세요")
			return;
		}
		});
</script>
</body>
</html>





