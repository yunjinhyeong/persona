<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/fileNotice.css" rel="stylesheet">
<link href="/css/sidebarForAdmin.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
	<div class="wrapper">
	<%-- sidebar 영역 --%>
	<jsp:include page="/WEB-INF/views/include/sidebarForAdmin.jsp" />
		<div class="main_content">
			<article>

		<%-- 	<h1>자료실 게시판 [글갯수: ${ pageDto.count }]</h1> --%>

				<table>
					<tr>
						<th>글번호</th>
						<th>섹션</th>
						<th>제목</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>등록일</th>
						<th>삭제</th>
					</tr>

					<c:choose>
					<c:when test="${ not empty eventList }"><%-- ${ pageDto.count gt 0 } --%>

						<c:forEach var="event" items="${ eventList }">
							<tr>
								<td>${ event.ENum }</td>
								<td class="eventSection">${ event.ESection }</td>
								<td class="title"><a href="/eventNotice/content?num=${ event.ENum }&pageNum=${ pageNum }">${ event.ETitle }</a></td>
								<td>${ event.startDate }</td>
								<td>${ event.endDate }</td>
								<td><fmt:formatDate value="${ event.regDate }" pattern="yyyy.MM.dd"/></td>
								<td class="deleteBtn" onclick="remove(${ event.ENum })">삭제</td>
							</tr>
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7">등록된 이벤트 없음</td>
						</tr>
					</c:otherwise>
					</c:choose>
				</table>

				<div>
					<form action="/eventNotice/list" method="get">
						<select name="category">
							<option value="esection" ${ pageDto.category eq 'esection' ? 'selected' : '' }>섹션</option>
							<option value="etitle" ${ pageDto.category eq 'etitle' ? 'selected' : '' }>제목</option>
							<option value="edate" ${ pageDto.category eq 'id' ? 'selected' : '' }>날짜</option>
						</select>
						<input type="text" class="input_box" name="search" value="${ pageDto.search }">
						<input type="submit" value="검색" class="btn">

						<%-- 로그인 했을때만 [글쓰기] 버튼 보이기 --%>
						<c:if test="${ not empty sessionScope.id }">
							<c:if test="${ sessionScope.id eq 'admin' }">
								<input type="button" value="이벤트등록" class="btn" onclick="location.href='/eventNotice/write?pageNum=${ pageNum }'">
							</c:if>
						</c:if>

					</form>
				</div>

				<div class="pageNumber">
					<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
					<c:if test="${ pageDto.count gt 0 }">
						<%-- [이전] --%>
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a href="/eventNotice/list?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
						</c:if>

						<%-- 시작페이지 ~ 끝페이지 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">

							<c:choose>
							<c:when test="${ i eq pageNum }">
								<a href="/eventNotice/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }" class="active">${ i }</a>
							</c:when>
							<c:otherwise>
								<a href="/eventNotice/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">${ i }</a>
							</c:otherwise>
							</c:choose>

						</c:forEach>

						<%-- [다음] --%>
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a href="/eventNotice/list?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
						</c:if>
					</c:if>
				</div>
			</article>
		</div>
	</div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
	// 게시글 삭제 함수
	function remove(num) {
		let isDelete = confirm(num+'번 글을 정말 삭제하시겠습니까?');
		if (isDelete) {
			location.href = '/eventNotice/delete?num='+num+'&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>

