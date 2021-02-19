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
            <form action="/watchMovie/write" method="post" name="frm">
                <input type="hidden" name="pageNum" value="${ pageNum }">
                <Table class="addMovieMain">
                    <tr>
                        <tr>
                            <th><label for="name">영화제목</label></th>
                            <td><input type="text" name="name" required></td>
                        </tr>
                        <tr>
                            <th><label for="area">상영지역</label></th>
                            <td><select name="area" required>
                                <option>--상영지역--</option>
                                <option value="서울">서울</option>
                                <option value="부산">부산</option>
                                <option value="대구">대구</option>
                                <option value="인천">인천</option>
                                <option value="광주">광주</option>
                                <option value="대전">대전</option>
                                <option value="울산">울산</option>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="date">상영일자</label></th>
                            <td><input type="datetime-local" name="date" required></td>
                        </tr>
                        <tr>
                            <th><label for="theater">상영관</label></th>
                            <td><select name="theater" required>
                                <option>--상영관--</option>
                                <option value="A관">A관</option>
                                <option value="B관">B관</option>
                                <option value="C관">C관</option>
                                <option value="D관">D관</option>
                                <option value="E관">E관</option>
                            </select></td>
                        </tr>
                    </tr>
                </Table>
            
                <div class="btns">
                    <input type="submit" value="상영영화등록" class="btn">
                    <input type="reset" value="다시쓰기" class="btn">
                    <input type="button" value="목록보기" class="btn" onclick="location.href = '/watchMovie/list?pageNum=${ pageNum }'">
                </div>
            </form>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>   





    