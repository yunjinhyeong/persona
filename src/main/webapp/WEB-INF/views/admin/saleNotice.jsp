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
						<th>카드번호</th>
						<th>카드종류</th>
						<th>카드이름</th>
						<th>할인종류</th>
						<th>온/오프라인</th>
						<th>할인값</th>
						<th>삭제</th>
					</tr>

					<c:choose>
					<c:when test="${ not empty cardList }"><%-- ${ pageDto.count gt 0 } --%>

						<c:forEach var="card" items="${ cardList }">
							<tr>
								<td>${ card.CNum }</td>
								<td>${ card.CKinds }</td>
								<td><a href="/saleNotice/content?num=${ card.CNum }&pageNum=${ pageNum }">${ card.CName }</a></td>
								<td>${ card.CSale }</td>
								<td>${ card.COnoff }</td>
								<td>${ card.CDiscount }</td>
								<td class="deleteBtn" onclick="remove(${ card.CNum })">삭제</td>
							</tr>
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="10">등록된 카드 없음</td>
						</tr>
					</c:otherwise>
					</c:choose>

				</table>

				<div>
					<form action="/saleNotice/list" method="get">
						<select name="category">
							<option value="ckinds" ${ pageDto.category eq 'ckinds' ? 'selected' : '' }>카드종류</option>
							<option value="cname" ${ pageDto.category eq 'cname' ? 'selected' : '' }>카드이름</option>
							<option value="csale" ${ pageDto.category eq 'csale' ? 'selected' : '' }>할인종류</option>
							<option value="conoff" ${ pageDto.category eq 'conoff' ? 'selected' : '' }>온/오프라인</option>
							<option value="cdiscount" ${ pageDto.category eq 'cdiscount' ? 'selected' : '' }>할인값</option>
						</select>
						<input type="text" class="input_box" name="search" value="${ pageDto.search }">
						<input type="submit" value="검색" class="btn">

						<%-- 로그인 했을때만 [글쓰기] 버튼 보이기 --%>
						<c:if test="${ not empty sessionScope.id }">
							<c:if test="${ sessionScope.id eq 'admin' }">
								<input type="button" value="카드등록" class="btn" onclick="location.href='/saleNotice/write?pageNum=${ pageNum }'">
							</c:if>
						</c:if>

					</form>
				</div>

				<div class="pageNumber">
					<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
					<c:if test="${ pageDto.count gt 0 }">
						<%-- [이전] --%>
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a href="/saleNotice/list?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
						</c:if>

						<%-- 시작페이지 ~ 끝페이지 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">

							<c:choose>
							<c:when test="${ i eq pageNum }">
								<a href="/saleNotice/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }" class="active">${ i }</a>
							</c:when>
							<c:otherwise>
								<a href="/saleNotice/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">${ i }</a>
							</c:otherwise>
							</c:choose>

						</c:forEach>

						<%-- [다음] --%>
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a href="/saleNotice/list?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
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
			location.href = '/saleNotice/delete?num='+num+'&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>

