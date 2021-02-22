<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/salePage.css" rel="stylesheet">
</head>
<body style="background-color: white">
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />


	<div class="wrapper">

		<div class="main_content">
			<article class="article">

				  <div class="tab_box">
				  	<ul class="tab_wrap">
				  		<li onclick="btnClick('카드');">
				  			<a href="#none"><span>신용카드</span></a>
				  		</li>
				        <li onclick="btnClick('포인트');">
				            <a href="#none"><span>포인트</span></a>
				        </li>
				        <li onclick="btnClick('통신사');">
				            <a href="#none"><span>통신사</span></a>
				        </li>
				        <li onclick="btnClick('기타결제수단');">
				            <a href="#none"><span>기타결제수단</span></a>
				        </li>
				    </ul>
				  </div>

				  <div class="card_area">

				  	<c:set var="i" value="0" />
					<c:set var="j" value="3" />
					<%-- 메서드 자체가 초기 9개만 호출하는 메서드! --%>
					<c:choose>
						<c:when test="${ not empty cardList }">
							<c:forEach var="card" items="${ cardList }">
							<c:if test="${ i%j == 0 }">
					       		<div class="card_content">
					       	</c:if>
							    <ul style="width: 400px">
							    	<li>
							    		<p><a>
										<img width='300px' style="border-radius:7px" src="/upload4/${ card.uploadpath }/${ card.uuid }_${ card.filename }" >
										</a></p>
									</li>
									<li><a>${ card.CSale } ${ card.COnoff }</a></li>
							    	<li><a>${ card.CName }</a></li>
							    	<li><a>${ card.CDiscount }</a></li>
						    	</ul>
					    	<c:if test="${ i%j == j-1 }">
					    		</div>
					     	</c:if>
					     	<c:set var="i" value="${ i+1 }" />
						    </c:forEach>
					    </c:when>
					    <c:otherwise>
							<ul>
								<li>등록된 카드 없음</li>
							</ul>
						</c:otherwise>
					</c:choose>


				  </div>


					<div>
<%-- 						<c:if test="${fn:length(cardList) eq 9 }"> --%>
					    <div class="btn_open">
					        	<p onclick="moreContent('more_list', 1)">펼쳐보기 <span class="glyphicon glyphicon-chevron-down"></span></p>
					    </div>
<%-- 					    </c:if> --%>
				    </div>

<img alt="" src="/imgs/eventImg.jpg">
			</article>
			<img alt="" src="/imgs/eventImg2.png">
		</div>
	</div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script type="text/javascript" src="/script/bootstrap.js"></script>
<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
<script>

	// 1. 시작화면: '펼쳐보기'클릭시 불러올 카드갯수별 if문 처리 (SELECT)
	function moreContent(id, cnt) {

		var length = $("#"+id+" ul").length; // ul갯수 구하기(영화갯수)
		var cardCnt = 9 * cnt; // 총영화수 = 15*cnt

	  	    $.ajax({
	  	    	url: '/cardList/items/' + cardCnt,
	  	        method: 'GET',
	  	      	async: false, // 추가시 전역변수값에 ajax 결과값 넣을 수 있음
	  	        success: function(response) {
                   if(response.resultCnt > 0) { // 새로 추가된 수가 있는가

                		// 총 영화 수, 추가된 영화 수
                   		var resultCnt = response.resultCnt;
                   		var addCnt = response.addCnt;
                   		// 응답 객체를 String객체로 변환(가시화)
                   		var resultList = response.resultList;
                   		// 기존변수에 총 갯수 갱신
                   		cardCnt = response.resultCnt;

                   		cnt = cnt + 1;

                		if(addCnt == 9) {
                    		// 추가된 카드가 9개 일때, 기존 버튼과 온클릭 속성을 제거하고 새로 값갱신
                			$(".btn_open").show();
                			$('.btn_open p').removeAttr("onclick");
                			$('.btn_open p').attr("onclick","moreContent('"+id+"', "+cnt+");");
               			   	getMoreList(resultList);	// 리스트 html 형식으로 추가
                		} else if (addCnt < 9 || addCnt > 0) { // 추가된 영화가 0< <15 일때, 버튼 자체를 제거
               		   		$(".btn_open").hide();
               		   		getMoreList(resultList);
                    	} else {
                    		// 그러고보니 초반에 갯수가 15개미만이면 추가버튼 아예안뜨게하는것도 생각해야겠네 ;; -> 현재 15개갖고오면 버튼출력 지정ㅠㅠ 딱 15개면 버튼안나오는것도 생각해보기
							alert("나와서 안되는 경우입니다. ajax내부의 addCnt if문 수정이 필요합니다.");
                        }
               	   }
                },
	  	        error: function(request,status,error) {
  	                    alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
	  	    });
	}

	// 2. 시작화면: SELECT한것 리스트로 풀기
    function getMoreList(resultList) {

    	var content = '';
        // 들어오는 카드 갯수(매개변수 길이)
    	var length = resultList.length;

		if(length > 0) { // 카드 한개라도 있으면
			for (var [index, card] of resultList.entries()) { // ul 반복

				if (index%3 == 0) {
					content += ` <div class="card_content"> `
				}
				<%-- 최대 9개만 넘어와서 그 후는 걱정안해도 됨! --%>
				<%-- 0, 3, 6번째 영화는 새 div에서 시작해야하니까 --%>
					content += `
							    <ul style="width: 400px">
							    	<li>
							    		<p><a>
							    		<img width='300' style="border-radius:7px" src="/upload4/\${ card.uploadpath }/\${ card.uuid }_\${ card.filename }" >
										</a></p>
									</li>
									<li><a>\${ card.csale } \${ card.conoff }</a></li>
							    	<li><a>\${ card.cname }</a></li>
							    	<li><a>\${ card.cdiscount }</a></li>
						    	</ul>
						    	`
		    	<%-- 나머지가 2인 애들은 끝에 문닫아 줘야지 --%>
		    	if (index%3 == 2) {
					content += ` </div> `
				}
			}
		} else {
		content += `
					<div class="card_content">
						<ul>
							<li>등록된 카드 없음</li>
						</ul>
					</div>
				  `
		}
		$(content)
		.insertAfter($(".card_content:last"));
	}

 	// 0. 메뉴화면: '메뉴버튼'클릭시 불러올 카드갯수별 if문 처리 (SELECT)
	function btnClick(cKinds) {

		var content = '';
        var cardStart = 0;
        var cnt = 1;
        var cardCnt = 9 * cnt;

        $.ajax({
  	    	url: '/cardSort/items/' + cKinds + '/' + cardStart + '/' + cardCnt,
  	        method: 'GET',
  	      	async: false, // 추가시 전역변수값에 ajax 결과값 넣을 수 있음
  	        success: function(response) {
            		// 받아온값
               		var resultCnt = response.resultCnt;
               		var resultList = response.resultList;
               		var cnt = 1;
               		cnt = cnt + 1;

            		if(resultCnt == 9) {
            			// 추가된 카드가 9개 일때, 기존 버튼과 온클릭 속성을 제거하고 새로 값갱신
            			$(".btn_open").show();
            			$('.btn_open p').removeAttr("onclick");
            			$('.btn_open p').attr("onclick","moreSort('"+cKinds+"', "+cnt+")");
            			getMoreSort(resultList);	// 리스트 html 형식으로 추가
            		} else if (resultCnt < 9 || resultCnt > 0) {
            			$(".btn_open").hide();
            			getMoreSort(resultList);
                	} else {
                   		content += `
        					<div class="card_content">
        						<ul>
        							<li>등록된 카드 없음</li>
        						</ul>
        					</div>
        				  `
                    }
  	        },
  	      	error: function(request,status,error) {
	                alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
	      	}
		});
    }
	// 1. 메뉴화면:  SELECT한것 리스트로 풀기 (초기칸에!)
	function getMoreSort(resultList) {

    	var content = '';
        // 들어오는 카드 갯수(매개변수 길이)
    	var length = resultList.length;

		if(length > 0) { // 카드 한개라도 있으면
			for (var [index, card] of resultList.entries()) { // ul 반복

				if (index%3 == 0) {
					content += ` <div class="card_content"> `
				}
				<%-- 최대 9개만 넘어와서 그 후는 걱정안해도 됨! --%>
				<%-- 0, 3, 6번째 영화는 새 div에서 시작해야하니까 --%>
					content += `
							    <ul style="width:400px">
							    	<li>
							    		<p><a>
							    		<img style="border-radius:7px" width='300' src="/upload4/\${ card.uploadpath }/\${ card.uuid }_\${ card.filename }" >
										</a></p>
									</li>
									<li><a>\${ card.csale } \${ card.conoff }</a></li>
							    	<li><a>\${ card.cname }</a></li>
							    	<li><a>\${ card.cdiscount }</a></li>
						    	</ul>
						    	`
		    	<%-- 나머지가 2인 애들은 끝에 문닫아 줘야지 --%>
		    	if (index%3 == 2) {
					content += ` </div> `
				}
			}
		} else {
		content += `
					<div class="card_content">
						<ul>
							<li>등록된 카드 없음</li>
						</ul>
					</div>
				  `
		}
		$('.card_area').html(content);
	}
	// 2. 메뉴화면: '펼쳐보기'클릭시 불러올 카드갯수별 if문 처리 (SELECT)
	function moreSort(cKinds, cnt) {

		var cardStart = 9 * (cnt - 1);
		var cardCnt = (9 * cnt) - 1; // 뷰 총 카드수 = 9*cnt

		$.ajax({
			url: '/cardSort/items/' + cKinds + '/' + cardStart + '/' + cardCnt,
  	        method: 'GET',
  	      	async: false, // 추가시 전역변수값에 ajax 결과값 넣을 수 있음
  	        success: function(response) {
               if(response.resultCnt > 0) { // 새로 추가된 수가 있는가

               		var resultCnt = response.resultCnt;
               		var resultList = response.resultList;
               		console.log("resultCnt:"+resultCnt);
               		console.log("resultList:"+resultList);

               		// 추가된 갯수
               		var addCnt = response.resultCnt;

               		cnt = cnt + 1;

            		if(addCnt == 9) {
                		// 추가된 카드가 9개 일때, 기존 버튼과 온클릭 속성을 제거하고 새로 값갱신
                		$(".btn_open").show();
            			$('.btn_open p').removeAttr("onclick");
            			$('.btn_open p').attr("onclick","moreSort("+cnt+");");
           			   	getMoreList(resultList);	// 리스트 html 형식으로 추가
            		} else if (addCnt < 9 || addCnt > 0) { // 추가된 영화가 0< <15 일때, 버튼 자체를 제거
           		   		$(".btn_open").hide();
           		   		getMoreList(resultList);
                	} else {
                		// 그러고보니 초반에 갯수가 15개미만이면 추가버튼 아예안뜨게하는것도 생각해야겠네 ;; -> 현재 15개갖고오면 버튼출력 지정ㅠㅠ 딱 15개면 버튼안나오는것도 생각해보기
						alert("나와서 안되는 경우입니다. ajax내부의 addCnt if문 수정이 필요합니다.");
                    }
           	   }
            },
  	        error: function(request,status,error) {
	                    alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
            }
  	    });
	}
	// 3. 메뉴화면:  SELECT한것 리스트로 풀기
    // getMoreList 사용하면 됨
</script>
</body>
</html>

