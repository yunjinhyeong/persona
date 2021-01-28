<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/loginjoin.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
		
	    <section>
        <div class="loginjoinbox">
            <div class="square" style="--i:0;"></div>
            <div class="square" style="--i:1;"></div>
            <div class="square" style="--i:2;"></div>
            <div class="square" style="--i:3;"></div>
            <div class="square" style="--i:4;"></div>
        </div>
        <div class="loginjoin">
            <div class="user singinBx">
                <div class="imgBx"><img src="/imgs/robbit.jpg" alt=""></div>
                <div class="formBx">
                    <form id="login" action="/member/login" method="post" name="frm">
                        <h2>로그인</h2>
                        <input type="text" name="id" placeholder="아이디">
                        <input type="password" name="passwd" placeholder="패스워드">                        
                        <input type="checkbox" name="keepLogin"><span>아이디 기억하기</span><br>
                        <input type="submit" value="로그인">
                        <p class="signup">계정이 없나요 ? <a href="#" onclick="toggleForm();">회원가입</a></p>
                        <p class="signup">아이디를 잃어버렸나요 ? <a href="#" onclick="findID();">아이디 찾기</a></p>
                        <p class="signup">비밀번호를 잃어버렸나요 ? <a href="#" onclick="findPW();">비밀번호 찾기</a></p>
                    </form>
                    <h2>소셜로그인</h2>
                    <ul class="sci">
                        <li><a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=eac72a49a12f71733a11b03a516913df&redirect_uri=http://localhost:8082/member/kalogin"><img alt="" src="/imgs/kakaoIcon.png"></a></li>
                    </ul>
                </div>
            </div>
            <div class="user singupBx">                
                <div class="formBx">
                    <form id="join" action="/member/join" method="post" name="frm" onsubmit="return submitCheck();">
                        <h2>회원가입</h2>
                        <input type="text" name="id" placeholder="아이디" required>
                        <span id="msgIdDup"></span>
                        <input type="password" class="pass1" name="passwd" placeholder="비밀번호" required>
                        <input type="password" class="pass2" name="passwdConfirm" placeholder="비밀번호확인" required>
                        <span id="msgPass"></span>
                        <input type="text" name="name" placeholder="이름" required>
                        <input type="email" name="email" placeholder="이메일" required>
                        <span id="msgEmail"></span>
                        <input type="button" class="sendMail" value="이메일인증하기">
                        <input type="text" class="compare" placeholder="이메일 인증번호입력">
                        <span class="compare-text"></span>
                        <div class="postAddr">
                        	<input type="text" id="postcode" name="postcode" class="compare" placeholder="우편번호">
                        	<input type="button" class="compare" onclick="getPostAddress()" value="우편번호 찾기">
                        </div>   
                        <div class="postAddr">
                        	<input type="text" id="address" name="address" placeholder="주소">
                        	<input type="text" id="address2" name="address2" placeholder="상세주소">
                        </div>                        
                        <div class="userBrith">                            
                            <div class="userYear">
                                <span class="box">
                                    <input type="text" name="yy" id="yy" maxlength="4" placeholder="년(4자)" required>
                                </span>
                            </div>

                            <div class="userMonth">
                                <span class="box">
                                    <select id="mm" name="mm">
                                        <option>월</option>
                                        <option value="01">1</option>
                                        <option value="02">2</option>
                                        <option value="03">3</option>
                                        <option value="04">4</option>
                                        <option value="05">5</option>
                                        <option value="06">6</option>
                                        <option value="07">7</option>
                                        <option value="08">8</option>
                                        <option value="09">9</option>                                    
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                </span>
                            </div>
                            <div class="userDay">
                                <span class="box">
                                    <input type="text" name="dd" id="dd" maxlength="2" placeholder="일" required>
                                </span>
                            </div>
                        </div>
                        <select class="genderSelect" name="gender">
                            <option>-- 성별 --</option>
                            <option value="남자" id="man">남자</option>
                            <option value="여자" id="female">여자</option>
                        </select>
                        <input id="submitBtn" type="submit" value="회원가입">
                        <p class="signup">계정이 있나요 ? <a href="#" onclick="toggleForm();">로그인</a></p>
                    </form>
                </div>
                <div class="imgBx"><img src="/imgs/robbit.jpg" alt=""></div>
            </div>
        </div>
    </section>
    
    <%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function getPostAddress() {
    	daum.postcode.load(function(){
    		new daum.Postcode({
        		oncomplete: function(data) {
        			var addr = '';
        			if(data.userSelectedType === 'R') {
        				addr = data.roadAddress;
        			} else {
        				addr = data.jibunAddress;
        			}
        			document.getElementById('postcode').value = data.zonecode;
        			document.getElementById('address').value = addr;
        			document.getElementById('address2').focus();
        		}
        	}).open();
    	});
    }
</script>
<script type="text/javascript">
    function toggleForm() {
        var loginjoin = document.querySelector('.loginjoin');
        loginjoin.classList.toggle('active');
    }
    
    	let isID=false;
    	let isPw=false;
    	let isEmail=false;
    
    	$('input[name="id"]').keyup(function () {
    		let id = $(this).val();
    	
    		if (id.length <= 2) { // 아이디 두글자 까지는 중복체크 안함
    			return;
    		}
    	
    		// 아이디 세글자 부터는 Ajax로 아이디 중복체크하기
    		$.ajax({
    			url: '/member/ajax/joinIdDupChk',
    			data: { id: id },
    			//method: 'GET',
    			dataType :'json',
    			success: function (response) {
    				console.log(typeof response);
    				console.log(response);
    	
    				if (response.isIdDup) {
    					$('span#msgIdDup').html('이미 사용중인 아이디 입니다.').css('color', 'red');
    					isID=false;
    				} else {
    					$('span#msgIdDup').html('사용 가능한 아이디 입니다.').css('color', 'green');
    					isID=true;
    				}
    			}
    		});
    	});
    
    	// .pass2 요소에 포커스가 해제되면
    	$('.pass2').focusout(function () {
    		let pass1 = $('.pass1').val();
    		let pass2 = $(this).val();

    		if (pass1 == pass2) {
    			$('#msgPass').html('패스워드 일치함').css('color', 'green');
    			isPw=true;
    		} else {
    			$('#msgPass').html('패스워드 불일치').css('color', 'red');
    			isPw=false;
    		}
    	});
    	
    	$('input[name="email"]').keyup(function () {
    		let email = $(this).val();
    	
    		if (email.length <= 2) { // 이메일 두글자 까지는 중복체크 안함
    			return;
    		}
    	
    		// 이메일 세글자 부터는 Ajax로 아이디 중복체크하기
    		$.ajax({
    			url: '/member/ajax/joinEmailDupChk',
    			data: { email: email },
    			//method: 'GET',
    			success: function (response) {
    				console.log(typeof response);
    				console.log(response);
    	
    				if (response.isEmailDup) {
    					$('span#msgEmail').html('이미 사용중인 이메일 입니다.').css('color', 'red');
    					isEmail=false;
    				} else {
    					$('span#msgEmail').html('사용 가능한 이메일 입니다.').css('color', 'green');
    					isEmail=true;
    				}
    			}
    		});
    	});
    	
		let isCertification=false;
		let key='';
    	$('.sendMail').click(function() {// 메일 입력 유효성 검사
    		var mail = $('input[name="email"]').val(); //사용자의 이메일 입력값. 
    		console.log(mail);
    		if (mail == '') {
    			alert("메일 주소가 입력되지 않았습니다.");
    			history.back();
    		}
    		
   			$.ajax({
   				url: '/member/CheckMail',
   				data: { mail:mail },
   				method: 'post',
   				dataType :'json',
   				success: function (response) {
   					console.log(response);
   					console.log(response.key);
   					key = response.key;
   					console.log(key);
//    					alert("인증번호가 전송되었습니다.");
   		   			isCertification=true; //추후 인증 여부를 알기위한 값
   				}
   				
   			});
   			alert("인증번호가 전송되었습니다.");
   			console.log(key);
    			
   			
    		
    	});
    	// propertychange change keyup paste input
    	$('.compare').on('keyup', function() {
    		if ($('.compare').val() == key && $('.compare').val() != '') {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
    			$('.compare-text').text('인증 성공!').css('color', 'green');
    			isCertification = true;  //인증 성공여부 check
    		} else {
    			$('.compare-text').text('불일치!').css('color', 'red');
    			isCertification = false; //인증 실패
    		}
    	});
    	
    	$('input[id="submitBtn"]').click(function submitCheck(){
    		if(isCertification==false){
    			alert("메일 인증이 완료되지 않았습니다.");
    			return false;
    		} else if (isID==false) {
    			alert("아이디가 중복됩니다.");
    			return false;
    		} else if (isPw==false) {
    			alert("비밀번호가 일치하지 않습니다.");
    			return false;
    		} else if (isEmail==false) {
    			alert("사용중인 이메일 입니다.");
    			return false;
    		} else
    			true;
    		
    	});
    	
    	function findID() {
    		window.open('/member/findID', '아이디 찾기', 'width=500,height=300');
    	}
		function findPW() {
			window.open('/member/findPW', '비밀번호 찾기', 'width=500,height=300');
    	}
    	
</script>
</body>
</html>