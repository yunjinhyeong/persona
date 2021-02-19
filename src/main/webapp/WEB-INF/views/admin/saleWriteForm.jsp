<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <form action="/saleNotice/write" method="post" enctype="multipart/form-data" name="frm">
                <input type="hidden" name="pageNum" value="${ pageNum }">
                <Table class="addMovieMain">
                    <tr>
                    	 <tr>
                            <th><label for="cKinds">카드종류</label></th>
                            <td><select name="cKinds" required>
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
                            </select></td>
                        </tr>
						<tr>
                            <th><label for="cName">카드이름</label></th>
                            <td><input type="text" name="cName" required></td>
                        </tr>
                         <tr>
							<th><label for="cImage">카드이미지</label></th>
							<td><input type="file" name="cImage" required></td>
						</tr>
						 <tr>
                            <th><label for="cSale">할인종류</label></th>
                            <td><select name="cSale" required>
                                <option>--할인종류--</option>
                                <option value="청구할인">청구할인</option>
                                <option value="현장할인">현장할인</option>
                                <option value="">없음</option>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="cOnoff">온/오프라인</label></th>
                            <td><select name="cOnoff" required>
                                <option>--온/오프라인--</option>
                                <option value="온/오프라인">온/오프라인</option>
                                <option value="온라인 할인">온라인 할인</option>
                                <option value="오프라인">오프라인</option>
                                <option value="">없음</option>
                            </select></td>
                        </tr>
                         <tr>
                            <th><label for="cDiscount">할인금액</label></th>
                            <td><select name="cDiscount" required>
                                <option>--할인금액--</option>
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
                            </select></td>
                        </tr>
                    </tr>
                </Table>


                <div class="btns">
                    <input type="submit" value="카드등록" class="btn">
                    <input type="reset" value="다시쓰기" class="btn">
                    <input type="button" value="목록보기" class="btn" onclick="location.href = '/saleNotice/list?pageNum=${ pageNum }'">
                </div>
            </form>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>





