<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/movieWriteForm.css" rel="stylesheet">
<link href="/css/sidebarForAdmin.css" rel="stylesheet">
</head>
<body>
	<%-- header 영역 --%>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
	
	<div class="wrapper">
	<%-- sidebar 영역 --%>
	<jsp:include page="/WEB-INF/views/include/sidebarForAdmin.jsp" />
        <div class="main_content">
            <form action="/saleNotice/modify" method="post" enctype="multipart/form-data" name="frm">
                <input type="hidden" name="pageNum" value="${ pageNum }">
                <input type="hidden" name="cNum" value="${ cardCardInfoVo.CNum }">
                <Table class="addMovieMain">
                	<tr>
                		<tr>
                            <th><label for="cKinds">카드종류</label></th>
                            <td><select name="cKinds" required>
                            	<c:set var="kind" value="${ cardCardInfoVo.CKinds }" />
                            	<c:choose>
                            		<c:when test="${ kind eq '롯데카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드" selected>롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq '씨티카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드" selected>씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq '하나카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드" selected>하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq 'BC카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드" selected>BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq 'KB국민카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드" selected>KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq 'IBK카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드" selected>IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq 'NH카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드" selected>NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq 'SC카드' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드" selected>SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq '포인트' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트" selected>포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq '통신사' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사" selected>통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
                            		</c:when>
                            		<c:when test="${ kind eq '기타결제수단' }">
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단" selected>기타결제수단</option>
                            		</c:when>
                            		<c:otherwise>
                            			<option>--카드종류--</option>
		                                <option value="롯데카드">롯데카드</option>
		                                <option value="씨티카드">씨티카드</option>
		                                <option value="하나카드">하나카드</option>
		                                <option value="BC카드">BC카드</option>
		                                <option value="KB국민카드">KB국민카드</option>
		                                <option value="IBK카드">IBK카드</option>
		                                <option value="NH카드">NH카드</option>
		                                <option value="SC카드">SC카드</option>
		                                <option value="포인트">포인트</option>
		                                <option value="통신사">통신사</option>
		                                <option value="기타결제수단">기타결제수단</option>
	                                </c:otherwise>
                                </c:choose>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="CName">카드이름</label></th>
                            <td><input type="text" name="CName" value="${ cardCardInfoVo.CName }" required></td>
                        </tr>
                        
                        
                        
                         <tr>
							<th><label for="cImg">카드이미지</label></th>
							<td class="borderBottom">
								<div id="oldFileBox">
													
										<input type="hidden" name="oldfile" value="${ cardCardInfoVo.noNum }">
										<div>
											${ cardCardInfoVo.filename } <span class="delete-oldfile">X</span>
										</div>	
									
								</div>
								<div id="newFileBox"></div>
								<input type="button" id="btnAddFile" value="첨부파일 추가">
							</td>
						</tr> 
						
						
						
						
						 <tr>
                            <th><label for="cSale">할인종류</label></th>
                            <td><select name="cSale" required>
                            	<c:set var="sale" value="${ cardCardInfoVo.CSale}" />
                            	<c:choose>
                            		<c:when test="${ sale eq '청구할인' }">
                            			<option>--할인종류--</option>
                            			<option value="청구할인" selected>청구할인</option>
                            			<option value="현장할인">현장할인</option>
                            			<option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ sale eq '현장할인' }">
                            			<option>--할인종류--</option>
		                                <option value="청구할인">청구할인</option>
                            			<option value="현장할인" selected>현장할인</option>
                            			<option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ sale eq '' }">
                            			<option>--할인종류--</option>
		                                <option value="청구할인">청구할인</option>
                            			<option value="현장할인">현장할인</option>
                            			<option value="" selected>없음</option>
                            		</c:when>
                            		<c:otherwise>
                            			<option>--할인종류--</option>
		                                <option value="청구할인">청구할인</option>
		                                <option value="현장할인">현장할인</option>
		                                <option value="">없음</option>
                            		</c:otherwise>
                                </c:choose>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="cOnoff">온/오프라인</label></th>
                            <td><select name="cOnoff" required>
                            	<c:set var="onoff" value="${ cardCardInfoVo.COnoff}" />
                            	<c:choose>
                            		<c:when test="${ onoff eq '온/오프라인' }">
                            			<option>--온/오프라인--</option>
                            			<option value="온/오프라인" selected>온/오프라인</option>
                            			<option value="온라인 할인">온라인 할인</option>
                                		<option value="오프라인">오프라인</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ onoff eq '온라인 할인' }">
                            			<option>--온/오프라인--</option>
		                                <option value="온/오프라인">온/오프라인</option>
		                                <option value="온라인 할인" selected>온라인 할인</option>
                                		<option value="오프라인">오프라인</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ onoff eq '오프라인' }">
                            			<option>--온/오프라인--</option>
		                                <option value="온/오프라인">온/오프라인</option>
		                                <option value="온라인 할인">온라인 할인</option>
                                		<option value="오프라인" selected>오프라인</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ onoff eq '' }">
                            			<option>--온/오프라인--</option>
		                                <option value="온/오프라인">온/오프라인</option>
		                                <option value="온라인 할인">온라인 할인</option>
                                		<option value="오프라인">오프라인</option>
		                                <option value="" selected>없음</option>
                            		</c:when>
                            		<c:otherwise>
                            			<option>--온/오프라인--</option>
		                                <option value="온/오프라인">온/오프라인</option>
		                                <option value="온라인 할인">온라인 할인</option>
                                		<option value="오프라인">오프라인</option>
		                                <option value="">없음</option>
	                                </c:otherwise>
                                </c:choose>
                            </select></td>
                        </tr>
                         <tr>
                            <th><label for="cDiscount">할인금액</label></th>
                            <td><select id="cDiscount" name="cDiscount" required>
                            	<c:set var="discount" value="${ cardCardInfoVo.CDiscount}" />
                            	<c:choose>
                            		<c:when test="${ discount eq '1,500원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인" selected>1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '2천원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인" selected>2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '3천원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인" selected>3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '4천원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인" selected>천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '최대 4천원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인" selected>최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '2,4천원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인" selected>2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '3,5,9천원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인" selected>3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '1500~3천원 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인" selected>1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '15% 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인" selected>15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '20% 할인' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인" selected>20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq 'VIP 연6회 무료관람' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람" selected>VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
                            		</c:when>
                            		<c:when test="${ discount eq '' }">
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="" selected>없음</option>
                            		</c:when>
                            		<c:otherwise>
                            			<option value="">--할인금액--</option>
		                                <option value="1,500원 할인">1,500원 할인</option>
		                                <option value="2천원 할인">2천원 할인</option>
		                                <option value="3천원 할인">3천원 할인</option>
		                                <option value="4천원 할인">천원 할인</option>
		                                <option value="최대 4천원 할인">최대 4천원 할인</option>
		                                <option value="2,4천원 할인">2,4천원 할인</option>
		                                <option value="3,5,9천원 할인">3,5,9천원 할인</option>
		                                <option value="1500~3천원 할인">1500~3천원 할인</option>
		                                <option value="15% 할인">15% 할인</option>
		                                <option value="20% 할인">20% 할인</option>
		                                <option value="VIP 연6회 무료관람">VIP 연6회 무료관람</option>
		                                <option value="">없음</option>
	                                </c:otherwise>
                                </c:choose>
                            </select></td>
                        </tr> 
                    </tr>
                </Table>
            
                <div class="btns">
                    <input type="submit" value="수정하기" class="btn">
                    <input type="reset" value="다시쓰기" class="btn">
                    <input type="button" value="목록보기" class="btn" onclick="location.href = '/saleNotice/list?pageNum=${ pageNum }'">
                </div>
            </form>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
const maxFileCount = 1;  // 최대 첨부파일 갯수
var fileCount = 0;  // 현재 첨부된 파일 갯수
if ($('.delete-oldfile')) {
	fileCount = 1;
} else {
	fileCount = 0;
}
// [첨부파일 추가] 버튼을 클릭할 때
$('#btnAddFile').click(function () {

	if (fileCount >= maxFileCount) {
		alert('포스터는 최대 한개까지만 가능합니다.')
		return;
	}
	
	// 백틱 문자열 안에서 변수값을 표현할때는
	// \${}로 표현함
	var str = `
		<div>
			<input type="file" name="filename">
			<span class="delete-addfile">X</span>
		</div>
	`;

	$('div#newFileBox').append(str);
	
	fileCount++;
});


// 동적 이벤트 바인딩. 이벤트 바인딩 작업을 이미 존재하는 요소에게 위임하기.
// 이미 존재하는 div#newFileBox 요소에게
// 안쪽에 새로운 span.delete-addfile가 들어오면 클릭이벤트 연결하기
$('div#newFileBox').on('click', 'span.delete-addfile', function () {
	$(this).parent().remove();
	fileCount--;
});


// 정적 이벤트 바인딩. 기존 첨부파일에 삭제버튼을 눌렀을때
$('span.delete-oldfile').on('click', function () {
	// 현재 클릭한 요소의 직계부모(parent)의 앞(prev) 요소 
	$(this).parent().prev().prop('name', 'delfile');
	// 현재 클릭한 요소의 직계부모(parent)를 삭제. 현재요소안에 자식요소도 모두 삭제됨
	$(this).parent().remove();
	fileCount--;
});

</script>
</body>
</html>   





    