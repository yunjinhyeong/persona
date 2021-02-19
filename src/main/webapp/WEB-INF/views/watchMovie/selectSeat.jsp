<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/selectMovie.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<div id="wrap">
		<div class="wrap">
			<div id="side1">1. 상영시간</div>
			<div id="side2"><label class="sideSelect">2. 인원/좌석</label></div>
		</div>
		<div id="seatHeader">인원/좌석 선택</div>
		<div class="num">성인
			<select name="adult" id="adult">
				<option value="0">0명</option>
	        	<option value="1">1명</option>
	        	<option value="2">2명</option>
	        	<option value="3">3명</option>
	        	<option value="4">4명</option>
	        	<option value="5">5명</option>
        	</select>
        	&nbsp;&nbsp;&nbsp;청소년
			<select name="junior" id="junior">
				<option value="0">0명</option>
	        	<option value="1">1명</option>
	        	<option value="2">2명</option>
	        	<option value="3">3명</option>
	        	<option value="4">4명</option>
	        	<option value="5">5명</option>
        	</select>
            &nbsp;&nbsp;&nbsp;어린이
			<select name="child" id="child">
				<option value="0">0명</option>
	        	<option value="1">1명</option>
	        	<option value="2">2명</option>
	        	<option value="3">3명</option>
	        	<option value="4">4명</option>
	        	<option value="5">5명</option>
        	</select>
		</div>
		<div class="screen">SCREEN</div>
		<form action="/watchMovie/kakaoPay" method="post" id="frm">
			<input type="hidden" name="noNum" value="${ noNum }">
			<input type="hidden" name="id" value="${ id }">
			<input type="hidden" name="name" value="${ name }">
			<input type="hidden" name="area" value="${ area1 }">
			<input type="hidden" name="date" value=" ${ date1 } " />
			<input type="hidden" name="theater" value=" ${ theater1 } " />
			<input type="hidden" class="finalPrice1" name="price">

			<div id="SeatChoice">
			</div>
			<div class="priceLabel">
				<span>어른:8천원&nbsp;&nbsp;&nbsp;</span><span>청소년:5천원&nbsp;&nbsp;&nbsp;</span><span>어린이:3천원&nbsp;&nbsp;&nbsp;</span>
			</div>

			<div class="finalBtns">
				<label>최종 결제금액</label><input class="finalPrice" readonly type="text"><label>원</label>
				<input class="finalPrice" type="button" id="subBtn" value="최종결제하기">
			</div>
		</form>

	</div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>

var adult = document.getElementById("adult");
var juniorNum = document.getElementById("juniorNum");
var child = document.getElementById("child");
var adultNum=0;
var juniorNum=0;
var childNum=0;
var total=0;	// select들의 토탈
var seatTotal=0;	// 선택한 좌석의 토탈
var totalPrice=0;

var noNum = '${noNum}';

	$.ajax({
		url: '/watchMovie/createSeat',
		data: {
			noNum:noNum,
		},
		method: 'get',
		dataType :'json',
		success: function (response) {
			for(i=0; i<50 ; i++){
				console.log("보내짐 = "+response[i]+"");
				if (response[i]) {
					var html = '<input type="text" class="oneSeat" readonly id="'+i+'" value="'+i+'">';
					$('#SeatChoice').append(html);
				} else {
					var html = '<input type="text" disabled id="'+i+'" value="'+i+'">';
					$('#SeatChoice').append(html);
				}
			}

		}
	});
	$('div#SeatChoice').on('click', 'input.oneSeat', function () {
		if($(this).hasClass("add")){
			$(this).removeClass("add");
			$(this).removeAttr( 'name', 'seatId' );
			seatTotal--;
		} else {
			if(total<=seatTotal) {
				alert('좌석은 총 '+seatTotal+'개만 선택가능합니다.');
				return;
			}
			$(this).addClass("add");
			$(this).attr( 'name', 'seatId' );
			seatTotal++;
		}
		console.log('seatTotal = '+seatTotal);
		console.log('adultNum = '+adultNum+'juniorNum = '+juniorNum+'childNum = '+childNum);
	});

	$("#adult").change(function(){
		total-=Number(adultNum);
		totalPrice=totalPrice-Number(adultNum)*8000;
		adultNum = Number(adult.options[adult.selectedIndex].value);
		total+=Number(adultNum);
		totalPrice=totalPrice+Number(adultNum)*8000;
		lastPrice();
		console.log('total = '+total);
	});
	$("#junior").change(function(){
		total-=Number(juniorNum);
		totalPrice=totalPrice-Number(juniorNum)*5000;
		juniorNum = Number(junior.options[junior.selectedIndex].value);
		total+=Number(juniorNum);
		totalPrice=totalPrice+Number(juniorNum)*5000;
		lastPrice();
		console.log('total = '+total);
	});
	$("#child").change(function(){
		total-=Number(childNum);
		totalPrice=totalPrice-Number(childNum)*5000;
		childNum = Number(child.options[child.selectedIndex].value);
		total+=Number(childNum);
		totalPrice=totalPrice+Number(childNum)*5000;
		lastPrice();
		console.log('total = '+total);
	});

	function lastPrice() {
		document.querySelector(".finalPrice").value = totalPrice;
		document.querySelector(".finalPrice1").value = totalPrice;
	}
	window.onload=function() {
		document.querySelector('#subBtn').onclick = function() {
			if(seatTotal!=total) {
				alert('예약하겠다는 좌석수와 선택한 좌석수가 일치하지 않습니다.');
				return;
			}
			let isSeat = confirm('이대로 결제하시겠습니까?');
			if (isSeat) {
				document.getElementById('frm').submit();
			}

		}
	}
</script>
</body>
</html>