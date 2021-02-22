<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/event.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<article>

		<div>
			<c:choose>
				<c:when test="${ not empty eventByNum }">
				       	<div>
				       		<div>
								<div class="imgDetail">
									<a href="/upload/${ eventByNum.uploadpath }/${ eventByNum.uuid }_${ eventByNum.filename }">
										<img class="img-rounded" width='200' src="/upload/${ eventByNum.uploadpath }/${ eventByNum.uuid }_${ eventByNum.filename }">
									</a>
								</div>
							</div>
						</div>
				</c:when>
				<c:otherwise>
					<div>이미지 없음</div>
				</c:otherwise>
			</c:choose>
			<input type="button" value="되돌아가기" class="btn" onclick='history.back();'>
		</div>

		<img alt="" src="/imgs/eventDetail.png">


	</article>

	<img alt="" src="/imgs/moreimg.png">

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

