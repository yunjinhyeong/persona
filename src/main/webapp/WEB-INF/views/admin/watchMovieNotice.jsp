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
						<th>제목</th>
						<th>지역</th>
						<th>날짜/시간</th>
						<th>상영관</th>
						<th>등록일</th>
						<th>삭제</th>
					</tr>

					<c:choose>
					<c:when test="${ not empty watchMovieList }"><%-- ${ pageDto.count gt 0 } --%>

						<c:forEach var="watch" items="${ watchMovieList }">
							<tr>
								<td>${ watch.num }</td>
								<td class="title"><a href="/watchMovie/content?num=${ watch.num }&pageNum=${ pageNum }">${ watch.name }</a></td>
								<td class="eventSection">${ watch.area }</td>
								<td>${ watch.date }</td>
								<td>${ watch.theater }</td>
								<td><fmt:formatDate value="${ watch.regDate }" pattern="yyyy.MM.dd"/></td>
								<td class="deleteBtn" onclick="remove('${ watch.num }', '${ watch.name }' )">삭제</td>
							</tr>
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7">등록된 예매 없음</td>
						</tr>
					</c:otherwise>
					</c:choose>
				</table>

				<div>
					<form action="/watchMovie/list" method="get">
						<select name="category">
							<option value="id" ${ pageDto.category eq 'id' ? 'selected' : '' }>아이디</option>
							<option value="name" ${ pageDto.category eq 'name' ? 'selected' : '' }>제목</option>
							<option value="date" ${ pageDto.category eq 'date' ? 'selected' : '' }>날짜</option>
						</select>
						<input type="text" class="input_box" name="search" value="${ pageDto.search }">
						<input type="submit" value="검색" class="btn">

						<%-- 로그인 했을때만 [글쓰기] 버튼 보이기 --%>
						<c:if test="${ not empty sessionScope.id }">
							<c:if test="${ sessionScope.id eq 'admin' }">
								<input type="button" value="상영영화등록" class="btn" onclick="location.href='/watchMovie/write?pageNum=${ pageNum }'">
							</c:if>
						</c:if>

					</form>
				</div>

				<div class="pageNumber">
					<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
					<c:if test="${ pageDto.count gt 0 }">
						<%-- [이전] --%>
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a href="/watchMovie/list?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
						</c:if>

						<%-- 시작페이지 ~ 끝페이지 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">

							<c:choose>
							<c:when test="${ i eq pageNum }">
								<a href="/watchMovie/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }" class="active">${ i }</a>
							</c:when>
							<c:otherwise>
								<a href="/watchMovie/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">${ i }</a>
							</c:otherwise>
							</c:choose>

						</c:forEach>

						<%-- [다음] --%>
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a href="/watchMovie/list?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
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
	function remove(num,name) {
		let isDelete = confirm(num+name+'번 글을 정말 삭제하시겠습니까?');
		if (isDelete) {
			location.href = '/watchMovie/delete?num='+num+'&pageNum=${ pageNum }&name='+name;
		}
	}
</script>
</body>
</html>

