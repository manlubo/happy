<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
    <h2>이메일 인증에 실패했습니다.</h2>
    <p>유효하지 않거나 만료된 인증 링크입니다.</p>
    <a href="/member/login.jsp">로그인 페이지로 이동</a>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
