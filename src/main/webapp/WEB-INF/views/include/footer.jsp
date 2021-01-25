<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
%>
<footer>
        <div class="containers">
            <div class="sec aboutus">
            <h2>About Us</h2>
            <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Cum, perferendis. Molestiae nostrum cupiditate debitis
                dolorem qui doloribus nesciunt sunt optio at enim quasi, aliquam voluptate consequuntur voluptatum obcaecati maiores
                impedit.</p>
                <ul class="sci">
                    <li><a href="https://github.com/yunjinhyeong/" title="윤진형 주니어 개발자"><i class="fab fa-github" aria-hidden="true"></i></a></li><span>윤진형</span>
                    <li><a href="https://github.com/krsmjeong/" title="정의수 주니어 개발자"><i class="fab fa-github" aria-hidden="true"></i></a></li><span>정의수</span>
                    <li><a href="https://github.com/elesis-sieghart/" title="주현정 주니어 개발자"><i class="fab fa-github" aria-hidden="true"></i></a></li><span>주현정</span>
                    <li><a href="https://github.com/sungjun95/" title="구성준 주니어 개발자"><i class="fab fa-github" aria-hidden="true"></i></a></li><span>구성준</span>
                    <li><a href="https://github.com/dleorb0816/" title="이대규 주니어 개발자"><i class="fab fa-github" aria-hidden="true"></i></a></li><span>이대규</span>
                </ul>
            </div>
            <div class="sec quickLinks">
                <h2>Quick Links</h2>
                <ul>
                    <li><a href="/footer/membershipagreement">회원약관</a></li>
                    <li><a href="/footer/privacypolicy">개인정보처리방침</a></li>
                    <li><a href="/footer/mailpolicy">이메일주소무단수집거부</a></li>                    
                    <li><a href="/footer/imageinformationprocessingpolicy">영상정보처리기기운영및관리방침</a></li>
                    <%
                    if(id != null) {
						if (id.equals("admin")) {
							%>
							<li><a href="/movieNotice/list">Manager Page</a></li>
							<%
						}
                    }
                    %>
		            		                   
                </ul>
            </div>
            <div class="sec contact">
                <h2>Contact Info</h2>
                <ul class="info">
                    <li>
                        <span><i class="fa fa-envelope" aria-hidden="true"></i></span>
                        <p><a href="mailto:yju7257@naver.com" title="윤진형 주니어 개발자">yjh72577@gmail.com</a></p>
                    </li>
                    <li>
                        <span><i class="fa fa-envelope" aria-hidden="true"></i></span>
                        <p><a href="mailto:krsmjeong@gmail.com" title="정의수 주니어 개발자">krsmjeong@gmail.com</a></p>
                    </li>
                    <li>
                        <span><i class="fa fa-envelope" aria-hidden="true"></i></span>
                        <p><a href="mailto:clinical1540@naver.com" title="주현정 주니어 개발자">clinical1540@gmail.com</a></p>
                    </li>
                    <li>
                        <span><i class="fa fa-envelope" aria-hidden="true"></i></span>
                        <p><a href="mailto:nw513kim@gmail.com" title="구성준 주니어 개발자">nw513kim@gmail.com</a></p>
                    </li>
                    <li>
                        <span><i class="fa fa-envelope" aria-hidden="true"></i></span>
                        <p><a href="mailto:dleorb08@gmail.com" title="이대규 주니어 개발자">dleorb08@gmail.com</a></p>
                    </li>
                </ul>
            </div>
        </div>        
    </footer>
    <div class="copyrightText">
        <p>Copyright © 2020 PERSONA Inc. All Rights Reserved</p>
    </div>