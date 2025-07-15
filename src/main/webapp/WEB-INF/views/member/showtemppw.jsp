<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>


<div style="min-height: calc(100vh - 285px); display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <div style="width: 100%; max-width: 600px;">
  

    <h3 class="mb-4" style="text-align: center; font-weight: 600; font-size: 1.8rem;">임시 비밀번호 발급 완료</h3>
    
    <p style="text-align: center;">아래 임시 비밀번호로 로그인한 후 마이페이지에서 꼭 새 비밀번호로 변경해주세요.</p>
    
   
    <div class="alert alert-primary fw-bold fs-5 text-center" id="tempPwBox">${tempPw}</div>

 
    <div class="text-center">
      <button class="btn btn-outline-secondary btn-sm mt-1" onclick="copyPw()">비밀번호 복사</button>
    </div>

    <div class="text-center mt-3">
      <a href="${cp}/member/login" class="btn btn-primary">로그인하러 가기</a>
    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
  function copyPw() {
    const pw = document.getElementById("tempPwBox").textContent;
    navigator.clipboard.writeText(pw).then(() => {
      alert("임시 비밀번호가 복사되었습니다.");
    });
  }
</script>
</body>
</html>
