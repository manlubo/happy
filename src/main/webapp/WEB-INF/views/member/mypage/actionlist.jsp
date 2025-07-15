<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
				<div>
					<ul class="list-group small">
						<li class="list-group-item ">
							<div class="row my-0 align-items-center">
								<span class="col-2 text-center fw-bold">기부한 기관 명</span>
								<span class="col text-center fw-bold">기부한 게시글</span>
								<span class="col-2 text-center fw-bold">기부 금액</span>
								<span class="col-2 text-center fw-bold">기부일</span>
							</div>
						</li>
						<c:forEach items="${actions }" var="a">
							<li class="list-group-item">
								<div class="row my-0 align-items-center">
									<span class="col-2 text-center">${a.orgname }</span>
									<span class="col text-center text-truncate"><a href="${cp }/board/view?bno=${a.bno}" class="text-black" target="_black">${a.title }</a></span>
									<span class="col-2 text-center"><fmt:formatNumber value="${a.amount}" />원</span>
									<span class="col-2 text-center">${a.regdate }</span>
								</div>
							</li>
						</c:forEach>
					</ul>

				</div>

                
            </div>
            <%@ include file="membermenu.jsp" %>	
        </main>
    </div>

<%@ include file="../../common/footer.jsp" %>
</body>
</html>