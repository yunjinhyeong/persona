<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/mypage1.css" rel="stylesheet">
<!-- <link href="/css/bootstrap.css" rel="stylesheet" type="text/css"> -->
<!-- <link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css"> -->
</head>
<body>

	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />


	<div class="aaa">

		<div class="bbb">
		<form  action="/member/modify" method="post" name="frm" id="uploadForm">
			<table class="table table-striped" style="width: 600px; border:1px solid; border-collapse: collapse;" align: center>
				<tr>
					<td width="200px">상품 번호</td>
					<td width="400px">${productVo.num}</td>
				</tr>
				<tr>
					<td width="200px">상품 이름</td>
					<td width="400px">${productVo.name}</td>
				</tr>
				<tr>
					<td width="200px">상품 구성</td>
					<td width="400px">${productVo.content }</td>
				</tr>
				<tr>
					<td width="200px">작성자</td>
					<td width="400px">${productVo.id}</td>
				</tr>
				<tr>
					<td width="200px">가격</td>
					<td width="400px">${productVo.price}</td>
				</tr>
				<tr>
					<td width="200px">사진</td>
					<td width="400px">
						<c:if test="${ not empty sattachList }">

						<c:forEach var="sattach" items="${sattachList }">
							<c:choose>
							<c:when test="${sattach.image eq 'I' }">
								<p>
									<a href="/upload3/${sattach.uploadpath }/${sattach.uuid}_${sattach.filename }">
										<img alt="사진등록이 필요합니다" src="/upload3/${sattach.uploadpath }/${sattach.uuid }_${sattach.filename }">
									</a>
								</p>
							</c:when>
							</c:choose>
						</c:forEach>
						</c:if>

         			</td>
				</tr>
			</table>

			</form>

			<input type="button" value="수정하러가기"  class="btnUpdate" onclick="location.href = '/store/modify?pname=${productVo.name}&id=${productVo.id}&pageNum=${pageNum} '"/>
			<input type="button" value="목록으로" class="btnList" onclick="location.href = '/store/list?pageNum=${pageNum}'"/>

		</div>
	</div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script src="/script/jquery-3.5.1.js"></script>
<script>
// $("#register").on("click",function(){

// 	window.open('/member/addProfile?id=${memberVo.getId()}','aa','width=500,height=500');
// })

// $(function(){

// 	$("#register").on('click', function(){
// 		uploadFile();
// 	});
// });


// function uploadFile(){
// 	var form = $('#uploadForm')[0];
// 	var formData = new FormData(form);

// 	$.ajax({
// 		url:'/member/addProfile?id=${memberVo.getId()}',
// 		type : 'post',
// 		data : formData,
// 		contentType : false,
// 		processData : false
// 	}).done(function(data){
// 		callback(data);
// 	});
// }


$("#keyShow").on("click", function() {
	  if ($("#key").attr("type") == "password") {
	    $("#key").attr("type", "text");
	    $($(this)).text("비밀번호 숨기기");
	  } else {
	    $("#key").attr("type", "password");
	    $($(this)).text("비밀번호 보이기");
	  }
	});

</script>

</body>
</html>