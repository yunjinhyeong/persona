<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 영역 --%>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link href="/css/fileWMR.css" rel="stylesheet">
</head>
<body>
   <%-- header 영역 --%>
   <jsp:include page="/WEB-INF/views/include/navbar.jsp" />

   <article>

      <form action="/CS/replyWrite" method="post" name="frm">
      <input type="hidden" name="pageNum" value="${ pageNum }">
      <input type="hidden" name="reRef" value="${ reRef }">
      <input type="hidden" name="reLev" value="${ reLev }">
      <input type="hidden" name="reSeq" value="${ reSeq }">
      <table>
         <tr>
            <th class="borderTitle">작성자</th>
            <td class="borderBottom">
            	<input type="text" name="mid" value="${ sessionScope.id }" readonly>
            </td>
            <th class="borderTitle">문의자</th>
            <td class="borderBottom">
            	<input type="text" name="questioner" value="${ csMtmVo.questioner }" readonly>
            </td>
         </tr>
         <tr>
         	<th class="borderTitle">분류선택</th>
        		<td class="borderBottom">
					<input type="text" name="mquestion" value="${ csMtmVo.mquestion }">
				</td>
			<th class="borderTitle">문의종류</th>
			<td class="borderBottom">
				<input type="text" name="mkinds" value="${ csMtmVo.mkinds }">
			</td>
         </tr>
         <tr>
            <th class="borderTitle">글제목</th>
            <td class="borderBottom">
           		<input type="text" name="msubject" value="RE : ${ csMtmVo.msubject }에 대한 안내">
            </td>
         </tr>
         <tr>
            <th class="borderTitle">글내용</th>
            <td class="borderBottom"><textarea rows="13" cols="40" name="mcontents"></textarea></td>
         </tr>
      </table>

      <div class="btns">
         <input type="submit" value="답글쓰기" class="btn">
         <input type="reset" value="다시쓰기" class="btn">
         <input type="button" value="목록보기" class="btn" onclick="location.href='/CS/mtmNotice?pageNum=${ pageNum }'">
      </div>
      </form>

   </article>

   <%-- footer 영역 --%>
   <jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
