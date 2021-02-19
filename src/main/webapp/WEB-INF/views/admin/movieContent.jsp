<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/movieWriteForm.css" rel="stylesheet">
<link href="/css/sidebarForAdmin.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<div class="wrapper">
	<%-- sidebar 영역 --%>
	<jsp:include page="/WEB-INF/views/include/sidebarForAdmin.jsp" />
        <div class="main_content">
                <Table class="addMovieMain">
                    <tr>
                    	<tr>
                            <th><label for="MNum">번호</label></th>
                            <td>${ movieVo.MNum }</td>
                        </tr>
                        <tr>
                            <th><label for="rank">시청등급</label></th>
                            <td>${ movieVo.MRank }</td>
                        </tr>
                        <tr>
                            <th><label for="MName">영화제목</label></th>
                            <td>${ movieVo.MName }</td>
                        </tr>
                        <tr>
							<th><label for="MImg">포스트</label></th>

							<td><c:if test="${ not empty mImgTrailerList }">
								<c:forEach var="mImgTrailer" items="${ mImgTrailerList }">
										<c:if test="${ mImgTrailer.image eq 'P' }">
											<p>
												<a href="/upload/${ mImgTrailer.uploadpath }/${ mImgTrailer.uuid }_${ mImgTrailer.filename }">
													<img  width='200' src="/upload/${ mImgTrailer.uploadpath }/${ mImgTrailer.uuid }_${ mImgTrailer.filename }" width="600px">
												</a>
											</p>
										</c:if>
								</c:forEach>
							</c:if>
							</td>
						</tr>
						<tr>
							<th><label for="MTrailer">트레일러</label></th>

							<td><c:if test="${ not empty mImgTrailerList }">
								<c:forEach var="mImgTrailer" items="${ mImgTrailerList }">
										<c:if test="${ mImgTrailer.image eq 'N' }">
											<p>
												<a href="/upload/${ mImgTrailer.uploadpath }/${ mImgTrailer.uuid }_${ mImgTrailer.filename }">
													<video src="/upload/${ mImgTrailer.uploadpath }/s_${ mImgTrailer.uuid }_${ mImgTrailer.filename }"  width='400' controls autoplay>비디오</video>
												</a>
											</p>
										</c:if>
								</c:forEach>
							</c:if>
							</td>
						</tr>
                        <tr>
                            <th><label for="mScore">영화평점</label></th>
                            <td>${ movieVo.MScore }점</td>
                        </tr>
                        <tr>
                            <th><label for="mRate">영화예매율</label></th>
                            <td>${ movieVo.MRate }</td>
                        </tr>
                        <tr>
                            <th><label for="MGenre">영화장르</label></th>
                            <td>${ movieVo.MGenre }</td>
                        </tr>
                        <tr>
                            <th><label for="mRuntime">상영시간</label></th>
                            <td>${ movieVo.MRuntime }</td>
                        </tr>
                        <tr>
                            <th><label for="mDirector">감독</label></th>
                            <td>${ movieVo.MDirector }</td>
                        </tr>
                        <tr>
                            <th><label for="mActor">배우</label></th>
                            <td>${ movieVo.MActor }</td>
                        </tr>
						<tr>
							<th><label for="mStory">줄거리</label></th>
							<td><textarea name="mStory" cols="60" rows="10" readonly>${ movieVo.MStory }</textarea></td>
						</tr>
                    </tr>
                </Table>

                <div class="btns">
                	<c:if test="${ not empty id }">
						<%-- 로그인 아이디와 글작성자 아이디가 같을때 --%>
						<input type="button" value="수정" class="btn" onclick="location.href = '/movieNotice/modify?num=${ movieVo.MNum }&pageNum=${ pageNum }'">
						<input type="button" value="삭제" class="btn" onclick="remove()">
					</c:if>
					<input type="button" value="목록보기" class="btn" onclick="location.href = '/movieNotice/list?pageNum=${ pageNum }'">
                </div>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
	// 게시글 삭제 함수
	function remove() {
		let isDelete = confirm('${ movieVo.MNum }번 글을 정말 삭제하시겠습니까?');
		if (isDelete) {
			location.href = '/movieNotice/delete?num=${ movieVo.MNum }&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>





