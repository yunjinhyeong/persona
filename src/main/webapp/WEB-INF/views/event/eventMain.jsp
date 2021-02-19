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

		<h1>전체 이벤트</h1>

		<div class="sectionTitle">
			<h2>영화</h2>
			<a href="/eventNotice/main/listMovie">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventMovieList }">
					<c:forEach var="movie" items="${ eventMovieList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${movie.ENum}">
									<img width='200' src="/upload/${ movie.uploadpath }/${ movie.uuid }_${ movie.filename }" >
								</a>
							</div>
							<div class="eventInfo">
								<span>${ movie.ETitle }</span>
								<span>${ movie.startDate } ~ ${ movie.endDate }</span>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div>영화 이벤트 없음</div>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="sectionTitle">
			<h2>시사회/무대인사</h2>
			<a href="/eventNotice/main/listPremiere">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventPremiereList }">
					<c:forEach var="premiere" items="${ eventPremiereList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${premiere.ENum}">
									<img  width='200' src="/upload/${ premiere.uploadpath }/${ premiere.uuid }_${ premiere.filename }" >
								</a>
							</div>
							<div class="eventInfo">
								<span>${ premiere.ETitle }</span>
								<span>${ premiere.startDate } ~ ${ premiere.endDate }</span>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div>시사회/무대인사 이벤트 없음</div>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="sectionTitle">
			<h2>HOT</h2>
			<a href="/eventNotice/main/listHOT">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventHOTList }">
					<c:forEach var="hot" items="${ eventHOTList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${hot.ENum}">
									<img  width='200' src="/upload/${ hot.uploadpath }/${ hot.uuid }_${ hot.filename }" >
								</a>
							</div>
							<div class="eventInfo">
								<span>${ hot.ETitle }</span>
								<span>${ hot.startDate } ~ ${ hot.endDate }</span>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div>HOT 이벤트 없음</div>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="sectionTitle">
			<h2>제휴할인</h2>
			<a href="/eventNotice/main/listDiscount">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventDiscountList }">
					<c:forEach var="discount" items="${ eventDiscountList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${discount.ENum}">
									<img  width='200' src="/upload/${ discount.uploadpath }/${ discount.uuid }_${ discount.filename }">
								</a>
							</div>
							<div class="eventInfo">
								<span>${ discount.ETitle }</span>
								<span>${ discount.startDate } ~ ${ discount.endDate }</span>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div>제휴할인 이벤트 없음</div>
				</c:otherwise>
			</c:choose>
		</div>

		<img alt="" src="/imgs/eventImg.jpg">


	</article>

	<img alt="" src="/imgs/eventImg2.png">

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

