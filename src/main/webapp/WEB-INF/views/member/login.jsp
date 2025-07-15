<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div class="container px-0">
       <main>
        <h2 class="text-center">로그인</h2>
				<c:if test="${param.reset == 'success'}">
				    <div class="alert alert-success text-center">
				        비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요.
				    </div>
				</c:if>				        
        <div class="d-flex border rounded-3 mx-auto mt-5" style="max-width: 460px;">
          <a href="${cp }/member/login?mtype=USER" class="flex-grow-1 btn ${mtype == 'USER' ? 'btn-primary' : ''}">일반회원</a>
          <a href="${cp }/member/login?mtype=ORG" class="flex-grow-1 btn ${mtype == 'ORG' ? 'btn-primary' : ''}">기관회원</a>
        </div>
        <form method="POST" class="d-flex flex-column mx-auto my-5 gap-4" style="max-width: 460px;">

            <div class="d-flex border rounded-3 list-group p-3 gap-3">
              <div class="form-floating">
                <input type="text" class="form-control" placeholder="아이디" name="id" id="id">
                <label for="id">아이디</label>
              </div>
  
              <div class="form-floating">
                <input type="password" class="form-control" placeholder="비밀번호" name="pw" id="pw">
                <label for="pw">비밀번호</label>
              </div>
              <div class="form-check form-switch">
				 <input class="form-check-input" type="checkbox" id="autologin" name="autologin" value="yes" checked>
				<label class="form-check-label" for="autologin">자동로그인</label>
				</div>
				
				
				
				
			</div>
			<%-- <c:if test="${mtype = 'ADMIN'}">
            <input type="hidden" name="mtype" value="ADMIN">
			</c:if>
			<c:if test="${mtype = 'USER'}">
            <input type="hidden" name="mtype" value="USER">
			</c:if>
			<c:if test="${mtype = 'ORG'}">
            <input type="hidden" name="mtype" value="ORG">
			</c:if> --%>
			<input type="hidden" name="mtype" value="${mtype}">
			
			
			      <button class="btn btn-primary btn-lg w-100">로그인</button>
			      <a href="${cp}/member/register?mtype=${mtype}" class="btn btn-outline-primary w-100 mt-2">
					   회원가입
					</a>
          
        </form>
      </main>
       
    </div>
<%@ include file="../common/footer.jsp" %>
<script>
        const swiper = new Swiper('.swiper', {
        // Optional parameters
        // direction: 'vertical',
        loop: true,

        // If we need pagination
        pagination: {
            el: '.swiper-pagination',
        },
    });
    </script>
</body>
</html>