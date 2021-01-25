<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/policy.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
	
	
<!-- contents -->
<div id="contents" class="email_notCollect_con">
    <div class="title_top">
        <h2 class="tit">이메일주소 무단 수집 거부</h2>
    </div>

    <div class="box_con">
        <strong>PERSONA시네마 사이트에 방문해주셔서 감사합니다.</strong><br/><br/>
        <p>
            PERSONA시네마 웹사이트에 게시된 이메일 주소가 전자우편 수집 프로그램이나<br />
            그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부합니다.
        </p>
        <p>이를 위반할 시 정보통신망법에 의해 형사처벌됨을 유념하시기 바랍니다.</p>
    </div>
</div>
<!-- //contents -->
	
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
</body>
</html>