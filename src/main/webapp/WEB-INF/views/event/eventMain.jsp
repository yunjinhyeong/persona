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
<!-- <link href="/css/bootstrap.css" rel="stylesheet" type="text/css"> -->
<!-- <link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css"> -->
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<article>

		<h1>전체 이벤트</h1>

		<div class="sectionTitle">
			<h2>영화</h2>
			<a href="/eventNotice/main/listMovie" class="btn btn-dark" style="height:30px">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventMovieList }">
					<c:forEach var="movie" items="${ eventMovieList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${movie.ENum}">
									<img style="border-radius:7px" width='200' src="/upload/${ movie.uploadpath }/${ movie.uuid }_${ movie.filename }" >
								</a>
							</div>
							<div class="eventInfo">
								<span class="text-info"><small>${ movie.ETitle }</small></span>
								<span class="text-danger"><small>${ movie.startDate } ~ ${ movie.endDate }</small></span>
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
			<a href="/eventNotice/main/listPremiere" class="btn btn-dark" style="height:30px">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventPremiereList }">
					<c:forEach var="premiere" items="${ eventPremiereList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${premiere.ENum}">
									<img style="border-radius:7px" width='200' src="/upload/${ premiere.uploadpath }/${ premiere.uuid }_${ premiere.filename }" >
								</a>
							</div>
							<div class="eventInfo">
								<span class="text-info"><small>${ premiere.ETitle }</small></span>
								<span class="text-danger"><small>${ premiere.startDate } ~ ${ premiere.endDate }</small></span>
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
			<a href="/eventNotice/main/listHOT" class="btn btn-dark" style="height:30px">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventHOTList }">
					<c:forEach var="hot" items="${ eventHOTList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${hot.ENum}">
									<img style="border-radius:7px" width='200' src="/upload/${ hot.uploadpath }/${ hot.uuid }_${ hot.filename }" >
								</a>
							</div>
							<div class="eventInfo">
								<span class="text-info"><small>${ hot.ETitle }</small></span>
								<span class="text-danger"><small>${ hot.startDate } ~ ${ hot.endDate }</small></span>
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
			<a href="/eventNotice/main/listDiscount" class="btn btn-dark" style="height:30px">더보기 ></a>
		</div>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventDiscountList }">
					<c:forEach var="discount" items="${ eventDiscountList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${discount.ENum}">
									<img style="border-radius:7px" width='200' src="/upload/${ discount.uploadpath }/${ discount.uuid }_${ discount.filename }">
								</a>
							</div>
							<div class="eventInfo">
								<span class="text-info"><small>${ discount.ETitle }</small></span>
								<span class="text-danger"><small>${ discount.startDate } ~ ${ discount.endDate }</small></span>
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

