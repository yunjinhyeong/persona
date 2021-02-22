<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/fileNotice.css" rel="stylesheet">
<link href="/css/sidebarForAdmin.css" rel="stylesheet">
<style>
body {
	background:url(/imgs/ForChart.jpg)no-repeat center center;
    background-size: cover;
}
</style>
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
	<div class="wrapper">
	<%-- sidebar 영역 --%>
	<jsp:include page="/WEB-INF/views/include/sidebarForAdmin.jsp" />
		<div class="main_content">
			<article>

				<div id="chart1" style="width: 900px; height: 500px;"></div>
				<div id="chart2" style="width: 900px; height: 500px;"></div>
				<div id="chart3" style="width: 900px; height: 500px;"></div>
				<div id="chart4" style="width: 900px; height: 500px;"></div>
				<div id="chart5" style="width: 900px; height: 500px;"></div>
				<div id="chart6" style="width: 900px; height: 500px;"></div>
				<div id="chart7" style="width: 900px; height: 500px;"></div>

			</article>
		</div>
	</div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>

google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(function () {
	$.ajax({
		url: '/chart/getNameTheatherCount',
		method: 'GET',
		contentType: 'application/json; charset=UTF-8',
		success: function (response) {

			drawChart1(response);
		}
	});

	$.ajax({
		url: '/chart/ageRangePerCount',
		method: 'GET',
		contentType: 'application/json; charset=UTF-8',
		success: function (response) {
			drawChart2(response);
		}
	});

	$.ajax({
		url: '/chart/getCountByArea',
		method: 'GET',
		contentType: 'application/json; charset=UTF-8',
		success: function (response) {

			drawChart3(response);
		}
	});

	$.ajax({
		url: '/chart/getAreaDateTheaterByArea',
		method: 'GET',
		contentType: 'application/json; charset=UTF-8',
		success: function (response) {

			drawChart4(response);
		}
	});

	$.ajax({
		url: '/chart/getSalesByDay',
		method: 'GET',
		contentType: 'application/json; charset=UTF-8',
		success: function (response) {
			drawChart5(response);
		}
	});

	$.ajax({
		url: '/chart/getDateAtMovie',
		method: 'GET',
		contentType: 'application/json; charset=UTF-8',
		success: function (response) {
			drawChart6(response);
		}
	});

	$.ajax({
		url: '/chart/getCountByAreas',
		method: 'GET',
		contentType: 'application/json; charset=UTF-8',
		success: function (response) {
			drawChart7(response);
		}
	});


});

function drawChart1(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);

	var options = {
			title: '예매된 영화제목별 갯수',
			pieHole: 0.4,
	};

	var chart = new google.visualization.PieChart(document.getElementById('chart1'));
	chart.draw(dataTable, options);
}


function drawChart2(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);
	var options = {
			title: '나이대 별 회원수',
			hAxis: {
				title: '나이대',
				color: 'red',

			}
	};
	var chart = new google.visualization.ColumnChart(document.getElementById('chart2'));
	chart.draw(dataTable, options);
}

function drawChart3(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);

	var options = {
			title: '지역별 예매 갯수',
			pieHole: 0.4,
	};

	var chart = new google.visualization.PieChart(document.getElementById('chart3'));
	chart.draw(dataTable, options);
}

function drawChart4(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);

	var options = {
			title: '예매한 영화 지역, 날짜, 극장',
		     hAxis: {title: '지역'},
		     vAxis: {title: '날짜'},
		     bubble: {textStyle: {fontSize: 11}}
	};

	var chart = new google.visualization.BubbleChart(document.getElementById('chart4'));
	chart.draw(dataTable, options);
}

function drawChart5(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);

	var options = {
			title: '날짜별 스토어 매출액',
			pieHole: 0.4,
	};

	var chart = new google.visualization.PieChart(document.getElementById('chart5'));
	chart.draw(dataTable, options);
}

function drawChart6(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);

	var options = {
			title: '등록된 영화 장르 예매율 평점',
		     hAxis: {title: '제목'},
		     vAxis: {title: '장르'},
		     bubble: {textStyle: {fontSize: 11}}
	};

	var chart = new google.visualization.BubbleChart(document.getElementById('chart6'));
	chart.draw(dataTable, options);
}

function drawChart7(arr) {
	var dataTable = google.visualization.arrayToDataTable(arr);
	var options = {
			title: '지역별 영화예매수',
			hAxis: {
				title: '지역',
				color: 'red',

			}
	};
	var chart = new google.visualization.ColumnChart(document.getElementById('chart7'));
	chart.draw(dataTable, options);
}
</script>
</body>
</html>

