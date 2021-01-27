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
            <form action="/eventNotice/modify" method="post" enctype="multipart/form-data" name="frm">
                <input type="hidden" name="pageNum" value="${ pageNum }">
                <input type="hidden" name="eNum" value="${ eventVo.ENum }">
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
                            <td><input type="text" name="eTitle" value="${ eventVo.ETitle }" required></td>
                        </tr>
						
						<tr>
							<th><label for="eImg">이벤트포스터</label></th>
							<td class="borderBottom">
								<div id="oldFileBox">
																					
									<c:forEach var="eventPoster" items="${ eventPosterList }">
										<input type="hidden" name="oldfile" value="${ eventPoster.num }">
										<div>
											${ eventPoster.filename }
											<span class="delete-oldfile">X</span>
										</div>	
									</c:forEach>
									
								</div>
								<div id="newFileBox"></div>
								<input type="button" id="btnAddFile" value="첨부파일 추가">
							</td>
						</tr>    
						
                        <tr>
                            <th><label for="startDate">시작일자</label></th>
                            <td><input type="date" name="startDate" value="${ eventVo.startDate }" required></td>
                        </tr>
                        <tr>
                            <th><label for="endDate">종료일자</label></th>
                            <td><input type="date" name="endDate" value="${ eventVo.endDate }" required></td>
                        </tr>
                    </tr>
                </Table>
            
                <div class="btns">
                    <input type="submit" value="수정하기" class="btn">
                    <input type="reset" value="다시쓰기" class="btn">
                    <input type="button" value="목록보기" class="btn" onclick="location.href = '/eventNotice/list?pageNum=${ pageNum }'">
                </div>
            </form>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
const maxFileCount = 1;  // 최대 첨부파일 갯수
var fileCount = ${ fn:length(eventPosterList) };  // 현재 첨부된 파일 갯수

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





    