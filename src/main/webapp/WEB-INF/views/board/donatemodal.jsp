<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.portone.io/v2/browser-sdk.js" async defer></script>
<!-- The Modal -->
<div class="modal" id="donatePay">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title fs-5 fw-bold">기부하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body d-flex flex-column gap-3">
      	<p class="fs-6 fw-semibold m-0">${board.title}</p>
      	<hr class="m-0">
        <c:if test="${empty member}">
        <form action="" class="d-flex flex-column gap-3">
          <div class="form-floating">
            <input type="text" class="form-control" placeholder="이름" name="name" id="name" autocomplete="name">
            <label for="name">이름</label>
          </div>
          <div class="form-floating input-group">
            <input type="text" class="form-control" placeholder="이메일주소 (비밀번호 찾기 등 본인 확인용)" name="email" id="email" autocomplete="email">
            <label for="email" style="z-index: 10;">이메일주소 (비밀번호 찾기 등 본인 확인용)</label>
            <button class="btn btn-outline-primary" id="emailckplz">인증번호 받기</button>
          </div>
        </form>
        </c:if>
        <c:if test="${not empty member}">
        <div class="form-floating flex-grow-1">
          <input type="number" class="form-control" placeholder="기부할 금액 입력(최소 100,000원부터 1000원 단위)" name="amount" id="amount" min="100000" max="100000000" step="1000" required>
          <label for="amount">기부할 금액 입력(최소 100,000원부터 1000원 단위)</label>
        </div>
        </c:if>
      </div>

      <!-- Modal footer -->
      <c:if test="${not empty member}">
      <div class="modal-footer">
        <button type="button" class="btn btn-primary form-control" id="checkOutBtn">기부하기</button>
      </div>
	  </c:if>
    </div>
  </div>
</div>

<script>
  let amount = "";
  $("#amount").on("keyup", function(){
    
    amount = $(this).val();
    
  })
  
  
  
</script>

<script> 
	let donate = null;
    async function loadDonate() {
      const res = await fetch("${cp}/api/donate?bno=${board.bno}");
      donate = await res.json();
      return donate;
    }
	
    async function requestPayment(donate) {
		const paymentId = 'payment-' + crypto.randomUUID();
		console.log(paymentId);
		  
	    const result = await PortOne.requestPayment({
	        storeId: donate.storeId,
	        channelKey: donate.channelKey,
	        paymentId: paymentId,
	        orderName: donate.board.title,
	        totalAmount: amount / 1000,
	        currency: "CURRENCY_KRW",
	        payMethod: "CARD",
	        customData: {
	          mno: "${member.mno}",
	          drno: donate.board.round.drno
	        }
	      });
	
	    if (result.code !== undefined) {
	    	  if (result.paymentId) {
	    	    await fetch("${cp}/api/payment/complete", {
	    	      method: "POST",
	    	      headers: {
	    	        "Content-Type": "application/json"
	    	      },
	    	      body: JSON.stringify({ paymentId: result.paymentId })
	    	    });
	    	  }

	    	  alert("결제 실패사유: " + result.message);
	    	  return;
	    	}
	
	      const complete = await fetch("${cp}/api/payment/complete", {
	        method: "POST",
	        headers: {
	          "Content-Type": "application/json"
	        },
	        body: JSON.stringify({ paymentId: result.paymentId })
	      });
	
	      if (complete.ok) {
	        const json = await complete.json();
	        if (json.status === "PAID") {
	       	  alert("결제가 완료되었습니다.");
	       	} else if (json.status === "CANCELED") {
	       	  alert("결제가 취소되었습니다."  + result.message);
	       	} else if (json.status === "FAILED" ) {
	       	  alert("결제가 실패했습니다."  + result.message);
	       	} else if (json.status === "REFUND") {
	       	  alert("결제가 환불 처리되었습니다."  + result.message);
	       	} else {
	       	  alert("결제 상태를 확인할 수 없습니다."  + result.message);
	       	}
      	  location.reload();
	  }
	}


    $("#checkOutBtn").on("click", async() => {
      event.preventDefault();
      const donate = await loadDonate();

      await requestPayment(donate);
    })

  </script>