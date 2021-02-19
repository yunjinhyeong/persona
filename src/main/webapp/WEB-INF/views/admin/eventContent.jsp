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
                            <th><label for="ENum">번호</label></th>
                            <td>${ eventVo.ENum }</td>
                        </tr>
                        <tr>
                            <th><label for="ESection">섹션</label></th>
                            <td>${ eventVo.ESection }</td>
                        </tr>
                        <tr>
                            <th><label for="ETitle">제목</label></th>
                            <td>${ eventVo.ETitle }</td>
                        </tr>                   
                        <tr>
                            <th><label for="startDate">이벤트시작일자</label></th>
                            <td>${ eventVo.startDate }</td>
                        </tr>
                        <tr>
                            <th><label for="endDate">이벤트종료일자</label></th>
                            <td>${ eventVo.endDate }</td>
                        </tr>
                        <tr>
							<th><label for="EImg">포스트</label></th>
							
							<td><c:if test="${ not empty eventPosterList }">
								<c:forEach var="eventPoster" items="${ eventPosterList }">
									<p>
										<a href="/upload/${ eventPoster.uploadpath }/${ eventPoster.uuid }_${ eventPoster.filename }">
											<img  width='400' src="/upload/${ eventPoster.uploadpath }/${ eventPoster.uuid }_${ eventPoster.filename }" width="600px">
										</a>
									</p>
								</c:forEach>
							</c:if>
							</td>
						</tr>                     
                    </tr>
                </Table>
            
                <div class="btns">
                	<c:if test="${ not empty id }">
						<%-- 로그인 아이디와 글작성자 아이디가 같을때 --%>
						<input type="button" value="수정" class="btn" onclick="location.href = '/eventNotice/modify?num=${ eventVo.ENum }&pageNum=${ pageNum }'">
						<input type="button" value="삭제" class="btn" onclick="remove()">
					</c:if>
					<input type="button" value="목록보기" class="btn" onclick="location.href = '/eventNotice/list?pageNum=${ pageNum }'">                	
                </div>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
	// 게시글 삭제 함수
	function remove() {
		let isDelete = confirm('${ eventVo.ENum }번 글을 정말 삭제하시겠습니까?');
		if (isDelete) {
			location.href = '/eventNotice/delete?num=${ eventVo.ENum }&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>   





    