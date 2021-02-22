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
<link href="/css/nowMovieList.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />


	<div class="wrapper">

		<div class="main_content">
			<article class="article">

			<div class="movie_box">
				<c:set var="i" value="0" />
				<c:set var="j" value="5" />
					<%-- 메서드 자체가 초기 15개만 호출하는 메서드! --%>
					<c:choose>
						<c:when test="${ not empty movieList }">
							<c:forEach var="movie" items="${ movieList }">
							<c:if test="${ i%j == 0 }">
					       		<div class="movie_content">
					       	</c:if>
							    <ul>
							    	<li>
							    		<p><a href="/movieNotice/detail?num=${ movie.MNum }&pageNum=${ pageNum }&movieName=${movie.MName}">
										<img width='200' height='200' src="/upload/${ movie.uploadpath }/${ movie.uuid }_${ movie.filename }" >
										</a></p>
									</li>
									<input  type="hidden" ${movie.MName } />
							    	<li style="font-size: 20px"><a href="/movieNotice/detail?num=${ movie.MNum }&pageNum=${ pageNum }&movieName=${movie.MName}">${ movie.MName }</a></li>
							    	<li style="font-size: 15px">예매율 <a>${ movie.MRate }%</a>| ⭐ ${ movie.MScore }</li>
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

			<c:if test="${fn:length(movieList) eq 15 }">
			<div>
			    <div class="btn_open">
			        <p onclick="moreContent('more_list', 1)">펼쳐보기 <span class="glyphicon glyphicon-chevron-down"></span></p>
			    </div>
		    </div>
		    </c:if>

			</article>
		</div>
	</div>

	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script type="text/javascript" src="/script/bootstrap.js"></script>
<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
<script>

	// 15개씩 불러오기 (SELECT)
	function moreContent(id, cnt) {

		var length = $("#"+id+" ul").length; // ul갯수 구하기(영화갯수)
		var movieCnt = 15 * cnt; // 총영화수 = 15*cnt

		console.log(length);
		console.log(movieCnt);

	  	    $.ajax({
	  	    	url: '/movieList/items/' + movieCnt,
	  	        method: 'GET',
	  	      	async: false, // 추가시 전역변수값에 ajax 결과값 넣을 수 있음
// 	  	        dataType: 'json',
	  	        success: function(response) {
                   if(response.resultCnt > 0) { // 새로 추가된 수가 있는가

                		// 총 영화 수, 추가된 영화 수
                   		var resultCnt = response.resultCnt;
                   		var addCnt = response.addCnt;
                   		alert("resultCnt: " + resultCnt + ", addCnt: " + addCnt);

                   		// 응답 객체를 String객체로 변환(가시화)
                   		var resultList = response.resultList;
                   		alert('resultList length: ' + resultList.length);
                   		alert("resultList: " + resultList);


                   		// 기존변수에 총 갯수 갱신
                   		movieCnt = response.resultCnt;

                   		cnt = cnt + 1;

                		if(addCnt == 15) { // 추가된 영화가 15개 일때, 기존 버튼/온클릭 속성을 제거하고 새로 값갱신
                			$('.btn_open p').removeAttr("onclick");
                			$('.btn_open p').attr("onclick","moreContent('"+id+"', "+cnt+");");
               			   	getMoreList(resultList);	// 리스트 html 형식으로 추가
                		} else if (addCnt < 15 || addCnt > 0) { // 추가된 영화가 0< <15 일때, 버튼 자체를 제거
               		   		$(".btn_open").remove();
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

	// 리스트 추가 메서드				   // 객체배열...? [MovieMImgVo(키=값, 키=값),MovieMImgVo()]
    function getMoreList(resultList) { // [object Object],[object Object]
		alert("resultList: "+ resultList);

        // 들어오는 영화 갯수, 들어오는 값
    	var length = resultList.length;
    	alert("length : "+ length);

//     	// 들어오는 값 변환 (Object -> String)
    	var list = JSON.stringify(resultList); // list: [{영화1개},{영화1개}]
        alert("list : "+ list);

		var content = '';

		if(length > 0) { // 영화 한개라도 있으면
			for (var [index, movie] of resultList.entries()) {	// ul 반복
				console.log(index, movie);

				if (index%5 == 0) {
					content += ` <div class="movie_content"> `
				}
				<%-- 최대 15개만 넘어와서 그 후는 걱정안해도 됨! --%>
				<%-- 0, 5, 10번째 영화는 새 div에서 시작해야하니까 --%>
					content += `
							    <ul>
							    	<li>
							    		<p><a href="/upload/\${ movie.uploadpath }/\${ movie.uuid }_\${ movie.filename }">
										<img width='200' src="/upload/\${ movie.uploadpath }/\${ movie.uuid }_\${ movie.filename }" >
										</a></p>
									</li>
							    	<li style="font-size: 20px"><a href="/movieNotice/content?num=${ movie.MNum }&pageNum=${ pageNum }">\${ movie.mname }</a></li>
							    	<li style="font-size: 10px">예매율 <a>\${ movie.mrate }%</a>| ⭐ \${ movie.mscore }</li>
						    	</ul>
						    	`
					    	<%-- 나머지가 4인 애들은 끝에 문닫아 줘야지 --%>
		    	if (index%5 == 4) {
					content += ` </div> `
				}
			}
		} else {
		content += `
					<div class="movie_content">
						<ul>
							<li>등록된 영화 없음</li>
						</ul>
					</div>
				  `
		}

		alert("content: "+content);
		// class가 movie_content인 div의 마지막인애 뒤에 content를 추가함
		$(content)
		.insertAfter($(".movie_content:last"));

	}
</script>
</body>
</html>

