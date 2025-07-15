<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>

		<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
		  <div class="border rounded-4 p-5 shadow" style="width: 100%; max-width: 500px; background-color: #fff;">
		    <h3 class="text-center mb-4">비밀번호 찾기</h3>
		    
		<form action="${cp}/member/send-reset-mail" method="post" class="d-flex flex-column gap-3">
		  <div class="form-floating">
		    <input type="text" class="form-control" id="id" name="id" placeholder="아이디" required>
		    <label for="id">아이디</label>
		  </div>
		
		  <div class="form-floating">
		    <input type="email" class="form-control" id="email" name="email" placeholder="이메일" required>
		    <label for="email">이메일</label>
		  </div>
		
		  <button type="submit" class="btn btn-primary w-100 py-2">인증 메일 보내기</button>
		
		  <!--에러 메시지 -->
		  <c:if test="${param.error == '1'}">
		    <div class="alert alert-danger text-center mt-2 mb-0">아이디와 이메일이 일치하지 않습니다.</div>
		  </c:if>
		  <c:if test="${param.error == 'invalidEmail'}">
		    <div class="alert alert-warning text-center mt-2 mb-0">올바른 이메일 형식을 입력해주세요.</div>
		  </c:if>
		
		  <!--성공 메시지 -->
		  <c:if test="${sent}">
		    <div class="alert alert-success text-center mt-2 mb-0">
		      인증 메일이 발송되었습니다. 5분 안에 확인해주세요.
		    </div>
  </c:if>
</form>

  </div>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
