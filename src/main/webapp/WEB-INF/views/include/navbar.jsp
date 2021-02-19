<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
%>
<header>
        <div class="logoParent"><a href="/index" class="logo"><img src="/imgs/favicon.png" alt="">PERSONA</a></div>
        <ul>
            <li><a href="/watchMovie/selectMovie?id=<%=id %>">예매</a></li>
            <li><a href="/movieNotice/nowList">영화</a></li>
            <li><a href="/saleNotice/saleList">할인안내</a></li>
            <li><a href="/store/productPage">스토어</a></li>
            <li><a href="/eventNotice/main/list">이벤트</a></li>
            <li><a href="/CS/CustomerService">고객센터</a></li>
            <li><a href="/fileNotice/list">게시판</a></li>
            <li><a href="/chat/new">채팅</a></li>
            <%
			if (id != null) {
				%>
				<li><a href="/member/mypage?id=<%=id %>"><%=id %>님 반가워요~</a></li>
				<li><a href="/member/logout"><i class="fas fa-sign-out-alt"></i>Logout</a></li>
				<%
			} else { // id == null
				%>
				<li><a href="/member/loginjoin"><i class="fas fa-sign-in-alt"></i>Login/Join</a></li>
				<%
			}
			%>
        </ul>
    </header>


<script>
    window.addEventListener("scroll", function() {
        var header = document.querySelector("header");
        header.classList.toggle("sticky", window.scrollY > 0);
    })
</script>