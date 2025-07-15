<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  <%-- 날짜 포맷용 --%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../../common/head.jsp" %>
</head>

<body>
<%@ include file="../common/header.jsp" %>

<div class="container px-0">
  <main class="d-flex justify-content-between mx-0">
    <div class="col-lg-9 px-0" style="max-width: 880px; width:100%;">
      <h3 class="my-4">기관 회원 승인</h3>
      <table class="table table-hover table-bordered text-center align-middle">
        <thead class="table-light">
          <tr>
            <th>회원번호</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>가입일</th>
            <th colspan="2">처리</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="member" items="${pendingList}">
            <tr>
              <td>${member.mno}</td>
              <td>${member.id}</td>
              <td>${member.email}</td>
              <td><fmt:formatDate value="${member.regdate}" pattern="yyyy년 M월 d일" /></td>

              <!-- 승인 -->
              <td>
                <form method="post" action="${cp}/admin/member/orgapprove">
                  <input type="hidden" name="mno" value="${member.mno}" />
                  <input type="hidden" name="appr" value="1" />
                  <button type="submit" class="btn btn-success btn-sm">승인</button>
                </form>
              </td>

              <!-- 거절 -->
              <td>
                <form method="post" action="${cp}/admin/member/orgapprove" class="d-flex align-items-center">
                  <input type="hidden" name="mno" value="${member.mno}" />
                  <input type="hidden" name="appr" value="0" />
                  <input type="text" name="reason" class="form-control form-control-sm me-2" placeholder="거절 사유" required style="width: 120px;" />
                  <button type="submit" class="btn btn-danger btn-sm">거절</button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <%@ include file="../common/adminmenu.jsp" %>
  </main>
</div>

<%@ include file="../../common/footer.jsp" %>
</body>
</html>
