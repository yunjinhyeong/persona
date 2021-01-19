<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
%>
<header>
        <div class="logoParent"><a href="#" class="logo"><img src="/imgs/favicon.png" alt="">logoName</a></div>
        <ul>
            <li><a href="#">예매</a></li>
            <li><a href="#">영화</a></li>
            <li><a href="#">영화관</a></li>
            <li><a href="#">이벤트</a></li>
            <li><a href="#">스토어</a></li>
            <li><a href="#">게시판</a></li>
            <%
			if (id != null) {
				%>
				<li><a href="#"><%=id %>님 반가워요~</a></li>
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