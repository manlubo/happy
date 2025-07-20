<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../../common/head.jsp" %>
</head>
<body>
<%@ include file="../../common/header.jsp" %>
<div class="container px-0">
  <main class="row justify-content-between mx-0">
    <div class="col-lg-8 px-0" style="max-width: 700px;">

      <div class="d-flex border rounded-3 list-group p-3 gap-3">

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

          <button type="submit" class="btn btn-primary w-100 py-2" onclick="return confirm('비밀번호를 변경하시겠습니까?');">비밀번호 변경</button>
        </form>

      </div>

    </div>
    <%@ include file="membermenu.jsp" %>
  </main>
</div>

<script>
  $("form").on("submit", function(e){
    e.preventDefault();
    if($("#newPw").val() != $("#newPw2").val()){
      return alert("변경하실 비밀번호가 일치하지 않습니다.");
    }
    $(this).off("submit").submit();
  })
</script>
</body>
</html>
