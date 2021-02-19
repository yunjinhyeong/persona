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
                            <th><label for="num">번호</label></th>
                            <td>${ watchMovieVo.num }</td>
                        </tr>
                        <tr>
                            <th><label for="name">영화제목</label></th>
                            <td>${ watchMovieVo.name }</td>
                        </tr>
                        <tr>
                            <th><label for="area">상영지역</label></th>
                            <td>${ watchMovieVo.area }</td>
                        </tr>
                        <tr>
                            <th><label for="date">상영일자</label></th>
                            <td>${ watchMovieVo.date }</td>
                        </tr>
                        <tr>
                            <th><label for="theater">상영관</label></th>
                            <td>${ watchMovieVo.theater }</td>
                        </tr>
                        <tr>
                            <th><label for="regDate">등록일자</label></th>
                            <td>${ watchMovieVo.regDate }</td>
                        </tr>
                    </tr>
                </Table>

                <div class="btns">
                	<c:if test="${ not empty id }">
						<%-- 로그인 아이디와 글작성자 아이디가 같을때 --%>
						<input type="button" value="수정" class="btn" onclick="location.href = '/watchMovie/modify?num=${ watchMovieVo.num }&pageNum=${ pageNum }'">
						<input type="button" value="삭제" class="btn" onclick="remove()">
					</c:if>
					<input type="button" value="목록보기" class="btn" onclick="location.href = '/watchMovie/list?pageNum=${ pageNum }'">
                </div>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
	// 게시글 삭제 함수
	function remove() {
		let isDelete = confirm('${ watchMovieVo.num }번, ${watchMovieVo.name} 글을 정말 삭제하시겠습니까?');
		if (isDelete) {
			location.href = '/watchMovie/delete?num=${ watchMovieVo.num }&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>





