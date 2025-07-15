<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../../common/head.jsp" %>
</head>
<body>
<%@ include file="../../common/header.jsp" %>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
  <div class="border rounded-4 p-5 shadow" style="width: 100%; max-width: 677px; background-color: #fff;">
    <h3 class="text-center mb-4">비밀번호 변경</h3>

    <form action="${cp}/mypage/updatepw" method="post" class="d-flex flex-column gap-3">
      <div class="form-floating">
        <input type="password" class="form-control" id="currentPw" name="currentPw" placeholder="현재 비밀번호" required>
        <label for="currentPw">현재 비밀번호</label>
      </div>

      <div class="form-floating">
        <input type="password" class="form-control" id="newPw" name="newPw" placeholder="새 비밀번호" required>
        <label for="newPw">새 비밀번호</label>
      </div>

      <div class="form-floating">
        <input type="password" class="form-control" id="newPw2" name="newPw2" placeholder="새 비밀번호 확인" required>
        <label for="newPw2">새 비밀번호 확인</label>
      </div>

      <button type="submit" class="btn btn-primary w-100 py-2">비밀번호 변경</button>

      <c:if test="${param.success == '1'}">
        <div class="alert alert-success text-center mt-2 mb-0">비밀번호가 성공적으로 변경되었습니다.</div>
      </c:if>
      <c:if test="${param.error == '1'}">
        <div class="alert alert-danger text-center mt-2 mb-0">비밀번호가 일치하지 않거나 현재 비밀번호가 틀립니다.</div>
      </c:if>
    </form>
  </div>
</div>

</body>
</html>
