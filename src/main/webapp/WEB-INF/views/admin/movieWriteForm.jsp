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
            <form action="/movieNotice/write" method="post" enctype="multipart/form-data" name="frm">
                <input type="hidden" name="pageNum" value="${ pageNum }">
                <Table class="addMovieMain">
                    <tr>
                        <tr>
                            <th><label for="theater">상영관</label></th>
                            <td><select name="theater" required>
                                <option>--관--</option>
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="rank">시청등급</label></th>
                            <td><select name="rank" required>
                                <option>--등급--</option>
                                <option value="전체">전체</option>
                                <option value="07">7</option>
                                <option value="12">12</option>
                                <option value="15">15</option>
                                <option value="19">19</option>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="mName">영화제목</label></th>
                            <td><input type="text" name="mName" required></td>
                        </tr>
                        <tr>
							<th><label for="mImg">영화포스트</label></th>
							<td><input type="file" name="mImgTrailer" required></td>
						</tr>
                        <tr>
                            <th><label for="mScore">영화평점</label></th>
                            <td><select name="mScore" required>
                                <option>--평점--</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                            </select></td>                            
                        </tr>
                        <tr>
                            <th><label for="mRate">영화예매율</label></th>
                            <td><input type="number" name="mRate" min="0" max="100" placeholder="(%)생략" required></td>
                        </tr>
                        <tr>
                            <th><label for="mGenre">영화장르</label></th>
                            <td><select name="mGenre" required>
                                <option>--장르--</option>
                                <option value="액션">액션</option>
                                <option value="코미디">코미디</option>
                                <option value="드라마">드라마</option>
                                <option value="범죄,스릴러">범죄,스릴러</option>
                                <option value="SF,판타지">SF,판타지</option>
                                <option value="로맨틱 코미디">로맨틱 코미디</option>
                                <option value="애니메이션">애니메이션</option>
                                <option value="공포">공포</option>
                                <option value="사극,시대극">사극,시대극</option>
                                <option value="성인,에로">성인,에로</option>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="mRuntime">상영시간</label></th>
                            <td><input type="number" name="mRuntime" min="0" max="1000" placeholder="(분)생략" required></td>
                        </tr>
                        <tr>
                            <th><label for="mDirector">감독</label></th>
                            <td><input type="text" name="mDirector" required></td>
                        </tr>
                        <tr>
                            <th><label for="mActor">배우</label></th>
                            <td><input type="text" name="mActor" placeholder="여러명일경우 ,로 구분" required></td>
                        </tr>
                        <tr>
                            <th><label for="mStart">극장개봉일자</label></th>
                            <td><input type="date" name="mStart" required></td>
                        </tr>
                        <tr>
                            <th><label for="mEnd">극장종료일자</label></th>
                            <td><input type="date" name="mEnd" required></td>
                        </tr>
                        <tr>
							<th><label for="mTrailer">영화트레일러</label></th>
							<td><input type="file" name="mImgTrailer" required></td>
						</tr>
                    </tr>
                </Table>
            
                <div class="btns">
                    <input type="submit" value="영화등록" class="btn">
                    <input type="reset" value="다시쓰기" class="btn">
                    <input type="button" value="목록보기" class="btn" onclick="location.href = '/movieNotice/list?pageNum=${ pageNum }'">
                </div>
            </form>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>   





    