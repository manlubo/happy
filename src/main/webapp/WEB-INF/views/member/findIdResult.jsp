<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기 결과</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    .custom-radio {
      width: 18px;
      height: 18px;
      border-radius: 50%;
      border: 1px solid #ccc;
      position: relative;
      display: inline-block;
      background-color: #fff;
      cursor: pointer;
    }
    input[type="radio"] {
      display: none;
    }
    input[type="radio"]:checked + .custom-radio::before {
      content: "✓";
      color: #0077FF;
      font-weight: 700;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      font-size: 12px;
    }
  </style>
  <%@ include file="../common/head.jsp" %>
</head>

<body>
<%@ include file="../common/header.jsp" %>
<main>
  <!-- 전체 중앙 정렬 -->
  <div class="d-flex flex-column justify-content-center align-items-center min-vh-100">

    <!-- 제목은 박스 밖으로 -->
    <h3 class="fw-bold mb-4">아이디 찾기 결과</h3>

    <!--결과 없음 -->
    <c:if test="${empty memberList}">
      <div class="bg-white border rounded-3 p-4 shadow-sm text-center">
        해당 정보로 검색된 아이디가 없습니다.
      </div>
    </c:if>

    <!--결과 있을 때 반복 출력 -->
    <c:if test="${not empty memberList}">
      <div class="bg-white border rounded-3 p-4 shadow-sm" style="max-width: 500px; width: 100%;">
        <p class="text-center text-secondary mb-4">해당 정보로 검색된 아이디</p>

        <c:forEach var="m" items="${memberList}" varStatus="status">
          <div class="d-flex align-items-center justify-content-between mb-3">
            <div class="d-flex align-items-center">
              <input type="radio" name="idChoice" id="id${status.index}" />
              <label for="id${status.index}" class="custom-radio me-2"></label>
              <span class="text-primary fw-semibold me-1">[<c:out value="${m.mtype eq 'USER' ? '일반' : '기관'}" />]</span>
              <span class="text-dark"><c:out value="${m.id}" /></span>
            </div>
            <div class="text-secondary small">
              <fmt:formatDate value="${m.regdate}" pattern="yy.MM.dd" /> 가입
            </div>
          </div>
        </c:forEach>

        <!-- 버튼들 -->
        <a href="${pageContext.request.contextPath}/member/find-pw" class="btn btn-outline-primary w-100 mb-2">비밀번호 찾기</a>
        <a href="${pageContext.request.contextPath}/member/login?mtype=USER" class="btn btn-primary w-100">로그인</a>
      </div>
    </c:if>

  </div>
</main>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
