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
                            <th><label for="CKinds">카드종류</label></th>
                            <td>${ cardVo.CKinds }</td>
                        </tr>
                    	<tr>
                            <th><label for="CNum">카드번호</label></th>
                            <td>${ cardVo.CNum }</td>
                        </tr>
                        <tr>
                            <th><label for="CName">카드이름</label></th>
                            <td>${ cardVo.CName }</td>
                        </tr>
                        <tr>
							<th><label for="MImg">카드이미지</label></th>

							<td><c:if test="${ not empty cardInfoVo }">
									<p>
										<a href="/upload/${ cardInfoVo.uploadpath }/${ cardInfoVo.uuid }_${ cardInfoVo.filename }">
											<img  width='200' src="/upload4/${ cardInfoVo.uploadpath }/${ cardInfoVo.uuid }_${ cardInfoVo.filename }" >
										</a>
									</p>
							</c:if>
							</td>
						</tr>
                        <tr>
                            <th><label for="CSale">할인종류</label></th>
                            <td>${ cardVo.CSale }</td>
                        </tr>
                        <tr>
                            <th><label for="COnoff">온/오프라인</label></th>
                            <td>${ cardVo.COnoff }</td>
                        </tr>
                        <tr>
                            <th><label for="CDiscount">할인금액</label></th>
                            <td>${ cardVo.CDiscount }</td>
                        </tr>
                    </tr>
                </Table>

                <div class="btns">
                	<c:if test="${ not empty id }">
						<%-- 로그인 아이디와 글작성자 아이디가 같을때 --%>
						<input type="button" value="수정" class="btn" onclick="location.href = '/saleNotice/modify?num=${ cardVo.CNum }&pageNum=${ pageNum }'">
						<input type="button" value="삭제" class="btn" onclick="remove()">
					</c:if>
					<input type="button" value="목록보기" class="btn" onclick="location.href = '/saleNotice/list?pageNum=${ pageNum }'">
                </div>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
	// 게시글 삭제 함수
	function remove() {
		let isDelete = confirm('${ cardVo.CNum }번 글을 정말 삭제하시겠습니까?');
		if (isDelete) {
			location.href = '/saleNotice/delete?num=${ cardVo.CNum }&pageNum=${ pageNum }';
		}
	}
</script>
</body>
</html>





