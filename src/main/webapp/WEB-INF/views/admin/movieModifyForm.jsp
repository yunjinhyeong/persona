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
            <form action="/movieNotice/modify" method="post" enctype="multipart/form-data" name="frm">
                <input type="hidden" name="pageNum" value="${ pageNum }">
                <input type="hidden" name="mNum" value="${ movieVo.MNum }">
                <input type="hidden" name="mScore" value="${ movieVo.MScore }">
                <input type="hidden" name="mRate" value="${ movieVo.MRate }">
                <Table class="addMovieMain">
                    <tr>
                        <tr>
                            <th><label for="mRank">시청등급</label></th>
                            <td><select name="mRank" required>
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
                            <td><input type="text" name="mName" value="${ movieVo.MName }" required></td>
                        </tr>


                        <tr>
							<th><label for="mImgTrailer">포스트</label></th>
							<td class="borderBottom">
								<div id="oldFileBox">

									<c:forEach var="mImgTrailer" items="${ mImgTrailerList }">
										<input type="hidden" name="oldfile" value="${ mImgTrailer.num }">
										<div>
											${ mImgTrailer.filename }
											<span class="delete-oldfile">X</span>
										</div>
									</c:forEach>

								</div>
								<div id="newFileBox"></div>
								<input type="button" id="btnAddFile" value="첨부파일 추가">
							</td>
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
                            <td><input type="number" name="mRuntime" min="0" max="1000" value="${ movieVo.MRuntime }" required></td>
                        </tr>
                        <tr>
                            <th><label for="mDirector">감독</label></th>
                            <td><input type="text" name="mDirector" value="${ movieVo.MDirector }" required></td>
                        </tr>
                        <tr>
                            <th><label for="mActor">배우</label></th>
                            <td><input type="text" name="mActor" value="${ movieVo.MActor }" required></td>
                        </tr>
                        <tr>
                            <th><label for="mStory">줄거리</label></th>
                            <td><textarea name="mStory" cols="60" rows="10" required>${ movieVo.MStory }</textarea></td>
                        </tr>
                    </tr>
                </Table>

                <div class="btns">
                    <input type="submit" value="수정하기" class="btn">
                    <input type="reset" value="다시쓰기" class="btn">
                    <input type="button" value="목록보기" class="btn" onclick="location.href = '/movieNotice/list?pageNum=${ pageNum }'">
                </div>
            </form>
        </div>
    </div>
	<%-- footer 영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="/script/jquery-3.5.1.js"></script>
<script>
const maxFileCount = 2;  // 최대 첨부파일 갯수
var fileCount = ${ fn:length(mImgTrailerList) };  // 현재 첨부된 파일 갯수

// [첨부파일 추가] 버튼을 클릭할 때
$('#btnAddFile').click(function () {

	if (fileCount >= maxFileCount) {
		alert('파일은 포스터 트레일러 각 최대 한개까지만 가능합니다.')
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





