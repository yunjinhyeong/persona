<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<link href="/css/mypage.css" rel="stylesheet">
<link href="/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
</head>
<body>

	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />


	<div class="aaa">

		<div class="bbb">
		<form  action="/member/modify" method="post" name="frm" id="uploadForm">

			<div>

				<c:if test="${ not empty pattachList }">

					<c:forEach var="pattach" items="${pattachList }">
						<c:choose>
							<c:when test="${pattach.image eq 'I' }">
								<p style="width: 31% ;margin-left: 35%">
									<a href="/upload2/${pattach.uploadpath }/${pattach.uuid}_${pattach.filename }">
										<img class="img-circle" width='100px' alt="사진등록이 필요합니다" src="/upload2/${pattach.uploadpath }/${pattach.uuid }_${pattach.filename }" style="border: 1px solid #000;">
									</a>
								</p>
							</c:when>
						</c:choose>
					</c:forEach>
				</c:if>

			</div>

			<table class="table table-striped" style="width: 600px" align: center>
				<tr>
					<td width="200px">사용자 ID</td>
					<td width="400px">${memberVo.id}</td>
				</tr>
				<tr>
					<td width="200px">사용자 이름</td>
					<td width="400px">${memberVo.name}</td>
				</tr>
				<tr>
					<td width="200px">생년월일</td>
					<td width="400px">${memberVo.getYy()}년${memberVo.getMm()}월
						${memberVo.getDd()}일</td>
				</tr>
				<tr>
					<td width="200px">성별</td>
					<td width="400px">${memberVo.getGender()}</td>
				</tr>
				<tr>
					<td width="200px">이메일</td>
					<td width="400px">${memberVo.getEmail()}</td>
				</tr>
				<tr>
					<td width="200px">등급</td>
					<td width="400px">

                        <p style="width: 100px">
                        <c:choose>

                            <c:when test="${memberVo.getGrade() eq 'bronze'}">
                                <img width="100px" class="img-rounded" src="/imgs/bronze.jpg" alt="브론즈"/>
                            </c:when>

                            <c:when test="${memberVo.getGrade() eq 'silver'}">
                                <img width="100px" class="img-rounded" src="/imgs/silver.jpg" alt="실버"/>
                            </c:when>

                            <c:when test="${memberVo.getGrade() eq 'gold'}">
                                <img width="100px" class="img-rounded" src="/imgs/gold.jpg" alt="골드"/>
                            </c:when>

                            <c:when test="${memberVo.getGrade() eq 'vip'}">
                                <img width="100px" class="img-rounded" src="/imgs/platinum.jpg" alt="브론즈"/>
                            </c:when>

                        </c:choose>
                        </p>
                        </td>
				</tr>
			</table>

			</form>
			<input type="button" value="수정하러가기"  class="btnUpdate btn-info" onclick="location.href = '/member/modify?id=${memberVo.getId()}+&memberVo=+${memberVo}'"/>

		</div>
	</div>

	<div style="height: 200px;width:900px;margin-left: 360px; margin-top: 30px; margin-bottom: -137px" >

		<div >
            <h3><b>등급안내</b></h3>
            <div class="col-md-3" style="height: 200px"align="center">
                <div style="text-align: center" class="panel panel-success"><div class="panel-heading">결제 내역 5만원 이하<br><b class=" panel-title">BRONZE</b></div></div>

                <div style="width: 100px; height: 100px;margin-top: 10%; margin-right: 6px " align="center" class="panel-body">
                    <img width="100px" class="img-rounded" src="/imgs/bronze.jpg" alt="브론즈"/>
                </div>
            </div>
            <div class="col-md-3" style="height: 200px"align="center">
                <div style="text-align: center" class="panel panel-success"><div class="panel-heading">결제 내역 10만원 이하<br><b class=" panel-title">SILVER</b></div></div>
                <div style="width: 100px; height: 100px;margin-top: 10% " align="center">
                    <img width="100px" class="img-rounded" src="/imgs/silver.jpg" alt="실버"/>
                </div>
            </div>
            <div class="col-md-3" style=" height: 200px"align="center">
                <div style="text-align: center" class="panel panel-success"><div class="panel-heading">결제 내역 15만원 이하<br><b class=" panel-title">GOLD</b></div></div>
                <div style="width: 100px; height: 100px; margin-top: 10% " align="center">
                    <img width="100px" class="img-rounded" src="/imgs/gold.jpg" alt="골드"/>
                </div>
            </div>
            <div class="col-md-3" style="height: 200px"align="center">
                <div style="text-align: center" class="panel panel-success"><div class="panel-heading">결제 내역 15만원 초과<br><b class=" panel-title">VIP</b></div></div>
                <div style="width: 100px; height: 100px; margin-top: 10% " align="center">
                    <img width="100px" class="img-rounded" src="/imgs/platinum.jpg" alt="VIP"/>
                </div>
            </div>
		</div>
	</div>

	<div class="orderProduct">
		<h1>결제한내역</h1>
		<table>
			<tr>
				<th>주문번호</th>
				<th>상품명</th>
				<th>가격</th>
				<th>구성품</th>
				<th>갯수</th>
				<th>전체금액</th>
				<th>소비자ID</th>
				<th>결제일</th>
				<th>최종구입하기</th>
			</tr>
			<c:choose>
				<c:when test="${ not empty orderList }"><%-- ${ pageDto.count gt 0 } --%>

					<c:forEach var="product" items="${ orderList }">
						<tr>
							<td>${ product.num }</td>
							<td>${ product.name }</td>
							<td>${ product.price }</td>
							<td>${ product.content }</td>
							<td>${ product.count }</td>
							<td>${ product.total }</td>
							<td>${ product.id }</td>
							<td><fmt:formatDate value="${ product.regDate }" pattern="yyyy.MM.dd"/></td>
							<c:if test="${ SessionScope.id eq admin }">
								<td class="deleteBtn" onclick="remove(${ product.num })">최종구입완료</td>
							</c:if>
						</tr>
					</c:forEach>

				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9">결제한 상품없음</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>

	<div class="orderProduct">
		<h1>예매된 좌석</h1>
		<table>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>좌석번호</th>
				<th>지역</th>
				<th>날짜시간</th>
				<th>영화관</th>
				<th>예매한날짜</th>
				<th>최종구입하기</th>
			</tr>
			<c:choose>
				<c:when test="${ not empty rSeatList }"><%-- ${ pageDto.count gt 0 } --%>

					<c:forEach var="list" items="${ rSeatList }">
						<tr>
							<td>${ list.num }</td>
							<td>${ list.id }</td>
							<td>${ list.name }</td>
							<td>${ list.seat }</td>
							<td>${ list.area }</td>
							<td>${ list.date }</td>
							<td>${ list.theater }</td>
							<td><fmt:formatDate value="${ list.regDate }" pattern="yyyy.MM.dd"/></td>
							<td class="deleteBtn" onclick="removeR(${ list.num }, ${ list.seat })">최종구입완료</td>
						</tr>
					</c:forEach>

				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9">예매한 영화없음</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	
		<div class="orderProduct">
		<h1>회원님이 좋아하는 영화들</h1>
		<table>
			<tr>
				<th>관람등급</th>
				<th>제목</th>
				<th>평점</th>
				<th>예매율</th>
				<th>장르</th>
				<th>러닝타임</th>
				<th>감독</th>
				<th>배우</th>
				<th>찜</th>
			</tr>
			<c:choose>
				<c:when test="${ not empty likedMovieList }">

					<c:forEach var="movie" items="${ likedMovieList }">
						<tr>
							<td onclick="link(${ movie.MNum })">${ movie.MRank }</td>
							<td onclick="link(${ movie.MNum })">${ movie.MName }</td>
							<td onclick="link(${ movie.MNum })">${ movie.MScore }</td>
							<td onclick="link(${ movie.MNum })">${ movie.MRate }</td>
							<td onclick="link(${ movie.MNum })">${ movie.MGenre }</td>
							<td onclick="link(${ movie.MNum })">${ movie.MRuntime }</td>
							<td onclick="link(${ movie.MNum })">${ movie.MDirector }</td>
							<td onclick="link(${ movie.MNum })">${ movie.MActor }</td>																	
							<td><img id='like_img' src="/imgs/heart2.png" alt="" style="width: 25px; height: 25px;" onclick="like_func(${ movie.MNum })"></td>
						</tr>
					</c:forEach>

				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9">찜한 영화가 없습니당</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script src="/script/jquery-3.5.1.js"></script>
<script>

$("#keyShow").on("click", function() {
	  if ($("#key").attr("type") == "password") {
	    $("#key").attr("type", "text");
	    $($(this)).text("비밀번호 숨기기");
	  } else {
	    $("#key").attr("type", "password");
	    $($(this)).text("비밀번호 보이기");
	  }
	});

// 삭제 함수
function remove(num) {
	let isDelete = confirm('주문번호 '+num+' 를 최종구입 하십니까?');
	if (isDelete) {
		location.href = '/store/deleteProduct?num='+num+'&id=${memberVo.id}';
	}
}

function removeR(num, seat) {
	let isDelete = confirm('예매한 영화번호 '+num+' 을 최종구입 하십니까?');
	if (isDelete) {
		location.href = '/watchMovie/deleteSeat?num='+num+'&seat='+seat+'&id=${memberVo.id}';
	}
}

function like_func(mnum){

	let isCancel = confirm('해당 영화의 찜하기를 취소하시겠습니까?');

	if(isCancel){
	var datas = {
			movieNum: mnum,
			userId: '${ sessionScope.id }'
		}

				 $.ajax({
				 url: "/member/like",
				 type: "POST",
				 data : datas,
				 	success: function(data) {

				    	alert('"찜하기"가 취소되었습니다!');
				      
				    },
				    error: function(request, status, error){
				      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				    }
				  });
				setTimeout(function(){
					location.reload();
				},300);
	}

}

function link(mnum) {
	location.href = '/movieNotice/detail?num='+mnum;
}
</script>

</body>
</html>