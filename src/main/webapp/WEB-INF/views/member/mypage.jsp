<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>

<div class="container px-0">
    <main class="row justify-content-between mx-0">
    
        <!-- 좌측 메인 영역 -->
        <div class="col-lg-8 px-0" style="max-width: 700px;">
        
            <c:choose>
                <c:when test="${param.page == 'update-info'}">
                    <jsp:include page="mypage/updateinfo.jsp" />
                </c:when>
                
                 <c:when test="${param.page == 'update-password'}">
			        <jsp:include page="mypage/updatepw.jsp" />
			    </c:when>
                
                <c:otherwise>
                    <!-- 기본 메인 화면 구성 -->
                    <div class="border rounded-4 bg-white p-4 shadow-sm d-flex justify-content-between align-items-start" style="min-height: 180px;">
                        <p class="text-muted">어서 오세요!! 마이페이지입니다. 좌측에서 메뉴를 선택해주세요.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        
        </div>

        <!--  우측 고정 메뉴 -->
        <%@ include file="mypage/membermenu.jsp" %>

    </main>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
