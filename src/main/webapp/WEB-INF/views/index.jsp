<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />

<link href="/css/Main.css" rel="stylesheet">
<!-- <link href="/css/event.css" rel="stylesheet"> -->
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script src="/script/s3Slider.js"></script>
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

<!-- 	메인 사진 세장만 추가 가능함 -->
	<section class="section">
	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02">
	<input type="radio" name="slide" id="slide03">
	<input type="radio" name="slide" id="slide04">
	<input type="radio" name="slide" id="slide05">
	<input type="radio" name="slide" id="slide06">
	<input type="radio" name="slide" id="slide07">
	<div class="slidewrap">
		<ul class="slidelist">
			<li>
				<a>
					<img src="/imgs/인터스텔라(1270).jpg">
				</a>
			</li>
			<li>
				<a>
					<img width="1000px" src="/imgs/남산의 부장들.jpg">
				</a>
			</li>
			<li>
				<a>
					<img width="1000px" src="/imgs/골든슬럼버.jpg">
				</a>
			</li>
			<li>
				<a>
					<img width="1000px" src="/imgs/램페이지.jpg">
				</a>
			</li>
			<li>
				<a>
					<img width="1000px" src="/imgs/말레피센트.jpg">
				</a>
			</li>
			<li>
				<a>
					<img width="1000px" src="/imgs/알라딘.jpg">
				</a>
			</li>
			<li>
				<a>
					<img width="1000px" src="/imgs/역린.png">
				</a>
			</li>
		</ul>

		<div class="slide-control">
			<div class="control01">
				<label for="slide07" class="left"></label>
				<label for="slide02" class="right"></label>
			</div>
			<div class="control02">
				<label for="slide01" class="left"></label>
				<label for="slide03" class="right"></label>
			</div>
			<div class="control03">
				<label for="slide02" class="left"></label>
				<label for="slide04" class="right"></label>
			</div>
			<div class="control04">
				<label for="slide03" class="left"></label>
				<label for="slide05" class="right"></label>
			</div>
			<div class="control05">
				<label for="slide04" class="left"></label>
				<label for="slide06" class="right"></label>
			</div>
			<div class="control06">
				<label for="slide05" class="left"></label>
				<label for="slide07" class="right"></label>
			</div>
			<div class="control07">
				<label for="slide06" class="left"></label>
				<label for="slide01" class="right"></label>
			</div>
		</div>
	</div>
	</section>

	<div class="main_content">
			<article class="article1">

			<div class="movie_box">
			<div class="sectionTitle">
			<h1>예매율 순위</h1>
			<a href="/movieNotice/nowList">더보기 ></a>
			</div>
			<hr>
				<c:set var="i" value="0" />
				<c:set var="j" value="5" />
<!-- 					메서드 자체가 초기 15개만 호출하는 메서드! -->
					<c:choose>
						<c:when test="${ not empty movieList }">
							<c:forEach var="movie" items="${ movieList }">
							<c:if test="${ i%j == 0 }">
					       		<div class="movie_content">
					       	</c:if>
								    <ul>
								    	<li>
								    		<p>
									    		<a href="/movieNotice/detail?num=${ movie.MNum }&pageNum=${ pageNum }&movieName=${movie.MName}">
													<img width='200' height='110' src="/upload/${ movie.uploadpath }/${ movie.uuid }_${ movie.filename }" >
												</a>
												<div id="rankNum">
												<p>
												<img width='40' height='40' src="/imgs/starn.png">
												</p>
												<p>
												<c:out value="${ i+1 }" /></p>
												</div>
											</p>
										</li>
								    	<li><a href="/movieNotice/detail?num=${ movie.MNum }&pageNum=${ pageNum }&movieName=${movie.MName}">${ movie.MName }</a></li>
								    	<li>예매율 <a>${ movie.MRate }%</a> | ⭐ ${ movie.MScore }</li>
							    	</ul>
					    	<c:if test="${ i%j == j-1 }">
					    		</div>
					     	</c:if>
					     	<c:set var="i" value="${ i+1 }" />
						    </c:forEach>
					    </c:when>
					    <c:otherwise>
							<ul>
								<li>등록된 영화 없음</li>
							</ul>
						</c:otherwise>
					</c:choose>
					</div>
					</article>
			</div>

	<article class="article2">

		<h1>전체 이벤트</h1>
		<hr>
		<hr>
		<div class="sectionTitle">
			<h2>영화</h2>
			<a href="/eventNotice/main/listMovie">더보기 ></a>
		</div>
		<hr>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventMovieList }">
					<c:forEach var="movie" items="${ eventMovieList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${movie.ENum}">
									<img  width='200' height='110' src="/upload/${ movie.uploadpath }/${ movie.uuid }_${ movie.filename }" width="600px">
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
		<hr>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventPremiereList }">
					<c:forEach var="premiere" items="${ eventPremiereList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${premiere.ENum}">
									<img  width='200' height='110' src="/upload/${ premiere.uploadpath }/${ premiere.uuid }_${ premiere.filename }" width="600px">
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
		<hr>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventHOTList }">
					<c:forEach var="hot" items="${ eventHOTList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${hot.ENum}">
									<img  width='200px' height='110px' src="/upload/${ hot.uploadpath }/${ hot.uuid }_${ hot.filename }" width="600px">
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
		<hr>
		<div class="items">
			<c:choose>
				<c:when test="${ not empty eventDiscountList }">
					<c:forEach var="discount" items="${ eventDiscountList }">
						<div class="oneItem">
							<div class="imgParent">
								<a href="/eventNotice/main/one?num=${discount.ENum}">
									<img  width='200px' height='110px' src="/upload/${ discount.uploadpath }/${ discount.uuid }_${ discount.filename }" width="600px">
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
		<%-- 이벤트 --%>

		<div class="noticeWrap">
		<div id="mainNotice">
		<h1><img alt="#" src="/imgs/확성기.png" width="50" height="37">공지사항</h1>
		<div id="more"><a id="more" href="/CS/CustomerNotice">더보기></a></div>
		</div>
		<hr>
		<div class="notice">
		<c:choose>
			<c:when test="${ not empty onlyNoticeList }">
				<ul class="rolling">
					<c:forEach var="notice" items="${ onlyNoticeList }">
						<li class="s3sliderImage">
							<a href="/CS/CustomerNotice">
								※ ${ notice.csSubject }
							</a>
						</li>
					</c:forEach>
				</ul>
					</c:when>

				<c:otherwise>
					<div>공지사항 없음</div>
				</c:otherwise>
			</c:choose>

		</div>
		<%--  공지사항 롤링 --%>
		</div>

		<img id="ad1" alt="" src="/imgs/eventImg.jpg">

	</article>



		<img alt="" src="/imgs/eventImg2.png">

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
$(document).ready(function(){
	var height =  $(".notice").height();
	var num = $(".rolling li").length;
	var max = height * num;
	var move = 0;
	function noticeRolling(){
		move += height;
		$(".rolling").animate({"top":-move},600,function(){
			if( move >= max ){
				$(this).css("top",0);
				move = 0;
			};
		});
	};
	noticeRollingOff = setInterval(noticeRolling,4000);
	$(".rolling").append($(".rolling li").first().clone());

	$(".rolling_stop").click(function(){
		clearInterval(noticeRollingOff);
	});
	$(".rolling_start").click(function(){
		noticeRollingOff = setInterval(noticeRolling,1000);
	});
});
</script>
</body>
</html>

