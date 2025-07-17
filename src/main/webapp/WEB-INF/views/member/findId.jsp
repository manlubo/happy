<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- 사용자 정의 스타일 -->
  <%@ include file="../common/head.jsp" %>

  <style>
    main {
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      padding: 40px 20px;
      background-color: #fff;
    }

    .form-box {
      background: #fff;
      border: 1px solid #E0E0E0;
      border-radius: 10px;
      padding: 32px;
      width: 100%;
      max-width: 500px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
    }

    h2 {
      font-weight: 600;
      color: #333;
      margin-bottom: 32px;
    }

  </style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
  <main>
    <h2 class="text-center">아이디 찾기</h2>

    <div class="form-box">
      <form method="POST" action="${pageContext.request.contextPath}/member/find-id">
        <!-- 이메일 -->
        <div class="form-floating mb-3">
          <input type="email" class="form-control" id="floatingEmail" name="email" placeholder="이메일" required>
          <label for="floatingEmail">이메일</label>
        </div>

        <!-- 이름 -->
        <div class="form-floating mb-4">
          <input type="text" class="form-control" id="floatingName" name="name" placeholder="이름" required>
          <label for="floatingName">이름</label>
        </div>

        <!-- 버튼 -->
        <button type="submit" class="btn btn-primary w-100">아이디 찾기</button>
      </form>
    </div>
  </main>
<%@ include file="../common/footer.jsp" %>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
