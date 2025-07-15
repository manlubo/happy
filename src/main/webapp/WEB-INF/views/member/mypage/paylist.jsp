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
								<span class="col-2 text-center fw-bold">결제수단</span>
								<span class="col text-center fw-bold">금액</span>
								<span class="col-2 text-center fw-bold">결제 일자</span>
								<span class="col-2 text-center fw-bold">상태</span>
							</div>
						</li>
						<c:forEach items="${pays }" var="p">
							<li class="list-group-item">
								<div class="row my-0 align-items-center">
									<span class="col-2 text-center">${p.paytype }</span>
									<span class="col text-center"><fmt:formatNumber value="${p.payamount}" />원</span>
									<span class="col-2 text-center">${p.voiddate != null ? p.voiddate : p.regdate}</span>
									<span class="col-2 text-center">${p.paystatus }</span>
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