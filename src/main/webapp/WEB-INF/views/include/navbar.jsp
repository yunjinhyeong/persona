<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
        <div class="logoParent"><a href="#" class="logo"><img src="../imgs/robbit.jpg" alt="">logoName</a></div>
        <ul>
            <li><a href="#">예매</a></li>
            <li><a href="#">영화</a></li>
            <li><a href="#">영화관</a></li>
            <li><a href="#">이벤트</a></li>
            <li><a href="#">스토어</a></li>
            <li><a href="#"><i class="fas fa-user-plus"></i>Join</a></li>
            <li><a href="#"><i class="fas fa-sign-in-alt"></i>Sign</a></li>
        </ul>       
    </header>
    <img class="bg" src="../imgs/black.png" alt="">


<script>
    window.addEventListener("scroll", function() {
        var header = document.querySelector("header");
        header.classList.toggle("sticky", window.scrollY > 0);
    })
</script>