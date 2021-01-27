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
            <form action="/eventNotice/write" method="post" enctype="multipart/form-data" name="frm">
                <input type="hidden" name="pageNum" value="${ pageNum }">
                <Table class="addMovieMain">
                    <tr>
                        <tr>
                            <th><label for="eSection">섹션</label></th>
                            <td><select name="eSection" required>
                                <option>--섹션--</option>
                                <option value="영화">영화</option>
                                <option value="시사회/무대인사">시사회/무대인사</option>
                                <option value="HOT">HOT</option>
                                <option value="제휴할인">제휴할인</option>
                            </select></td>
                        </tr>
                        <tr>
                            <th><label for="eTitle">이벤트제목</label></th>
                            <td><input type="text" name="eTitle" required></td>
                        </tr>
                        <tr>
							<th><label for="eImg">이벤트포스터</label></th>
							<td><input type="file" name="filename" required></td>
						</tr>
                        <tr>
                            <th><label for="startDate">시작일자</label></th>
                            <td><input type="date" name="startDate" required></td>
                        </tr>
                        <tr>
                            <th><label for="endDate">종료일자</label></th>
                            <td><input type="date" name="endDate" required></td>
                        </tr>
                    </tr>
                </Table>
            
                <div class="btns">
                    <input type="submit" value="이벤트등록" class="btn">
                    <input type="reset" value="다시쓰기" class="btn">
                    <input type="button" value="목록보기" class="btn" onclick="location.href = '/eventNotice/list?pageNum=${ pageNum }'">
                </div>
            </form>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>   





    