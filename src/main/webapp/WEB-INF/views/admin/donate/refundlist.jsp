<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/head.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.7/js/bootstrap.min.js" integrity="sha512-zKeerWHHuP3ar7kX2WKBSENzb+GJytFSBL6HrR2nPSR1kOX1qjm+oHooQtbDpDBSITgyl7QXZApvDfDWvKjkUw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.7/css/bootstrap.min.css" integrity="sha512-fw7f+TcMjTb7bpbLJZlP8g2Y4XcCyFZW8uy8HsRZsH/SwbMw0plKHFHr99DN3l04VsYNwvzicUX/6qurvIxbxw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<%@ include file="../common/head.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.7/js/bootstrap.bundle.min.js" integrity="sha512-Tc0i+vRogmX4NN7tuLbQfBxa8JkfUSAxSFVzmU31nVdHyiHElPPy2cWfFacmCJKw0VqovrzKhdd2TSTMdAxp2g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div class="container px-0">

	<main class="d-flex justify-content-between mx-0">
            <div class="px-0" style="max-width: 860px; width:100%;">
              <div>
				<ul class="list-group small">
				<li class="list-group-item ">
					<div class="row my-0 align-items-center">
					<span class="col-2 text-center fw-bold">결제번호</span>
					<span class="col-2 text-center fw-bold">상태</span>
					<span class="col text-center fw-bold">결과메세지</span>
					<span class="col-2 text-center fw-bold">변경주체</span>
					<span class="col-2 text-center fw-bold">생성일</span>
					</div>
				</li>
				<c:forEach items="${logs }" var="l">
				<li class="list-group-item">
					<div class="row my-0 align-items-center">
						<span class="col-2 text-center">${l.pno }</span>
						<span class="col-2 text-center">${l.paystatus }</span>
						<span class="col text-center">${l.result }</span>
						<span class="col-2 text-center">${l.mtype }</span>
						<span class="col-2 text-center">${l.moddate }</span>
					</div>
				</li>
				</c:forEach>
				</ul>

			</div>
          </div>

            <%@ include file="../common/adminmenu.jsp" %>
            
        </main>
</div>



                
               
        <%@ include file="../../common/footer.jsp" %>
        
<script>
$(".btnRefund").on("click", function () {
    const paymentId = $(this).data("uuid");
    const amount = $(this).data("amount");

    if (!confirm("정말로 이 결제를 환불하시겠습니까?")) return;

    $.ajax({
      url: "${cp}/api/payment/refund",
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify({ 
    	  paymentId: paymentId,
    	  amount: amount
      }),
      success: function (res) {
        alert(res.msg || "환불이 완료되었습니다.");
        location.reload();
      },
      error: function (xhr) {
        const msg = xhr.responseJSON?.msg || "환불 요청에 실패했습니다.";
        alert("오류: " + msg);
      }
    });
  });

</script>
</body>
</html>