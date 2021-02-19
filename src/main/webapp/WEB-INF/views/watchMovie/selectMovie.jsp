<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<div id="side1"><label class="sideSelect">1. 상영시간</label></div>
			<div id="side2">2. 인원/좌석</div>
			<input type="hidden" name="id" id="id" value="${ id }">
		</div>
        <div id="header1">영화관</div>
        <div id="header2">상영영화</div>
        <div id="header3">날짜</div>
        <div id="nav1">지역</div>
        <div id="menuBar">
        	<select name="rule">
	        	<option value="예매순">예매순</option>
	        	<option value="평점순">평점순</option>
        	</select>
        </div>
         <div id="nav3">영화상영날짜</div>
        <div class="choice">
	        <div id="contents1">
	        	<ul class="province">
	        		<li><input class="area" value="서울"></li>
	        		<li><input class="area" value="부산"></li>
	        		<li><input class="area" value="대구"></li>
	        		<li><input class="area" value="인천"></li>
	        		<li><input class="area" value="광주"></li>
	        		<li><input class="area" value="대전"></li>
	        		<li><input class="area" value="울산"></li>
	        	</ul>
	        </div>
	        <div id="contents3"></div>
	        <div id="contents4"></div>
        </div>
    </div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
var farea;
var fname;
var fdate;
var ftheater;
var id;

var id = document.getElementById("id");
var id1 = id.value;

	$('.area').click(function() {
		$('#contents3 *').remove();
		$('#contents4 *').remove();
		var area = $(this).val();
		farea = $(this).val();
		var rule = $('select[name="rule"]').val();
		$('.area').css("color","#fff");
		$(this).css("color","#99CCCC");
		console.log(area);
		console.log( "a" +rule);
		console.log(id1)
			$.ajax({
				url: '/watchMovie/getMovieName',
				data: {
						area:area,
						rule:rule,
						id:id1,
				},
				method: 'get',
				success: function (response) {
					console.log(response);
					for(i=0; i<response.length; i++){
						var html = '<input class="oneMovie" value="'+response[i]+'">';
						$('#contents3').append(html+"<br>");
					}
				}

			});
	});

	$('div#contents3').on('click', 'input.oneMovie', function () {
		$('#contents4 *').remove();
		$('.oneMovie').css("color","#fff");
		var name = $(this).val();
		fname = $(this).val();
		area = farea;
		$(this).css("color","#99CCCC");
		console.log('name = ' + name);
		console.log('id = ' + id1);
			$.ajax({
				url: '/watchMovie/getMovieDate',
				data: {
					area:area,
					name:name,
					id:id1,
				},
				method: 'get',
				success: function (response) {
					console.log(response);
					for(i=0; i<response.length; i++){
						var html = '<div class="datetheater"><input class="oneTheater" value="'+response[i].theater+'">';
						html += '<input class="oneDate" value="'+response[i].date+'"></div>';
						$('#contents4').append(html+"<br>");
					}
				}
			});
	});
	$('div#contents4').on('click', 'input.oneDate', function () {
		$('.oneDate').css("color","#fff");
		$('.oneTheater').css("color","#fff");
		var date = $(this).val();
		fdate = $(this).val();
		ftheater = $(this).prev().val();
		$(this).css("color","#99CCCC");
		$(this).prev().css("color","#99CCCC");
		console.log('farea = ' + farea);
		console.log('fname = ' + fname);
		console.log('fdate = ' + fdate);
		console.log('ftheater = ' + ftheater);
		goSeat();
	});
	var userId = '${ sessionScope.id }';
	function goSeat() {
		
		if(!userId) {
			alert('로그인하십시오');
			history.back();
			return;			
		}		
		let isSeat = confirm('좌석예약페이지로 이동하시겠습니까?');
		if (isSeat) {
			location.href = '/watchMovie/goSeat?area='+farea+'&name='+fname+'&date='+fdate+'&theater='+ftheater;
		}
		
	}
</script>
</body>
</html>