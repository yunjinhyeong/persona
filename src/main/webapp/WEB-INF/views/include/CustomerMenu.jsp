<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/CustomerMenu.css" rel="stylesheet" type="text/css" media="all">
</head>
<body>
   <table class="wrap">
      <tr>
         <td><a href="/CS/CustomerService">FAQ</a></td>
         <td><a href="/CS/CustomerNotice">공지사항</a></td>
         <c:choose>
            <c:when test="${ sessionScope.id ne 'admin' && not empty sessionScope.id }">
               <td>
                  <a href="/CS/CSmtm">1:1문의</a>
               </td>
            </c:when>
            <c:when test="${ sessionScope.id eq 'admin' }">
               <td>
                  <a href="/CS/mtmNotice">1:1문의</a>
               </td>
            </c:when>
            <c:otherwise>
               <td>
                  <a href="/member/loginjoin">1:1문의(로그인 필요)</a>
               </td>
            </c:otherwise>
         </c:choose>
      </tr>
   </table>

</body>
</html>