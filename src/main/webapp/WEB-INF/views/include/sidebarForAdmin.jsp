<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sidebar">
    <ul>
        <li><a href="/movieNotice/list">영화리스트</a></li>
        <li><a href="/eventNotice/list">이벤트관리</a></li>
        <li><a href="#">스토어관리</a></li>
        <li><a href="#">회원관리</a></li>
        <li><a href="#">분석차트</a></li>
    </ul>
</div>
<script>
window.addEventListener("scroll", function() {
    var sidebar = document.querySelector(".sidebar");
    sidebar.classList.toggle("stickyside", window.scrollY > 300);
})
</script>