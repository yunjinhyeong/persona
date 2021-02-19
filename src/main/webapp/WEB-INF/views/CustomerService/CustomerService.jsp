<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/CustomerService.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />

	<div class="tab">

		<h1>FAQ</h1>
		<hr>
		<jsp:include page="/WEB-INF/views/include/CustomerMenu.jsp" />
		<div class="FAQwrapper">
			<div class="accordion">
				<input type="checkbox" name="accordion" id="answer01"> <label
					for="answer01">▣ 카드로 결제할 경우 환불은 언제 되나요?<em></em></label>
				<div class="faqCon">
					<p>
						■ 환불안내 <br> <br> ㆍ 신용카드<br> - 결제 후 3일 이내 취소시 승인취소
						가능합니다.<br> - 3일 이후 예매 취소 시 영업일 기준 3일 ~7일 이내 카드사에서 환불됩니다. <br>
						<br> ㆍ 체크카드 - 결제 후 3일 이내 취소 시 당일 카드사에서 환불 처리됩니다.<br> -
						3일 이후 예매 취소 시 카드사에 따라 3일 ~ 10일 이내 카드사에서 환불됩니다. <br> <br>
						ㆍ 휴대폰 결제<br> - 결제 일자 기준 당월(1일~말일까지) 취소만 가능합니다.<br> - 익월
						취소의 경우 페르소나 고객센터(1544-8855)로 문의 주시기 바랍니다. <br> <br>
						ㆍ카카오페이 간편결제<br> - 카카오페이머니를 사용하신 경우 카카오페이머니 잔액으로 원복됩니다.<br>
						- 카드 결제를 한 경우 카드사 정책에 따라 승인취소가 진행되며,<br> 3일 이후 매입 취소 시 영업일 기준
						3~10일 소요됩니다. <br> <br> ㆍ페이코 간편결제 - PAYCO 쿠폰/포인트를 사용하신 경우
						각각의 쿠폰/포인트로 원복됩니다.<br> - 카드 결제 금액은 카드사 정책에 따라 승인취소가 진행되며,<br>
						3일 이후 매입취소 시 영업일 기준 3~10일 소요됩니다.<br>
					</p>
				</div>
				<input type="checkbox" name="accordion" id="answer02"> <label
					for="answer02">▣ 국가유공자 할인은 어떻게 받나요?<em></em></label>
				<div class="faqCon">
					<p>
						국가유공자임을 증명할 수 있는 국가유공자증 소지자 본인에 한해 일반(2D) 영화 5천원 관람이 가능합니다.<br>
						국가유공자 할인의 경우, 온라인 예매 시에는 할인 적용이 불가하며 영화관 현장에서 예매할 시에만 할인 가능합니다. <br>
						또한, 국가유공상이자는 장애인석을 이용하실 수 있습니다.
					</p>
				</div>
				<input type="checkbox" name="accordion" id="answer03"> <label
					for="answer03">▣ SWEET SPOT이 무엇인가요?<em></em></label>
				<div class="faqCon">
					<p>
						SWEET SPOT이란, 스크린 가운데에서 상영관 뒤 벽까지 직선 거리의 2/3 지점으로, 페르소나가 추천하는 최적의
						화면과 사운드를 즐길 수 있는 좌석입니다.<br> 별도의 추가 요금은 없습니다.
					</p>
				</div>
				<input type="checkbox" name="accordion" id="answer04"> <label
					for="answer04">▣ 분실물을 찾고 싶어요.<em></em></label>
				<div class="faqCon">
					<p>영화관을 이용하시다가 소지물품을 분실하신 경우에는 페르소나 통합콜센터 1544-8855로 연락하시어 확인
						하시거나, 페르소나 홈페이지 고객센터 - 분실물안내에서 분실물 접수 혹은 확인을 하실 수 있습니다.</p>
				</div>
				<input type="checkbox" name="accordion" id="answer05"> <label
					for="answer05">▣ 단체 관람의 경우 할인 혜택이 어떻게 되나요?<em></em></label>
				<div class="faqCon">
					<p>단체 관람의 경우, 20명 이상 티켓 구매 시 1인당 1,000원씩 할인 혜택을 받으실 수 있습니다.<br> 단체
						관람과 관련하여 문의가 있으실 경우 페르소나 통합콜센터 1544-8855로 연락하시거나 페르소나 [홈페이지] →
						[고객센터] → [단체관람/대관문의]로 내용 접수해주시기 바랍니다.<br> ※ 조조, 심야, 문화의 날, 공휴일, 주말 등
						일부는 제외될 수 있습니다. <br>※ 영화관 별로 단체 관람 대상 인원수 및 할인 혜택에 일부 차이가 있을 수 있습니다.</p>
				</div>
				<input type="checkbox" name="accordion" id="answer06"> <label
					for="answer06">▣ 장애인 할인 혜택에 대해 알려 주세요.<em></em></label>
				<div class="faqCon">
					<p>'일반 2D 영화 : 5,000원 관람, 3D 영화 : 8,000원 관람이 가능합니다.<br> 온라인으로 예매를
						하셨더라도, 티켓 발권을 위해 복지카드를 가지고 영화관 인포메이션 데스크를 방문해주셔야 합니다.<br> (장애1~3등급 :
						동반 1인 포함 할인 가능/ 장애4~6등급 : 본인만 할인 가능)</p>
				</div>
				<input type="checkbox" name="accordion" id="answer07"> <label
					for="answer07">▣ 시니어 할인 혜택에 대해 알려 주세요.<em></em></label>
				<div class="faqCon">
					<p>만 65세 이상의 시니어 고객님들에게 할인 혜택을 제공하고 있습니다.<br> -일반 2D 영화 : 5,000원<br>
						-3D 영화 : 8,000원 <br>티켓발권을 위해 본인의 신분증(만 65세 이상)을 가지고 영화관 인포메이션 데스크를
						방문해주셔야 합니다. <br>타인의 신분증 제시 시 입장에 제한이 있을 수 있으므로, 반드시 입장하시는 당사자 본인의 신분증을
						지참해주시기 바랍니다. (온라인 예매 시에도 동일 정책 적용)</p>
				</div>
				<input type="checkbox" name="accordion" id="answer08"> <label
					for="answer08">▣ 결제(예매) 및 취소규정 안내<em></em></label>
				<div class="faqCon">
					<p>■ 예매 시 <br>ㆍ 홈페이지 예매 시 → 영화 시작시간 20분 전까지 예매 가능합니다.<br> ㆍ 모바일 앱/웹 예매
						시 → 영화 시작시간까지 예매 가능합니다.<br> ㆍ 현장 → 영화 시작시간까지 예매 가능합니다.<br><br> ■ 취소 시 <br>ㆍ 홈페이지
						취소 시 → 영화 시작시간 20분 전까지 취소 가능합니다.<br> ㆍ 모바일 앱/웹 예매 시 → 영화 시작시간 20분 전까지
						취소 가능합니다. <br>ㆍ 현장 → 영화 시작시간 직전까지 취소 가능합니다.<br><br> ※ 무대인사가 포함된 영화의 경우 행사의 원활한
						진행을 위해 상영시간 24시간 이전부터는 취소가 불가합니다.</p>
				</div>
			</div>
		</div>
	</div>



	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
