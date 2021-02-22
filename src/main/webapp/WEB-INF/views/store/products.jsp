<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products!!</title>

<style>
</style>


<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />


<link href="/css/mypage.css" rel="stylesheet">
<link rel="stylesheet" href="/css/products.css" />
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<div style="height: 200px"></div>

<!-- 	<div id="sticky"> -->
<!-- 		<ul id="as"> -->
<!-- 			<li id="asd">베스트</li> -->
<!-- 			<li id="asd">관람권</li> -->
<!-- 			<li id="asd">스낵음료</li> -->
<!-- 			<li class="slider"></li> -->
<!-- 		</ul> -->
<!-- 	</div> -->

<img alt="" src="/imgs/store.png" style="margin-top: -81px ">

	<div class="product">

		<div class="wrapper">

		<c:choose>
			<c:when test="${not empty productList }">
				<c:forEach var="product" items="${productList }">
					<div>
						<a href="/store/buyItem?num=${product.num}">
							<img class="div1" src="/upload3/${product.uploadpath }/${product.uuid}_${product.filename}">
						</a>
						<div class="div2">
							<div class="div3"> ${product.name }</div>
							<div class="div4 " style="font-size:10pt; color:gray"> ${product.content }</div>
							<label class="input">${product.price }원</label>
						</div>
					</div>

				</c:forEach>
			</c:when>

		</c:choose>

<!-- 			<div> -->
<!-- 				<div class="div1">asd</div> -->
<!-- 				<div class="div2"> -->

<!-- 					<div class="div3">제품이름</div> -->
<!-- 					<div class="div4">제품구성</div> -->
<!-- 					<input type="text" class="input"> </input><em>원</em> -->

<!-- 				</div> -->
<!-- 			</div> -->

<!-- 			<div> -->
<!-- 				<div class="div1">asd</div> -->
<!-- 				<div class="div2"> -->

<!-- 					<div class="div3">제품이름</div> -->
<!-- 					<div class="div4">제품구성</div> -->
<!-- 					<input type="text" class="input"> </input><em>원</em> -->

<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div>3</div> -->
<!-- 			<div>4</div> -->
<!-- 			<div>5</div> -->
<!-- 			<div>6</div> -->

		</div>
	</div>






	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script src="/script/jquery-3.5.1.js"></script>

	<script>
		$("ul li")
				.click(
						function(e) {

							// make sure we cannot click the slider
							if ($(this).hasClass('slider')) {
								return;
							}

							/* Add the slider movement */

							// what tab was pressed
							var whatTab = $(this).index();

							// Work out how far the slider needs to go
							var howFar = 160 * whatTab;

							$(".slider").css({
								left : howFar + "px"
							});

							/* Add the ripple */

							// Remove olds ones
							$(".ripple").remove();

							// Setup
							var posX = $(this).offset().left, posY = $(this)
									.offset().top, buttonWidth = $(this)
									.width(), buttonHeight = $(this).height();

							// Add the element
							$(this).prepend("<span class='ripple'></span>");

							// Make it round!
							if (buttonWidth >= buttonHeight) {
								buttonHeight = buttonWidth;
							} else {
								buttonWidth = buttonHeight;
							}

							// Get the center of the element
							var x = e.pageX - posX - buttonWidth / 2;
							var y = e.pageY - posY - buttonHeight / 2;

							// Add the ripples CSS and start the animation
							$(".ripple").css({
								width : buttonWidth,
								height : buttonHeight,
								top : y + 'px',
								left : x + 'px'
							}).addClass("rippleEffect");
						});
	</script>
</body>
</html>