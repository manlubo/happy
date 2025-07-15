<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>

<div class="container px-0">
    <main class="d-flex justify-content-between mx-0">
        <!-- 본문 -->
        <div class="px-0" style="max-width: 860px; width:100%;">
            <h3 class="fw-bold mb-4" style="color: var(--col-6); font-size: 20px;">기관회원 승인 이력</h3>

            <table class="table table-bordered text-center align-middle">
                <thead style="background-color: var(--bg-1); color: var(--col-6);">
                <tr>
                    <th>회원번호</th>
                    <th>아이디</th>
                    <th>이메일</th>
                    <th>승인여부</th>
                    <th>거절사유</th>
                    <th>처리일시</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="log" items="${logs}">
                    <tr>
                        <td>${log.mno}</td>
                        <td>${log.id}</td>
                        <td>${log.email}</td>
                        <td>
                            <c:choose>
                                <c:when test="${log.appr == 1}">
                                    <span class="badge rounded-pill" style="background-color: #32D28B; color: white;">승인</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge rounded-pill" style="background-color: #F45E5E; color: white;">거절</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${log.appr == 0}">
                                ${log.reason}
                            </c:if>
                        </td>
                        <td>
                            <fmt:formatDate value="${log.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 사이드바 -->
        <%@ include file="../common/adminmenu.jsp" %>
    </main>
</div>

<%@ include file="../../common/footer.jsp" %>
</body>
</html>
