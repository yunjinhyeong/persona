<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<link href="/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/css/bootstrap-theme.css" rel="stylesheet" type="text/css">

<%-- head 영역  --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" href="/css/movieDetail.css" />


<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<style>
p.reply-toggle {
	cursor: pointer;
}
/* 나타나고 있을때와 사라지고 있을때 0.5초*/
.v-enter-active, .v-leave-active {
	transition: 0.1s;
}
/* 나타나기 전의 상태과 사라진 후의 상태는 투명도 0, 오른쪽으로 50 이동*/
.v-enter, .v-leave-to {
	opacity: 0;
	transform: translateX(20px)
}

.starR {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat right 0;
	background-size: auto 100%;
	width: 30px;
	height: 30px;
	display: inline-block;
	text-indent: -9999px;
	cursor: pointer;
}

.starR.on {
	background-position: 0 0;
}
</style>
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<article>
		<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
		<br />
		<div class="wrapper" align="center">

			<div class="main_content">
				<table class="tg">
					<thead>
						<tr>
							<th class="tg-0pky" rowspan="5"><c:if
									test="${ not empty mImgTrailerList }">
									<c:forEach var="mImgTrailer" items="${ mImgTrailerList }">
										<c:if test="${ mImgTrailer.image eq 'P' }">
											<p>
												<a
													href="/upload/${ mImgTrailer.uploadpath }/${ mImgTrailer.uuid }_${ mImgTrailer.filename }">
													<img width='200'
													src="/upload/${ mImgTrailer.uploadpath }/${ mImgTrailer.uuid }_${ mImgTrailer.filename }"
													width="600px">
												</a>
											</p>
										</c:if>
									</c:forEach>
								</c:if></th>
							<th class="tg-0pky">${ movieVo.MRank }</th>
							<th class="tg-0pky" >${ movieVo.MName }<input type="hidden" id="movieName" value="${ movieVo.MName }"/></th>
							<th class="tg-0pky" colspan="7"></th>
						</tr>
						<tr class="bottom">
							<td class="tg-0pky" colspan="2">관람객평점 ⭐ ${ movieVo.MScore }</td>
							<td class="tg-0pky" colspan="2">예매율 ${ bookrate }%</td>
							<td class="tg-0pky" colspan="2">누적 관객수</td>
							<td class="tg-0pky" colspan="3"></td>
						</tr>
						<tr>
							<td class="tg-0pky">장르</td>
							<td class="tg-0pky">${ movieVo.MGenre }</td>
							<td class="tg-0pky" colspan="2">${ movieVo.MRuntime }분</td>
							<td class="tg-0pky" colspan="3"></td>
						</tr>
						<tr>
							<td class="tg-0pky">감독</td>
							<td class="tg-0pky">${ movieVo.MDirector }</td>
							<td class="tg-0pky" colspan="7"></td>
						</tr>
						<tr>
							<td class="tg-0pky">출연</td>
							<td class="tg-0pky" colspan="4">${ movieVo.MActor }</td>
							<td class="tg-0pky"></td>
							<td class="tg-0pky"><span class="material-icons"
								style="color: #808080;"> share </span></td>
							<td class="tg-0pky">
								<div id='likeDiv' align="center">
									<c:choose>

										<c:when test="${ id == null }">
											<a href='javascript: noID();'><img src='/imgs/heart1.png'
												id='like_img' width="35px" height="35px"></a>
											<em>${ movieVo.MLike  }</em>
										</c:when>

										<c:otherwise>

											<c:choose>

												<c:when test="${ likeStatus == 0 || likeStatus == 2}">
													<a href='javascript: like_func();'><img
														src='/imgs/heart1.png' id='like_img' width="35px"
														height="35px"></a>
													<em>${ movieVo.MLike  }</em>
												</c:when>

												<c:otherwise>
													<a href='javascript: like_func();'><img
														src='/imgs/heart2.png' id='like_img' width="35px"
														height="35px"></a>
													<em>${ movieVo.MLike  }</em>
												</c:otherwise>

											</c:choose>

										</c:otherwise>

									</c:choose>
								</div>
							</td>
							<td class="tg-0pky"><button>예매하기</button></td>
						</tr>
					</thead>
				</table>

			</div>
		</div>

		<div class="tabdiv">

			<ul class="tablist" role="tablist">
				<li class="tab" role="tab"><a href="#panel1">영화정보 </a></li>
				<li class="tab" role="tab"><a href="#panel2">평점 및 관람평</a></li>

				<li class="tab-menu">
					<div class="line"></div>
					<div class="line"></div>
					<div class="line"></div>
				</li>
			</ul>
			<div class="tabpanel innerInfo" id="panel1" role="tabpanel">
				<span class="title">영화 스토리</span>	
				<div class="innerInfo1">${ movieVo.MStory }</div>
				<span class="title">영화 트레일러</span>					
				<div class="innerInfo2">
					<c:if test="${ not empty mImgTrailerList }">
						<c:forEach var="mImgTrailer" items="${ mImgTrailerList }">
							<c:if test="${ mImgTrailer.image eq 'N' }">
								<p>
									<a
										href="/upload/${ mImgTrailer.uploadpath }/${ mImgTrailer.uuid }_${ mImgTrailer.filename }">
										<video
											src="/upload/${ mImgTrailer.uploadpath }/${ mImgTrailer.uuid }_${ mImgTrailer.filename }"
											width='200px' autoplay muted>비디오
										</video>
									</a>
								</p>
							</c:if>
						</c:forEach>
					</c:if>
					<div id="chart1"></div>
				</div>
			</div>

			<div class="tabpanel" id="panel2" role="tabpanel">

				<!-- 댓글 영역 -->
				<div class="app1" class="panel panel-default">

					<div class="panel-heading">
						<div class="row">
							<div class="col-md-6">
								<button type="button" v-on:click="showListArea = !showListArea"
									class="btn btn-default">
									<span class="glyphicon glyphicon-comment"></span> 댓글 <span
										style="color: red;">{{ totalCount }}</span>
								</button>
								<button type="button" class="btn btn-default"
									v-on:click="getList">
									<span class="glyphicon glyphicon-refresh"></span> 새로고침
								</button>
							</div>
							<div class="col-md-6">
								<label for="commentCount"
									class="col-md-offset-3 col-md-5 control-label text-right">댓글
									갯수: </label>
								<div class="col-md-4">
									<select id="commentCount" class="form-control pull-right"
										v-model="numOfRows" v-on:change="loadListWithFirstPage">
										<option v-for="num in [5, 10, 15, 20]">{{ num }}</option>
									</select>
								</div>
							</div>
						</div>

					</div>

					<template v-if="showListArea">
						<div class="panel-body">



							<!-- 댓글 리스트 영역 -->
							<ul class="media-list">

								<transition-group>
								<li class="media" v-for="(comment, index) in commentList"
									v-bind:key="comment.cno"
									v-bind:style="{ marginLeft: comment.reLev * 50 + 'px' }"><span
									class="pull-left" v-if="comment.reLev > 0">└</span> <a
									class="pull-left" href="#">
									<div v-if="comment.reLev == 0">
									<img v-if="comment.score < 4" src="/imgs/angry.png">
									<img v-else-if="comment.score < 8" src="/imgs/soso.png"/>
									<img v-else src="/imgs/happy.png">
									</div>
								</a>

									<div class="media-body">
										<div class="media-heading" >
											<strong class="text-primary">{{ comment.id }}</strong>


											<strong class="text-primary" v-if="comment.reLev == 0">⭐ {{ comment.score}}</strong>


											<div v-if="comment.id == loginId" class="dropdown pull-right"
												style="display: inline-block;">

												<a data-toggle="dropdown" href="#">수정/삭제</a>
												<ul class="dropdown-menu">
													<li><a href="#"
														v-on:click="showModifyComment(index, $event)">수정</a></li>
													<li><a href="#"
														v-on:click="removeComment(index, $event)">삭제</a></li>
												</ul>
											</div>
										</div>
										<p>{{ comment.content }}</p>
										<div>
											<small class="text-muted">{{
												getDate(comment.updateDate) }}</small> <span class="reply-toggle"
												v-on:click="toggleReplyWriteArea(index)"> {{
												comment.writeOk ? '답글접기' : '답글쓰기' }} </span>
										</div>
									</div> <!-- 답댓글 작성 영역 -->
									<div v-if="comment.writeOk" style="margin-left: 50px;">
										<textarea v-model="inputReplyComment" rows="5"
											class="form-control" placeholder="댓글을 입력하세요."></textarea>
										<br>

										<button type="button" class="btn btn-primary"
											v-bind:data-type="type" v-bind:data-reref="comment.reRef"
											v-bind:data-relev="comment.reLev"
											v-bind:data-reseq="comment.reSeq"
											v-on:click="addReplyOrUpdateComment(index, $event)">등록</button>

										<small class="text-muted" style="margin-left: 20px;">{{
											remain }} / 600</small>
									</div></li>
								</transition-group>
							</ul>

							<!-- 페이지 블록 영역 -->
							<ul v-if="totalCount > 0" class="pagination pull-right">
								<li v-bind:class="{ 'disabled': !isPrevOk }"><a href="#"
									v-on:click="setPageNo(prevBlockPage)">« 이전</a></li>

								<li v-for="item in pageBlockList" v-bind:key="item.pageNum"
									v-bind:class="{ 'active': item.isCurrentPage }"><a
									href="#" v-on:click="setPageNo(item.pageNum)">{{
										item.pageNum }}</a></li>

								<li v-bind:class="{ 'disabled': !isNextOk }"><a href="#"
									v-on:click="setPageNo(nextBlockPage)">다음 »</a></li>
							</ul>
						</div>


<!-- 주댓글 작성 영역 -->
							<div class="panel-footer">


								<div class="starRev1">
									<p class="starR"  onclick='printScore()'>1</p>
									<p class="starR"  onclick='printScore()'>2</p>
									<p class="starR"  onclick='printScore()'>3</p>
									<p class="starR"  onclick='printScore()'>4</p>
									<p class="starR"  onclick='printScore()'>5</p>
									<p class="starR"  onclick='printScore()'>6</p>
									<p class="starR"  onclick='printScore()'>7</p>
									<p class="starR"  onclick='printScore()'>8</p>
									<p class="starR"  onclick='printScore()'>9</p>
									<p class="starR"  onclick='printScore()'>10</p>
								</div>


								<textarea rows="5" v-model="inputComment" class="form-control"
									placeholder="댓글을 입력하세요."></textarea>
								<br>
								<button type="button" v-on:click="addComment"
									class="btn btn-primary">등록</button>
								<small class="text-muted" style="margin-left: 20px;">{{
									remain }} / 600</small>
							</div>

					</template>
				</div>



			</div>

		</div>


	</article>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>

	<script>

	// 구글 시각화 API를 로딩하는 메소드
	google.charts.load('current', {packages: ['corechart']});

	// 구글 시각화 API가 로딩이 완료되면,
	// 인자로 전달된 콜백함수를 내부적으로 호출함
	google.charts.setOnLoadCallback(function () {
		// 최초 한번은 ajax 방식으로 차트 데이터 가져와서 차트 그리기
		getChartDataMemberAndDraw();
		// 서버소켓에 연결하기
		connect();
	});

	var webSocket;

	function connect() {
		webSocket = new WebSocket('ws://localhost:8082/chart/member');
		webSocket.onopen = onOpen;
		webSocket.onmessage = onMessage; // 소켓서버로부터 데이터를 받을때 호출됨
		webSocket.onclose = onClose;
	}

	function onOpen() {
		console.log('===== 서버소켓과 연결됨 =====');
	}
	function onClose() {
		console.log('===== 서버소켓과 연결이 끊어짐 =====');
	}
	function onMessage(event) {
		let strJson = event.data; // json 문자열을 받음
		console.log('data type : ' + typeof strJson); // string
		let obj = JSON.parse(strJson); // json 문자열을 object 로 변환
		console.log('obj type : ' + typeof obj); // object
		console.log(obj);

		drawChart1(obj.genderPerCountList);
	}

	function getChartDataMemberAndDraw() {

// 		var name = ${ movieVo.MName };
// 		alert("무비네임은 : " + ${movieVo.getMName()});
		var name = document.getElementById('movieName');
		var name1 = name.value;

		console.log("asd" + name1);
		// 남녀 성별 회원수, 연령대별 회원수 ajax 요청하기
		$.ajax({
			url: '/ajax/chartDataMember',
			method: 'GET',
			data: { name : name1 },
			contentType: 'application/json; charset=UTF-8',
			success: function (response) {
				console.log(typeof response);
				console.log(response);

				drawChart1(response.genderPerCountList);
			}
		});
	}

	// 파이 그래프 그리기
	function drawChart1(arr) {
		var dataTable = google.visualization.arrayToDataTable(arr);

		var options = {
				title: '남녀 예매율'
		};

		var objDiv = document.getElementById('chart1');
		var chart = new google.visualization.PieChart(objDiv);
		chart.draw(dataTable, options);
	}

		// 게시글 삭제 함수
		function remove() {
			let isDelete = confirm('${ movieVo.MNum }번 글을 정말 삭제하시겠습니까?');
			if (isDelete) {
				location.href = '/movieNotice/delete?num=${ movieVo.MNum }&pageNum=${ pageNum }';
			}
		}

		//////////////////////////////////////////////////////////////////////////

		(function() {

			function activateTab() {
				if (activeTab) {
					resetTab.call(activeTab);
				}
				this.parentNode.className = 'tab tab-active';
				activeTab = this;
				activePanel = document.getElementById(activeTab.getAttribute(
						'href').substring(1));
				activePanel.className = 'tabpanel show';
				activePanel.setAttribute('aria-expanded', true);
			}

			function resetTab() {
				activeTab.parentNode.className = 'tab';
				if (activePanel) {
					activePanel.className = 'tabpanel hide';
					activePanel.setAttribute('aria-expanded', false);
				}
			}

			var doc = document, tabs = doc.querySelectorAll('.tab a'), panels = doc
					.querySelectorAll('.tabpanel'), activeTab = tabs[0], activePanel;

			activateTab.call(activeTab);

			for (var i = tabs.length - 1; i >= 0; i--) {
				tabs[i].addEventListener('click', activateTab, false);
			}

		})();

	</script>

	<!-- 	댓글 영역 -->
	<script>
		// 게시글 번호
		const mno = ${ movieVo.MNum };

		new Vue({
			el: '.app1',
			data: {
				loginId: '${ sessionScope.id }', // 톰캣서버 세션의 로그인 아이디
				pageNo: 1,  // 사용자 요청 페이지 번호
				showListArea: true,  // 댓글리스트 영역 보이기 여부 스위치
				totalCount: 0,    // 전체 댓글 갯수
				commentList: [],  // 댓글 리스트 데이터
				inputComment: '', // 주댓글 입력내용
				inputReplyComment: '', // 답댓글 또는 댓글수정 입력내용
				type: '',  // 댓글수정(update) 또는 답댓글 추가(insert) 인지 구분

				// 페이지블록 관련 데이터 속성
				numOfRows: 10, // 한 페이지당 보여지는 댓글 갯수
				pageCount: 0,  // 댓글의 총 페이지 갯수
				pageBlock: 5,  // 페이지블록 내의 페이지 갯수
				startPage: 0,  // 페이지블록 내의 시작페이지
				endPage: 0,    // 페이지블록 내의 끝페이지
				pageBlockList: [] // 페이지블록 리스트 (시작페이지부터 끝페이지까지의 페이지번호가 요소)
			},
			// 산출속성은 반드시 값을 리턴해야 함!
			computed: {

				remain: function () { // 댓글입력 남은 글자수
					return 600 - this.inputComment.length;
				},

				isPrevOk: function () { // 이전 페이지블록 존재 여부
					return this.startPage > this.pageBlock;
				},

				isNextOk: function () { // 다음 페이지블록 존재여부
					return this.endPage < this.pageCount;
				},

				prevBlockPage: function () {
					return this.startPage - this.pageBlock;
				},

				nextBlockPage: function () {
					return this.startPage + this.pageBlock;
				}
			},
			watch: {
				inputComment: function () {
					if (this.inputComment.length > 600) {
						this.inputComment = this.inputComment.substring(0, 600);
					}
				}
			},
			methods: {
				toggleReplyWriteArea: function (index) {
					// 답댓글 입력내용 비우기
					this.inputReplyComment = '';

					for (let i=0; i<this.commentList.length; i++) {
						let comment = this.commentList[i];

						// 클릭한 위치는 토글처리
						if (i == index) {
							if (comment.writeOk) {
								comment.writeOk = false;
							} else {
								comment.writeOk = true;
								this.type = 'insert'; // 등록 버튼의 용도를 답댓글 추가로 표시 변경
							}
						} else { // 클릭한 위치가 아니면 모두 댓글쓰기영역 접기
							comment.writeOk = false;
						}
					} // for
				},

				getDate: function (str) {
					console.log(typeof str);
					console.log(str);

					let today = new Date(); // 현재시점 날짜시간
					let date = new Date(str); // new Date('2021-01-06T02:44:32.000+00:00');

					let gap = today.getTime() - date.getTime(); // 밀리초 차이값
					let oneDay = 1000 * 60 * 60 * 24; // 밀리초 하루

					let result;
					if (gap > oneDay) { // 년월일
						result = moment(str).format('YYYY-MM-DD');
					} else { // gap <= oneDay   시분초
						result = moment(str).format('a hh:mm:ss');
					}
					return result;
				},

				setPageNo: function (pageNum) {
					if (pageNum < 1 || pageNum > this.pageCount) {
						return;
					}
					this.pageNo = pageNum;
					this.getList();
				},

				// 댓글목록 가져오기
				getList: function () {
					// jsp의 el언어로 게시판 글번호를 출력해서 자바스크립트 변수에 저장
					let vm = this; // ViewModel의 약칭. Vue객체 자기자신을 vm 변수로 저장

					$.ajax({
						url: '/mcomment/pages/' + mno  + '/' + this.pageNo + '/' + this.numOfRows,
						method: 'GET',
// 						dataType: 'json',
						success: function (response) {
							console.log(typeof response);
							console.log(response);

							for (let comment of response.commentList) {
								comment.writeOk = false; // 오브젝트마다 writeOk 필드 추가
								console.log(comment);
							} // for

							// 서버에서 응답받은 데이터를 리액티브 데이터에 저장
							// 리액티브 데이터가 변경되면 즉시 바인딩된 화면도 렌더링됨
							vm.commentList = response.commentList;

							// 전체 댓글 갯수
							vm.totalCount = response.totalCount;

							// 페이지블록 만들기 (전체댓글갯수를 기준으로 페이지블록 생성)
							vm.makePageBlock();
						},
						error: function () {
							//alert('댓글 리스트 가져오기 오류 발생...')
						}
					});
				}, // getList

				// 페이지블록 만들기
				makePageBlock: function () {
					// 댓글의 총 페이지 갯수 구하기
					this.pageCount = Math.ceil( this.totalCount / this.numOfRows );

					// ((1-1) / 5) * 5 + 1  -> 1
					// ((2-1) / 5) * 5 + 1  -> 1
					// ((3-1) / 5) * 5 + 1  -> 1
					// ((4-1) / 5) * 5 + 1  -> 1
					// ((5-1) / 5) * 5 + 1  -> 1

					// ((6-1)) / 5 * 5 + 1  -> 6
					// ((7-1)) / 5 * 5 + 1  -> 6
					// ((8-1)) / 5 * 5 + 1  -> 6
					// ((9-1)) / 5 * 5 + 1  -> 6
					// ((10-1)) / 5 * 5 + 1 -> 6

					// 페이지블록 내의 시작페이지 구하기
					this.startPage = Math.floor((this.pageNo - 1) / this.pageBlock) * this.pageBlock + 1;

					// 페이지블록 내의 끝페이지 구하기
					this.endPage = this.startPage + this.pageBlock - 1;
					if (this.endPage > this.pageCount) {
						this.endPage = this.pageCount;
					}

					// 페이지번호 배열리스트 비우기
					this.pageBlockList.splice(0);

					for (let i=this.startPage; i<=this.endPage; i++) {
						let obj = {
								pageNum: i,
								isCurrentPage: (this.pageNo == i) ? true : false
						};

						this.pageBlockList.push(obj);
					} // for

				},

				// 한페이지당 보여줄 댓글갯수 변경시 새로 댓글목록 가져오기
				loadListWithFirstPage: function () {
					this.pageNo = 1;
					this.getList();
				},

				// 주댓글 등록하기
				addComment: function () {
					let obj = {
							mno: mno,
							content: this.inputComment,
							score: this.score
					};
					console.log(obj);

					let str = JSON.stringify(obj); // 자바스크립트 객체를 JSON 문자열로 변환
					console.log(str);


					let vm = this;

					$.ajax({
						url: '/mcomment/new',
						data: str,
						method: 'POST',
						contentType: 'application/json; charset=UTF-8',
						success: function (response) {
							console.log(response);

							// 현재 페이지 다시 불러오기
							vm.getList();

							// 다른방식 구현
// 							let comment = response.comment;
// 							comment.writeOk = false; // writeOk 필드 추가
// 							vm.commentList.push(comment); // 리스트 맨 뒤에 댓글 추가
// 							vm.inputComment = '';  // 입력상자 비우기
// 							vm.totalCount++;  // 댓글갯수 증가
						},
						error: function (req, status, err) {
							console.log('code: ' + req.status + '\n message: ' + req.responseText + '\n error: ' + err);
							console.log(typeof req.responseText); // string

							let obj = JSON.parse(req.responseText); // <-> JSON.stringify()
							console.log(typeof obj) // object

							if (obj.isLogin == false) {
								alert('로그인 사용자만 댓글 작성이 가능합니다.');
								location.href = '/member/login';
							}
						}
					});
				}, // addComment

				// 답댓글 등록하기
				addReplyComment: function (event) {
					let btn = event.target;

// 					let reRef = $(btn).data('reref');
					let reRef = btn.dataset.reref;
					let reLev = btn.dataset.relev;
					let reSeq = btn.dataset.reseq;
					console.log(reRef + ', ' + reLev + ', ' + reSeq);


					let obj = {
							mno: mno,
							content: this.inputReplyComment,
							reRef: reRef,
							reLev: reLev,
							reSeq: reSeq
					};
					console.log(obj);

					let str = JSON.stringify(obj); // 자바스크립트 객체를 JSON 문자열로 변환
					console.log(str);

					let vm = this;

					$.ajax({
						url: '/mcomment/new/reply', // 답댓글은 /reply
						data: str,
						method: 'POST',
						contentType: 'application/json; charset=UTF-8',
						success: function (response) {
							console.log(response);

							vm.getList();
						},
						error: function () {
							alert('로그인 사용자만 댓글 작성이 가능합니다.');
							location.href = '/member/login';
						}
					});

				},

				// 댓글 한개 삭제하기
				removeComment: function (index, event) {
					// a 태그의 href 속성 기본기능 방지
					event.preventDefault(); // 스크롤바 이동 방지

					let isRemove = confirm('댓글을 정말 삭제하시겠습니까?');
					if (isRemove == false) {
						return;
					}

					let comment = this.commentList[index];
					let cno = comment.cno;
					console.log('삭제 cno = ' + cno);

					let vm = this;

					// 삭제 요청
					$.ajax({
						url: '/mcomment/' + cno,
						method: 'DELETE',
						success: function (response) {
							console.log(response);
							// 현재 페이지 다시 불러오기
							vm.getList();

							// 다른방식 구현
// 							vm.commentList.splice(index, 1); // 삭제한 댓글 아이템을 리스트에서 제거
// 							vm.totalCount--; // 댓글갯수 1 감소
						},
						error: function () {
							alert('로그인 사용자만 댓글 삭제가 가능합니다.');
							location.href = '/member/login';
						}
					});
				},

				// 댓글 한개 수정화면 보이기
				showModifyComment: function (index, event) {
					// a 태그의 href 속성 기본기능 방지
					event.preventDefault(); // 스크롤바 이동 방지

					// 선택한 댓글만 토글로 보이고, 나머지는 숨기기
					this.toggleReplyWriteArea(index);

					// 댓글내용을 수정댓글 입력상자에 배치
					let comment = this.commentList[index];
					this.inputReplyComment = comment.content;

					this.type = 'update'; // 등록 버튼의 용도를 수정으로 표시 변경
				}, // showModifyComment

				modifyComment: function (index) {
					let comment = this.commentList[index];

					let obj = {
							cno: comment.cno,
							content: this.inputReplyComment
					};

					// 오브젝트를 JSON 문자열로 변환
					let strJson = JSON.stringify(obj);

					let vm = this;

					$.ajax({
						url: '/mcomment/modify',
						method: 'PUT',
						data: strJson,
						contentType: 'application/json; charset=UTF-8',
						success: function (response) {
							// 현재페이지 다시 불러오기
							vm.getList();

							// 다른방식 구현
// 							let cmt = response.comment;
// 							cmt.writeOk = false;
// 							//vm.commentList[index] = cmt; //변경내용을 Vue객체가 알아차라지 못해서 화면랜더링이 일어나지 않음.
// 							vm.commentList.splice(index, 1, cmt); // 인덱스 위치부터 1개를 cmt 객체로 수정
						},
						error: function () {
							alert('로그인 사용자만 댓글 수정이 가능합니다.');
							location.href = '/member/login';
						}
					});
				},

				// 답댓글 추가 또는 현재댓글 수정하기
				addReplyOrUpdateComment: function (index, event) {
					if (this.type == 'insert') { // 답댓글 추가
						this.addReplyComment(event);
					} else if (this.type == 'update') { // 현재댓글 수정
						this.modifyComment(index);
					}
				},



			},
			mounted: function () {
					this.getList();

			}
		});

		/* 좋아요 */
		function like_func(){

		var likeStatus = ${ likeStatus };
		var movieNum = ${ movieVo.MNum };
		var userId = '${ sessionScope.id }';

		var datas = {
			likeStatus: ${ likeStatus },
			movieNum: ${ movieVo.MNum },
			userId: '${ sessionScope.id }'
		}

		  $.ajax({
		    url: "/movieNotice/like",
		    type: "POST",
		    data : datas,
		    success: function(data) {

		      if(likeStatus == 0 || likeStatus == 2){
		    	alert('"좋아요"가 반영되었습니다!');
		        $('#like_img').attr('src', '/imgs/heart2.png');
		      } else {
		    	alert('"좋아요"가 취소되었습니다!');
		        $('#like_img').attr('src', '/imgs/heart1.png');
		      }

		    },
		    error: function(request, status, error){
		      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		  });
		setTimeout(function(){
			location.reload();
		},300);

		}

		function noID() {
			alert("'로그인 후'이용 가능합니다!");
		}

		$('.starRev1 p').click(function(){

			var temp = $(this).text();

			$(this).parent().children('p').removeClass('on');
			$(this).parent().children('p').attr('id' , '');
			$(this).addClass('on').prevAll('p').addClass('on');


			score_func(temp);
		});

		function score_func(temp){

			var datas = { score: temp }

			  $.ajax({
			    url: "/movieNotice/score",
			    type: "POST",
			    data : datas,
			    success: function(data) {
			    },
			    error: function(request, status, error){
			      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			  });

		}


	</script>
</body>
</html>