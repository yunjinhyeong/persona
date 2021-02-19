<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<link href="/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="/css/fileContent.css" rel="stylesheet">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<style>
/* 나타나고 있을때와 사라지고 있을때 0.5초*/
.v-enter-active, .v-leave-active {
	transition: 0.1s;
}
/* 나타나기 전의 상태과 사라진 후의 상태는 투명도 0, 오른쪽으로 50 이동*/
.v-enter, .v-leave-to {
	opacity: 0;
	transform: translateX(20px)
}
</style>
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

		<article>
			<table>
				<tr>
					<th class="borderTitle">글번호</th>
					<td class="borderBottom">${ csNoticeVo.num }</td>
					<th class="borderTitle">작성자</th>
					<td class="borderBottom">${ csNoticeVo.id }</td>
					<th class="borderTitle">구분</th>
					<td class="borderBottom">
						<c:if test="${ csNoticeVo.rank eq '1' }">공지사항</c:if>
						<c:if test="${ csNoticeVo.rank eq '2' }">영화정보</c:if>
						<c:if test="${ csNoticeVo.rank eq '3' }">영화관정보</c:if>
					</td>
				</tr>
				<tr>
					<th class="borderTitle">글제목</th>
					<td colspan="3" class="borderBottomDate">${ csNoticeVo.csSubject }</td>
					<th class="borderTitle">작성일자</th>
					<td class="borderBottom"><fmt:formatDate value="${ csNoticeVo.regDate }"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
				<tr>
					<th class="borderTitle">글내용</th>
					<td colspan="5">${ csNoticeVo.csContents }</td>
				</tr>
			</table>

			<div class="btns">

				<c:if test="${ id eq 'admin' }">
					<%-- 관리자로 로그인 했을때 --%>
						<input type="button" value="글수정" class="btn" onclick="location.href = '/CS/CSModify?num=${ csNoticeVo.num }&pageNum=${ pageNum }'">
						<input type="button" value="글삭제" class="btn" onclick="remove()">
				</c:if>

				<input type="button" value="목록보기" class="btn"
					onclick="location.href = '/CS/CustomerNotice?pageNum=${ pageNum }'">
			</div>

		</article>


	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />


	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
	<script src="/script/jquery-3.5.1.js"></script>
	<script>
		// 게시글 삭제 함수
		function remove() {
			let isDelete = confirm('${ csNoticeVo.num }번 글을 정말 삭제하시겠습니까?');
			if (isDelete) {
				location.href = '/CS/delete?num=${ csNoticeVo.num }&pageNum=${ pageNum }';
			}
		}
	</script>
	<script>
		// 게시글 번호
		const nno = ${ csNoticeVo.num };

		new Vue({
			el: '#app',
			data: {
				loginId: '${ sessionScope.id }', // 톰캣서버 세션의 로그인 아이디
				pageNo: 1,  // 사용자 요청 페이지 번호
				showListArea: true,  // 댓글리스트 영역 보이기 여부 스위치
				totalCount: 0,    // 전체 댓글 갯수
				commentList: [],  // 댓글 리스트 데이터
				inputComment: '', // 주댓글 입력내용
				inputReplyComment: '', // 답댓글 또는 댓글수정 입력내용
				type: '',  // 댓글수정(update) 또는 답댓글 추가(insert) 인지 구분

				// 페이지블록 관련 데이터 속성
				pageBlock: 5,  // 페이지블록 내의 페이지 갯수
				startPage: 0,  // 페이지블록 내의 시작페이지
				endPage: 0,    // 페이지블록 내의 끝페이지
				pageBlockList: [] // 페이지블록 리스트 (시작페이지부터 끝페이지까지의 페이지번호가 요소)
			},
			// 산출속성은 반드시 값을 리턴해야 함!
			computed: {

				isPrevOk: function () { // 이전 페이지블록 존재 여부
					return this.startPage > this.pageBlock;
				},

				isNextOk: function () { // 다음 페이지블록 존재여부
					return this.endPage < this.pageCount;
				},

				prevBlockPage: function () {
					return this.startPage - this.pageBlock;
				},

				nextBlockPage: function () {
					return this.startPage + this.pageBlock;
				}
			},
			watch: {
				inputComment: function () {
					if (this.inputComment.length > 600) {
						this.inputComment = this.inputComment.substring(0, 600);
					}
				}
			},
			mounted: function () {
				this.getList();
			}
		});

	</script>
</body>
</html>



