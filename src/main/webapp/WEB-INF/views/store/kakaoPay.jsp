<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
    $(function(){
        var IMP = window.IMP;
        IMP.init('imp94763488');
        var msg;

        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '${ orderStoreVo.name }',
            amount : '${ orderStoreVo.total }',
            buyer_name : '${ memberVo.name }',
            buyer_postcode : '${ memberVo.postcode }',
            buyer_email : '${ memberVo.email }',
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
            	alert("결제가 완료되었습니다.");
                location.href='/store/kakaoPay?id=${ memberVo.id }&name=${ orderStoreVo.name }&price=${ orderStoreVo.price }&content=${ orderStoreVo.content }&count=${ orderStoreVo.count }&total=${ orderStoreVo.total }';
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                location.href=history.back();
                alert(msg);
            }
        });

    });
    </script>
</body>
</html>