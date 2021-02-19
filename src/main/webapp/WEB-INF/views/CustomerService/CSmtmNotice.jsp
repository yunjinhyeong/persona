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
				<table class="noticeHead">
					<tr>
						<th id="th1">번호</th>
						<th id="th2">ID</th>
						<th id="th3">분류</th>
						<th id="th4">문의종류</th>
						<th id="th5">제목</th>
						<th id="th6">등록일</th>
					</tr>

					<c:if test="${ id ne 'admin' }">
						<c:choose>
							<c:when test="${ not empty mtmnoticeList }">
								<%-- ${ pageDto.count gt 0 } --%>
								<c:forEach var="csmtmbyid" items="${ mtmnoticeList }">
									<tr>
										<td>${ csmtmbyid.mnum }</td>
										<td>${ csmtmbyid.mid }</td>
										<td class="borderBottom">
											<c:if test="${ csmtmbyid.mquestion eq '1' }">영화관</c:if>
											<c:if test="${ csmtmbyid.mquestion eq '2' }">영화</c:if>
											<c:if test="${ csmtmbyid.mquestion eq '3' }">멤버</c:if>
											<c:if test="${ csmtmbyid.mquestion eq '4' }">결제</c:if>
											<c:if test="${ csmtmbyid.mquestion eq '5' }">예약</c:if>
											<c:if test="${ csmtmbyid.mquestion eq '6' }">이벤트</c:if>
										</td>
										<td class="borderBottom">
											<c:if test="${ csmtmbyid.mkinds eq '1' }">문의</c:if>
											<c:if test="${ csmtmbyid.mkinds eq '2' }">칭찬</c:if>
											<c:if test="${ csmtmbyid.mkinds eq '3' }">불만</c:if>
											<c:if test="${ csmtmbyid.mkinds eq '4' }">건의</c:if>
											<c:if test="${ csmtmbyid.mkinds eq '5' }">의미없는 악플</c:if>
										</td>
										<td class="title">
											<c:if test="${ csmtmbyid.reLev gt 0 }">
												<img src="/imgs/level.gif" width="${ csmtmbyid.reLev * 15 }" height="16px">
												<img src="/imgs/re.gif">
											</c:if>
											<a
											href="/CS/mtmContents?num=${ csmtmbyid.mnum }&pageNum=${ pageNum }">
												${ csmtmbyid.msubject } 
											</a>
										</td>
										<td><fmt:formatDate value="${ csmtmbyid.regDate }"
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
					</c:if>

					<c:if test="${ id eq 'admin' }">
						<c:choose>
							<c:when test="${ not empty mtmnoticeListByid }">
								<%-- ${ pageDto.count gt 0 } --%>
								<c:forEach var="csmtm" items="${ mtmnoticeListByid }">
									<tr>
										<td>${ csmtm.mnum }</td>
										<td>${ csmtm.mid }</td>
										<td class="borderBottom">
											<c:if test="${ csmtm.mquestion eq '1' }">영화관</c:if>
											<c:if test="${ csmtm.mquestion eq '2' }">영화</c:if>
											<c:if test="${ csmtm.mquestion eq '3' }">멤버</c:if>
											<c:if test="${ csmtm.mquestion eq '4' }">결제</c:if>
											<c:if test="${ csmtm.mquestion eq '5' }">예약</c:if>
											<c:if test="${ csmtm.mquestion eq '6' }">이벤트</c:if>
										</td>
										<td class="borderBottom">
											<c:if test="${ csmtm.mkinds eq '1' }">문의</c:if>
											<c:if test="${ csmtm.mkinds eq '2' }">칭찬</c:if>
											<c:if test="${ csmtm.mkinds eq '3' }">불만</c:if>
											<c:if test="${ csmtm.mkinds eq '4' }">건의</c:if>
											<c:if test="${ csmtm.mkinds eq '5' }">의미없는 악플</c:if>
										</td>
<%-- 										<td>${ csmtm.mquestion }</td> --%>
<%-- 										<td>${ csmtm.mkinds }</td> --%>
										<td class="title">
											<c:if test="${ csmtm.reLev gt 0 }">
												<%-- 답글이면 --%>
												<img src="/imgs/level.gif" style="margin-left: ${csmtm.reLev * 15 }" height="16px">
												<img src="/imgs/re.gif">
											</c:if>
											<a id="mtmsub" href="/CS/mtmContents?num=${ csmtm.mnum }&pageNum=${ pageNum }">
													${ csmtm.msubject } 
											</a>
										</td>
										<td><fmt:formatDate value="${ csmtm.regDate }"
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
					</c:if>
				</table>
				
				<div>
			<form action="#" method="get">
<!-- 				로그인 했을때만 [글쓰기] 버튼 보이기 -->
					<input type="button" class="btn" value="메인화면으로" onclick="location.href='/'">

			</form>
		</div>

				<div class="pageNumber">
					<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
					<c:if test="${ pageDto.count gt 0 }">
						<%-- [이전] --%>
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a href="/CS/mtmNotice?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
						</c:if>

						<%-- 시작페이지 ~ 끝페이지 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }"
							end="${ pageDto.endPage }" step="1">

							<c:choose>
								<c:when test="${ i eq pageNum }">
									<a
										href="/CS/mtmNotice?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }"
										class="active">${ i }</a>
								</c:when>
								<c:otherwise>
									<a
										href="/CS/mtmNotice?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">${ i }</a>
								</c:otherwise>
							</c:choose>

						</c:forEach>

						<%-- [다음] --%>
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a
								href="/CS/mtmNotice?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
						</c:if>
					</c:if>
				</div>
				<!-- 				<div class="search"> -->
				<!-- 					<form action="/CS/MtmNotice" method="get"> -->
				<!-- 						<input type="submit" value="내가 쓴 글 찾기" class="btn"> -->
				<!-- 					</form> -->
				<!-- 				</div> -->
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
</body>
</html>





