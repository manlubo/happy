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
					
					<form action="${cp}/mypage/updateinfo" method="post" class="d-flex flex-column gap-3" id="updateinfo">
					
    					<!-- 일반회원일 경우 -->
						<c:if test="${member.mtype != 'ORG'}">
						  <div class="form-floating">
						    <input type="text" class="form-control" placeholder="이름" name="name" id="name" value="${member.name}">
						    <label for="name">이름</label>
						  </div>
						  <div class="form-floating">
						    <input type="text" class="form-control" placeholder="닉네임" name="nickname" id="nickname" value="${member.nickname}">
						    <label for="nickname">닉네임</label>
						  </div>
						</c:if>
						
						<!-- 기관회원일 경우 -->
						<c:if test="${member.mtype == 'ORG'}">
						  <div class="form-floating">
						    <input type="text" class="form-control" placeholder="기관명" name="name" id="name" value="${member.name}">
						    <label for="name">기관명</label>
						  </div>
						</c:if>
            
			            
    					<div class="form-floating">
				            <input type="text" class="form-control" placeholder="전화번호" name="tel" id="tel" value="${member.tel}">
				            <label for="tel">전화번호</label>
			            </div>
						<div class="form-floating input-group">
								<input type="text" class="form-control" id="roadAddress" name="roadAddress" placeholder="도로명 주소 또는 지번 주소" readonly>
								<label for="roadAddress">도로명 주소 또는 지번 주소</label>
								<button class="btn btn-outline-primary" type="button" onclick="execDaumPostcode()">주소 검색</button>
								</div>

								<div id="detailAddressBox" class="form-floating" style="display: none;">
								<input type="text" class="form-control" id="detailAddress" name="detailAddress" placeholder="상세 주소">
								<label for="detailAddress">상세 주소</label>
								</div>
					    <input type="hidden" name="location" id="location" value="">
					    <button type="submit" class="btn btn-primary mt-3 w-100">수정하기</button>
					</form>
		           
				</div>
                
            </div>
            <%@ include file="membermenu.jsp" %>	
        </main>
    </div>

<%@ include file="../../common/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        $('#roadAddress').val(data.roadAddress);
        $('#detailAddressBox').slideDown();
        $('#detailAddress').focus();
      }
    }).open();
  }

  $(function() {
    $('#updateinfo').submit(function(e) {
      e.preventDefault();

      var road = $('#roadAddress').val();
      var detail = $('#detailAddress').val();
      $('#location').val(road + ' ' + detail);

      this.submit();
    });
  });

</script>
</body>
</html>