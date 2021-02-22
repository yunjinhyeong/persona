<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/productDetail.css" rel="stylesheet">
</head>
<body>

	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<form action="/store/kakaoPay" method="post" id="getCount">
		<input type="hidden" name="id" value="${ id }">
        <div>
        	<img src="/upload3/${getProduct.uploadpath }/${getProduct.uuid}_${getProduct.filename}">
        </div>
        <div class="storeDetailInfo">
            <input type="text" name="name" value="${ getProduct.name }" readonly><br>
            <input type="text" name="price" value="${ getProduct.price }" readonly><label for="price">원</label><br>
            <input type="text" name="content" value="${ getProduct.content }" readonly>
            <div class="count">
                <button type="button" onclick="javascript_:change(-1);">-</button>
                <input type="text" name="count" value="0" size="3" readonly>
                <button type="button" onclick="javascript_:change(1);">+</button>   
            </div>
            <label for="total">총합계 : </label><input type="text" name="total" value="0" readonly><label for="total">원</label><br>
            <input class="btn" type="button" id="subBtn" value="결제">
            <input class="btn" type="button" value="취소" onclick="history.back();">
        </div>
    </form>

	<div class="hearderWizard">       
        <div class="navWizard">
            <ul class="tabs">
                <li class="tab is-active">
                    <a data-switcher data-tab="1">사용방법</a>
                </li>
                <li class="tab">
                    <a data-switcher data-tab="2">취소/환불</a>
                </li>
            </ul>
        </div>
    </div>
    
    <div class="mainWizard">
        <div class="pages">
            <div class="page is-active" data-page="1">               
                <h3>사용방법</h3><br>
                <p>- 스토어 상품은 회원만 구매할 수 있습니다.<br>
                - 유효기간은 24개월로 사용일 기준입니다.<br>
                - 결제가 완료된 상품은 마이PERSONA > 예매/구매내역에서 확인 후 PERSONA 스위트#(매점)에서 사용 가능합니다.<br>
                - 선물한 매점교환권은 문자쿠폰(MMS)으로 발송되며 PERSONA 스위트#(매점)에서  문자쿠폰(MMS) 제시 후 사용 가능합니다.<br>
                - 선물한 상품은 마이PERSONA > 예매/구매내역 메뉴에서 30일 내 재발송 1회만 가능하며, 받는 사람 번호는 변경 불가합니다.<br>
                - 오리지널 팝콘이 기본으로 제공되며, 맛/반반팝콘 변경 시 금액이 추가됩니다.<br>
                - 탄산음료가 기본으로 제공되며, 사이즈 및 기타 음료로 변경 시 금액이 추가됩니다. (단, PET 음료로 변경불가)</p>            
            </div>
            <div class="page" data-page="2">
                <h3>취소/환불</h3><br>
                <p>- 스토어 상품의 취소기한은 구매일로부터 70일 입니다.<br>
                - 구매취소는 취소기한 내 마이PERSONA > 예매/구매내역에서만 가능합니다.(현장취소 불가)<br>
                - 구매하신 상품은 부분환불 및 현금환불이 불가합니다.<br>
                - 여러 상품을 한 번에 구매한 경우 일괄 취소만 가능하며, 사용한 상품이 있을 때는 환불 불가합니다.</p><br>


                <h3>기타</h3>
                <p>- 이벤트로 판매되는 상품의 구매/사용/취소 규정은 해당 이벤트 페이지를 확인해주세요.<br>
                - 유효기간 만료일 전 연장 요청 시, 1회에 한하여 3개월 연장 가능합니다.<br>
                - 고객센터: 1111-1111</p>
                
            </div>
            
        </div>
        
    </div>
    
    <img class="imgbuttom1" alt="" src="/imgs/eventImg.jpg">
    
    <img class="imgbuttom2" alt="" src="/imgs/moreimg.png">
    
    <%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script src="/script/productDetail.js"></script>
<script>
var userId = '${ sessionScope.id }';
window.onload=function() {
	document.querySelector('#subBtn').onclick = function() {
		if(!userId) {
			alert('로그인하십시오');
			history.back();
			return;			
		}
		let isSeat = confirm('이대로 결제하시겠습니까?');
		if (isSeat) {
			document.getElementById('getCount').submit();
		}

	}
}


    function change(num) {        
        var x  = document.querySelector('form');
        var y = Number(x.count.value) + num;
        
        if(y < 1) {
            return;
        }
        if(y > 5) {
            alert('최대 5개까지 구매가능합니다.');
            return;
        }
        x.count.value = y;
        var total = Number(x.price.value) * y;
        x.total.value = total;
    }



</script>
</body>
</html>