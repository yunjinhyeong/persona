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
<!-- <link href="/css/fileNotice.css" rel="stylesheet"> -->
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<div class="tab">

		<h1>공지사항</h1>
		<hr>
		<jsp:include page="/WEB-INF/views/include/CustomerMenu.jsp" />
		<div class="FAQwrapper">
			<article>
				<div class="search">
					<form action="/CS/CustomerNotice" method="get">
						<select name="category">
							<option value="subject"
								${ pageDto.category eq 'subject' ? 'selected' : '' }>글제목</option>
							<option value="content"
								${ pageDto.category eq 'content' ? 'selected' : '' }>글내용</option>
						</select>
						<input type="text" class="input_box" name="search"
							value="${ pageDto.search }"> 
						<input type="submit"
							value="검색" class="btn">

						<%-- 관리자만 [글쓰기] 버튼 보이기 --%>
						<c:if test="${ sessionScope.id eq 'admin'}">
							<input type="button" value="글쓰기" class="btn"
								onclick="location.href='/CS/write?pageNum=${ pageNum }'">
						</c:if>

					</form>
				</div>
				<table class="noticeHead">
					<tr>
						<th id="th1">번호</th>
						<th id="th2">구분</th>
						<th id="th3">제목</th>
						<th id="th4">등록일</th>
					</tr>

					<c:choose>
						<c:when test="${ not empty noticeList }">
							<%-- ${ pageDto.count gt 0 } --%>

							<c:forEach var="csnotice" items="${ noticeList }">
								<tr>
									<td>${ csnotice.num }</td>
									<c:if test="${csnotice.rank eq 1}">
									<td>공지사항</td>
									</c:if>
									<c:if test="${csnotice.rank eq 2}">
									<td>영화관 관련</td>
									</c:if>
									<c:if test="${csnotice.rank eq 3}">
									<td>영화관련</td>
									</c:if>
									<td>
										<a href="/CS/contents?num=${ csnotice.num }&pageNum=${ pageNum }">
											${ csnotice.csSubject }
										</a>
									</td>
									<td><fmt:formatDate value="${ csnotice.regDate }"
											pattern="yyyy.MM.dd" /></td>
								</tr>
							</c:forEach>

						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5">게시판 글 없음</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>

				<div class="pageNumber">
					<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
					<c:if test="${ pageDto.count gt 0 }">
						<%-- [이전] --%>
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a
								href="/CS/CustomerNotice?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
						</c:if>

						<%-- 시작페이지 ~ 끝페이지 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }"
							end="${ pageDto.endPage }" step="1">

							<c:choose>
								<c:when test="${ i eq pageNum }">
									<a
										href="/CS/CustomerNotice?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }"
										class="active">${ i }</a>
								</c:when>
								<c:otherwise>
									<a
										href="/CS/CustomerNotice?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">${ i }</a>
								</c:otherwise>
							</c:choose>

						</c:forEach>

						<%-- [다음] --%>
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a
								href="/CS/CustomerNotice?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
						</c:if>
					</c:if>
				</div>
			</article>
		</div>
	</div>



	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
