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
						<th>상품번호</th>
						<th>상품이름</th>
						<th>상품구성</th>
						<th>작성자</th>
						<th>가격</th>
						<th>삭제</th>
					</tr>

					<c:choose>
					<c:when test="${ not empty storeList }"><%-- ${ pageDto.count gt 0 } --%>

						<c:forEach var="store" items="${ storeList }">
							<tr>
								<td>${ store.num }</td>
								<td><a href="/store/content?name=${store.name }&pageNum=${pageNum}">
									${ store.name }
									</a>
								</td>
								<td>${store.content }</td>
								<td>${ store.id }</td>
								<td>${store.price }</td>
								<td class="deleteBtn" onclick="remove('${store.name}')">삭제</td>
							</tr>
						</c:forEach>

					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7">게시판 글 없음</td>
						</tr>
					</c:otherwise>
					</c:choose>

				</table>

				<div>
					<form action="/fileNotice/list" method="get">
						<select name="category">
							<option value="name" ${ pageDto.category eq 'subject' ? 'selected' : '' }>글제목</option>
							<option value="content" ${ pageDto.category eq 'content' ? 'selected' : '' }>글내용</option>
							<option value="id" ${ pageDto.category eq 'id' ? 'selected' : '' }>작성자ID</option>
						</select>
						<input type="text" class="input_box" name="search" value="${ pageDto.search }">
						<input type="submit" value="검색" class="btn">

						<%-- 로그인 했을때만 [글쓰기] 버튼 보이기 --%>
						<c:if test="${ not empty sessionScope.id }">
							<input type="button" value="글쓰기" class="btn" onclick="location.href='/store/write?pageNum=${ pageNum }'">
						</c:if>

					</form>
				</div>

				<div class="pageNumber">
					<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
					<c:if test="${ pageDto.count gt 0 }">
						<%-- [이전] --%>
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a href="/store/list?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
						</c:if>

						<%-- 시작페이지 ~ 끝페이지 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">

							<c:choose>
							<c:when test="${ i eq pageNum }">
								<a href="/store/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }" class="active">${ i }</a>
							</c:when>
							<c:otherwise>
								<a href="/store/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">${ i }</a>
							</c:otherwise>
							</c:choose>

						</c:forEach>

						<%-- [다음] --%>
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a href="/store/list?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
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
	function remove(name) {
		console.log(name);
		let isDelete = confirm('상품을 제거하겠습니까?');
		if (isDelete) {
			location.href = '/store/delete?name='+name+'&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>

