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
						<th>아이디</th>
						<th>비밀번호</th>
						<th>이름</th>
						<th>연</th>
						<th>월</th>
						<th>일</th>
						<th>성별</th>
						<th>이메일</th>
						<th>우편번호</th>
						<th>주소</th>
						<th>상세주소</th>
						<th>가입일</th>
						<th>삭제</th>
					</tr>
					
					<c:choose>
					<c:when test="${ not empty memberList }"><%-- ${ pageDto.count gt 0 } --%>
						
						<c:forEach var="member" items="${ memberList }">
							<tr>
								<td>${ member.id }</td>
								<td>${ member.passwd }</td>
								<td>${ member.name }</td>
								<td>${ member.yy }</td>
								<td>${ member.mm }</td>
								<td>${ member.dd }</td>
								<td>${ member.gender }</td>
								<td>${ member.email }</td>
								<td>${ member.postcode }</td>
								<td>${ member.address }</td>
								<td>${ member.address2 }</td>
								<td><fmt:formatDate value="${ member.regDate }" pattern="yyyy.MM.dd"/></td>
								<td class="deleteBtn" onclick="remove('${ member.id }')">삭제</td>
							</tr>
						</c:forEach>
						
					</c:when>		
					<c:otherwise>
						<tr>
							<td colspan="13">등록된 회원 없음</td>
						</tr>
					</c:otherwise>
					</c:choose>
				</table>
		
				<div>
					<form action="/member/list" method="get">
						<select name="category">
							<option value="id" ${ pageDto.category eq 'id' ? 'selected' : '' }>아이디</option>
							<option value="name" ${ pageDto.category eq 'name' ? 'selected' : '' }>이름</option>
							<option value="email" ${ pageDto.category eq 'email' ? 'selected' : '' }>이메일</option>
						</select>
						<input type="text" class="input_box" name="search" value="${ pageDto.search }">
						<input type="submit" value="검색" class="btn">
			
					</form>
				</div>
			
				<div class="pageNumber">
					<%-- 글갯수가 0보다 크면 페이지블록 계산해서 출력하기 --%>
					<c:if test="${ pageDto.count gt 0 }">
						<%-- [이전] --%>
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a href="/member/list?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">이전</a>
						</c:if>
						
						<%-- 시작페이지 ~ 끝페이지 --%>
						<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
							
							<c:choose>
							<c:when test="${ i eq pageNum }">
								<a href="/member/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }" class="active">${ i }</a>
							</c:when>
							<c:otherwise>
								<a href="/member/list?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">${ i }</a>
							</c:otherwise>
							</c:choose>
							
						</c:forEach>
						
						<%-- [다음] --%>
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a href="/member/list?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">다음</a>
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
	function remove(id) {
		let isDelete = confirm(id+'님을 정말 삭제하시겠습니까?');
		if (isDelete) {
			location.href = '/member/delete?id='+id+'&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>   

    