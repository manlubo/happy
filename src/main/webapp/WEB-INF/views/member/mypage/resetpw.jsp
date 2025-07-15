<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/head.jsp" %>
</head>
<body>
<%@ include file="../../common/header.jsp" %>

<div class="container mt-5" style="max-width: 600px;">
    <h3 class="mb-4">비밀번호 재설정</h3>

    <c:if test="${param.error == '1'}">
        <div class="alert alert-danger">비밀번호가 일치하지 않습니다.</div>
    </c:if>
    <c:if test="${param.error == 'expired'}">
        <div class="alert alert-warning">인증 시간이 만료되었습니다. 다시 시도해주세요.</div>
    </c:if>

   <form action="<c:url value='/member/resetpw' />" method="post" class="d-flex flex-column gap-3">
        <!-- 숨겨진 uuid -->
        <input type="hidden" name="uuid" value="${uuid}">

        <div class="form-floating">
            <input type="password" class="form-control" name="pw" id="pw" placeholder="새 비밀번호" required>
            <label for="pw">새 비밀번호</label>
        </div>

        <div class="form-floating">
            <input type="password" class="form-control" name="pw2" id="pw2" placeholder="비밀번호 확인" required>
            <label for="pw2">비밀번호 확인</label>
        </div>

        <button type="submit" class="btn btn-primary w-100">비밀번호 변경</button>
    </form>
</div>

</body>
 <%@ include file="../../common/footer.jsp" %> 
</html>
