<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>

<link href="/css/mypage.css" rel="stylesheet">
<link href="/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<jsp:include page="/WEB-INF/views/include/head.jsp" />
</head>
<body>

	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />


	<div class="aaa">

		<div class="bbb">
		<form  action="/member/modify" method="post" enctype="multipart/form-data" name="frm" id="uploadForm">
			<table class="table table-striped" style="width: 600px" align: center>
				<tr>
					<td> 프로필 수정하기</td>
				</tr>
				<tr>
					<td width="200px">사용자 ID</td>
					<td width="400px"><input type="text" name="id" value="${memberVo.id }"readonly></td>
				</tr>
				<tr>
					<td width="200px">사용자 PW</td>
					<td width="400px" ><span><input type="password" id="key" name="passwd" value="${memberVo.passwd}" /></span> <span id = "keyShow">비밀번호 보이기</span></td>
				</tr>
				<tr>
					<td width="200px">사용자 이름</td>
					<td width="400px"><input type="text" name="name"value="${memberVo.name}" /></td>
				</tr>
				<tr>
					<td width="200px">생년월일</td>
					<td width="400px"><input type="number" name="yy" value ="${memberVo.yy}" readonly/> 년 <input type="number" name="mm" value ="${memberVo.mm}" readonly/>월
						<input type="number" name="dd" value ="${memberVo.dd}" readonly/>일</td>
				</tr>
				<tr>
					<td width="200px">성별</td>
					<td width="400px"><input type="text" name="gender" value="${memberVo.gender}"></td>
				</tr>
				<tr>
					<td width="200px">이메일</td>
					<td width="400px"><input type="text" name="email" value="${memberVo.email}"></td>
				</tr>
				<tr>
					<td width="200px">사진</td>
					<td width="400px">
			            <div id="oldFileBox">

						<c:forEach var="pattach" items="${ pattachList }">
							<input type="hidden" name="oldfile" value="${ pattach.num }">
							<div>
								${ pattach.filename }
								<span class="delete-oldfile">X</span>
							</div>
						</c:forEach>

					</div>
					<div id="newFileBox"></div>
					<input type="button" id="btnAddFile" value="첨부파일 추가">


			            <span style="background-color : yellow" id="register">등록</span>
         			</td>
				</tr>
			</table>
			<input type="submit" value="수정하기"  class="btnUpdate"/>
			<input type="submit" value="탈퇴하기" formaction="/member/delete">
			</form>


		</div>
	</div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script src="/script/jquery-3.5.1.js"></script>
<script>
// $("#register").on("click",function(){

// 	window.open('/member/addProfile?id=${memberVo.getId()}','aa','width=500,height=500');
// })

$(function(){

	$("#register").on('click', function(){
		uploadFile();
	});
});


function uploadFile(){
	var form = $('#uploadForm')[0];
	var formData = new FormData(form);

	$.ajax({
		url:'/member/addProfile',
		type : 'post',
		data : formData,
		contentType : false,
		processData : false
	}).done(function(data){
		callback(data);
	});
}


$("#keyShow").on("click", function() {
	  if ($("#key").attr("type") == "password") {
	    $("#key").attr("type", "text");
	    $($(this)).text("비밀번호 숨기기");
	  } else {
	    $("#key").attr("type", "password");
	    $($(this)).text("비밀번호 보이기");
	  }
	});


const maxFileCount = 1;  // 최대 첨부파일 갯수
var fileCount = ${ fn:length(pattachList) };  // 현재 첨부된 파일 갯수

//[첨부파일 추가] 버튼을 클릭할 때
$('#btnAddFile').click(function () {

	if (fileCount >= maxFileCount) {
		alert('첨부파일은 최대 1개 까지만 가능합니다.')
		return;
	}

	// 백틱 문자열 안에서 변수값을 표현할때는
	// \${}로 표현함
	var str = `
		<div>
			<input type="file" name="filename">
			<span class="delete-addfile">X</span>
		</div>
	`;

	$('div#newFileBox').append(str);

	fileCount++;
});

//동적 이벤트 바인딩. 이벤트 바인딩 작업을 이미 존재하는 요소에게 위임하기.
//이미 존재하는 div#newFileBox 요소에게
//안쪽에 새로운 span.delete-addfile가 들어오면 클릭이벤트 연결하기
$('div#newFileBox').on('click', 'span.delete-addfile', function () {
	$(this).parent().remove();
	fileCount--;
});

//정적 이벤트 바인딩. 기존 첨부파일에 삭제버튼을 눌렀을때
$('span.delete-oldfile').on('click', function () {
	// 현재 클릭한 요소의 직계부모(parent)의 앞(prev) 요소
	$(this).parent().prev().prop('name', 'delfile');
	// 현재 클릭한 요소의 직계부모(parent)를 삭제. 현재요소안에 자식요소도 모두 삭제됨
	$(this).parent().remove();
	fileCount--;
});


</script>

</body>
</html>