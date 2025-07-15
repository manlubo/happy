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
	                
				<div class="d-flex border rounded-3 list-group p-3 gap-3">
					<c:if test="${!(member.emailcheck) }">
					<form action="${cp}/member/email-auth" method="POST">
						<div class="form-floating input-group">
			                <input type="text" class="form-control" placeholder="이메일주소(이메일 수정 시 값 수정)" name="email" id="email" autocomplete="email" value="${member.email }">
			                <label for="email" style="z-index: 10;">이메일주소(이메일 수정 시 값 수정)</label>
			                <button class="btn btn-outline-primary" type="submit">재전송</button>
			            </div>
		            </form>
		            </c:if>
				</div>
                
            </div>
            <%@ include file="membermenu.jsp" %>	
        </main>
    </div>

<%@ include file="../../common/footer.jsp" %>
</body>
</html>