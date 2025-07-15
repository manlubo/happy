<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String mtype = request.getParameter("mtype");
  if (mtype == null) mtype = "USER";
  request.setAttribute("mtype", mtype); 
%>
<html>
<head>
  <%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>

<div class="container">
  <main>
    <h2 class="text-center">회원가입</h2>

    <!-- 일반회원 / 기관회원 선택 -->
    <div class="d-flex border rounded-3 mx-auto mt-5" style="max-width: 460px;">
      <a href="${cp}/member/register?mtype=USER" class="flex-grow-1 btn ${mtype == 'USER' ? 'btn-primary' : ''}">일반회원</a>
      <a href="${cp}/member/register?mtype=ORG" class="flex-grow-1 btn ${mtype == 'ORG' ? 'btn-primary' : ''}">기관회원</a>
    </div>

    <!-- 회원가입 폼 -->
    <form action="${cp}/member/register" method="post" class="d-flex flex-column mx-auto my-5 gap-4" style="max-width: 460px;">
      <input type="hidden" name="mtype" value="${mtype}">

    <!-- Step 1: 약관동의 -->
				<div class="border rounded-3 list-group p-4 collapse show"
					id="tosForm">

					<!-- 모두 동의 -->
					<div class="form-check mb-3">
						<input class="form-check-input" type="checkbox" id="agreeAll" />
						<label class="form-check-label fw-bold" for="agreeAll">모두
							동의</label>
					</div>

					<!-- 이용약관 -->
					<div class="mb-4">
						<h5 class="fw-bold mb-2">이용약관</h5>
						<div style="height: 200px; overflow-y: auto; background: #fff; border: 1px solid var(--border-5); padding: 12px; border-radius: 8px;">
							<p>
								※ 본 이용약관은 공정거래위원회 표준약관을 기반으로 하되, 해피기버즈(HAPPYGIVERS)의 운영방침 및 서비스 특성을 반영하여 작성되었습니다. 적용 전 관련 법령과 쇼핑몰 운영 실태를 확인하시기 바랍니다.<br /><br />

								제1조(목적)<br />
								이 약관은 해피기버즈(이하 \"회사\" 또는 \"몰\")가 운영하는 사이버 몰에서 제공하는 인터넷 관련 서비스(이하 \"서비스\")를 이용함에 있어, 회사와 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.<br /><br />

								제2조(정의)<br />
								① \"몰\"이란 회사가 재화 또는 용역(이하 \"재화 등\")을 이용자에게 제공하기 위해 컴퓨터 등 정보통신설비를 이용하여 거래할 수 있도록 설정한 가상의 영업장을 의미하며, 아울러 운영하는 주체를 의미합니다.<br />
								② \"이용자\"란 몰에 접속하여 이 약관에 따라 몰이 제공하는 서비스를 이용하는 회원 및 비회원을 말합니다.<br />
								③ \"회원\"이라 함은 몰에 회원등록을 한 자로서, 계속적으로 서비스를 이용할 수 있는 자를 말합니다.<br />
								④ \"비회원\"이라 함은 회원가입 없이 서비스를 이용하는 자를 말합니다.<br /><br />

								제3조(약관의 명시, 개정 등)<br />
								① 회사는 약관의 내용과 상호, 대표자, 소재지, 전화번호, 사업자등록번호, 통신판매업신고번호 등을 몰 초기 화면에 게시합니다.<br />
								② 회사는 중요한 내용(청약철회, 환불, 배송 등)을 이용자가 쉽게 이해하도록 별도 팝업이나 링크로 고지합니다.<br />
								③ 관련 법령을 위반하지 않는 범위 내에서 약관을 개정할 수 있으며, 개정 시 최소 7일 전 공지합니다. 불리한 변경은 30일 전부터 공지합니다.<br />
								④ 개정 전 계약에는 개정 전 약관을 적용합니다.<br /><br />

								제4조(서비스의 제공 및 변경)<br />
								몰은 다음 업무를 수행합니다:<br />
								1. 재화 또는 용역 정보 제공 및 구매계약 체결<br />
								2. 기부 및 후원 관련 정보 제공<br />
								3. 계약 체결된 재화의 배송 또는 디지털 제공<br />
								4. 기타 회사가 정하는 업무<br /><br />

								제5조(서비스 중단)<br />
								서버 점검, 장애, 법적 사유 등으로 서비스를 일시 중단할 수 있으며, 고의 또는 중대한 과실이 없는 경우 책임을 지지 않습니다.<br /><br />

								제6조(회원가입)<br />
								회원은 회사가 제공하는 가입 양식에 따라 신청하고, 회사가 승인하면 가입이 완료됩니다.<br /><br />

								제7조(회원 탈퇴 및 자격 상실)<br />
								회원은 언제든지 탈퇴 가능하며, 다음 사유 발생 시 자격을 제한 또는 상실할 수 있습니다:<br />
								- 허위 정보 등록<br />
								- 기부금 미납<br />
								- 타인의 정보 도용 및 시스템 침해<br />
								- 법령 위반 또는 공공질서 저해 행위<br /><br />

								제8조(회원에 대한 통지)<br />
								회사는 회원에게 이메일 또는 게시판을 통해 공지할 수 있습니다.<br /><br />

								제9조(구매신청 및 개인정보 제공 동의)<br />
								이용자는 상품을 구매하거나 기부 시 개인정보 제공에 동의해야 하며, 수집 항목은 마이페이지 및 관련 화면에서 확인할 수 있습니다.<br /><br />

								제10조(계약의 성립)<br />
								회사의 수신확인 통지가 도달하면 계약이 성립합니다.<br /><br />

								제11조(지급방법)<br />
								- 계좌이체, 신용카드, 무통장입금, 포인트, 상품권 등으로 결제 가능합니다.<br /><br />

								제12조(구매신청 변경 및 취소)<br />
								배송 전까지는 주문을 변경 또는 취소할 수 있으며, 이미 결제된 경우 환불 절차에 따릅니다.<br /><br />

								제13조(재화 공급)<br />
								정상적인 경우 7일 이내 배송되며, 지연 시 사유를 안내하고 손해를 배상합니다.<br /><br />

								제14조(환급)<br />
								품절 또는 계약 불이행 시, 대금은 3영업일 이내 환급합니다.<br /><br />

								제15조(청약철회 등)<br />
								재화 수령 후 7일 이내 청약철회 가능하며, 소비자 귀책 사유가 없는 경우 반품/교환이 허용됩니다.<br /><br />

								제16조(청약철회의 효과)<br />
								반품 완료 후 3영업일 이내 환급하며, 카드 결제는 승인취소 요청을 즉시 합니다.<br /><br />

								제17조(개인정보보호)<br />
								회사는 수집한 개인정보를 서비스 제공 외 목적으로 사용하지 않으며, 수집 및 보관, 파기 절차는 별도 \"개인정보처리방침\"에 따릅니다.<br /><br />

								제18조(회사의 의무)<br />
								회사는 안정적인 서비스 제공 및 개인정보 보호를 위해 최선을 다하며, 부당한 광고나 강제성 있는 상업적 메시지를 발송하지 않습니다.<br /><br />

								제19조(회원의 의무)<br />
								ID와 비밀번호 관리는 회원의 책임이며, 도난 또는 유출 시 즉시 회사에 신고해야 합니다.<br /><br />

								제20조(이용자의 금지행위)<br />
								- 허위 정보 등록, 시스템 공격, 타인 명예훼손, 불법 콘텐츠 게시 등은 금지됩니다.<br /><br />

								제21조(연결몰과 피연결몰의 관계)<br />
								회사는 연결된 외부몰에서 발생하는 거래에 대해 책임을 지지 않습니다.<br /><br />

								제22조(저작권의 귀속 및 이용제한)<br />
								몰의 콘텐츠와 시스템은 회사에 귀속되며, 무단 복제 및 상업적 이용은 금지됩니다.<br /><br />

								제23조(분쟁해결)<br />
								분쟁 발생 시, 소비자 피해보상기구 또는 관련기관의 조정을 따를 수 있습니다.<br /><br />

								제24조(재판권 및 준거법)<br />
								본 약관에 따른 소송은 이용자의 주소지를 관할하는 지방법원에 제기하며, 대한민국 법을 준거법으로 합니다.<br /><br />

								부칙(시행일)<br />
								이 약관은 2025년 7월 10일부터 시행합니다.<br />
							</p>

						</div>
						<div class="form-check mt-2">
							<input class="form-check-input" type="checkbox" id="tos"
								name="tos" required /> <label class="form-check-label"
								for="tos">[필수] 이용약관에 동의합니다.</label>
						</div>
					</div>

					<!-- 개인정보 수집 및 이용 -->
					<div class="mb-4">
						<h5 class="fw-bold mb-2">개인정보 수집 및 이용</h5>
						<div style="height: 200px; overflow-y: auto; background: #fff; border: 1px solid var(--border-5); padding: 12px; border-radius: 8px;">
							<p>
								※ 본 개인정보처리방침은 해피기버즈(HAPPYGIVERS, 이하 "회사")가 운영하는 온라인 플랫폼 및 관련 서비스에서 회원 및 비회원의 개인정보를 어떻게 수집, 이용, 보호하는지에 대해 설명합니다.<br />
								해피기버즈는 "개인정보 보호법" 및 관련 법령을 철저히 준수합니다.<br /><br />

								■ 수집하는 개인정보 항목 및 수집방법<br />
								가. 수집 항목<br />
								회사는 회원가입, 서비스 신청 및 후원/기부 이용을 위해 다음과 같은 개인정보를 수집합니다.<br />
								- 회원가입 시: 이름, 생년월일, 성별, 아이디(ID), 비밀번호, 휴대전화번호, 이메일<br />
								- 서비스 신청 시: 주소, 결제정보, 기부내역<br />
								- 기관회원 가입 시: 기관명, 담당자 연락처<br />
								- 선택항목: 닉네임, 주소, 전화번호, 프로필 이미지 등<br />
								- 서비스 이용 과정에서: 접속 IP, 접속 로그, 쿠키, 서비스 이용기록, 결제기록, 기부활동 내역<br /><br />

								나. 수집방법<br />
								- 웹사이트 및 앱을 통한 회원가입, 기부신청, 이벤트 응모<br />
								- 문의하기, 이메일, 전화 상담, 배송요청 등 고객 응대 과정<br />
								- 자동 생성 정보 수집 도구를 통한 수집 (예: 쿠키, 로그 분석)<br /><br />

								■ 개인정보의 수집 및 이용 목적<br />
								회사는 다음 목적에 한해 개인정보를 사용합니다.<br />
								- 회원 관리: 본인 확인, 중복 가입 방지, 탈퇴 요청 처리, 민원 응대, 기부자 인증<br />
								- 기부 및 후원 서비스 제공: 기부 신청 및 이력 관리, 기부 영수증 발급, 수혜처 정보 전달<br />
								- 콘텐츠 제공 및 맞춤형 서비스 제공<br />
								- 법령에 따른 의무 이행 및 사기 방지<br />
								- 마케팅 및 커뮤니케이션: 해피레터 발송, 기부 캠페인 안내, 기부자 스토리 공유 등<br /><br />

								■ 개인정보의 보유 및 이용기간<br />
								원칙적으로 수집 및 이용 목적이 달성되면 해당 정보를 지체 없이 파기합니다.<br />
								단, 아래와 같이 일정 기간 보존합니다.<br /><br />

								가. 해피기버즈 내부 방침에 따른 정보 보유<br />
								- 탈퇴 후 부정 이용 방지 및 분쟁 대응을 위해 3년간 보존<br /><br />

								나. 관련 법령에 따른 보유<br />
								- 계약 및 청약철회 등에 관한 기록: 5년 (전자상거래법)<br />
								- 대금결제 및 재화공급에 관한 기록: 5년 (전자상거래법)<br />
								- 소비자 불만 또는 분쟁처리: 3년 (전자상거래법)<br />
								- 접속 로그: 3개월 (통신비밀보호법)<br /><br />

								■ 개인정보의 파기절차 및 방법<br />
								- 전자적 정보: 복구 불가능한 기술적 방법으로 영구 삭제<br />
								- 서면 정보: 분쇄 또는 소각 방식으로 파기<br /><br />

								■ 개인정보 제3자 제공<br />
								회사는 이용자의 사전 동의 없이는 개인정보를 외부에 제공하지 않으며, 다음과 같은 경우에만 예외로 제공합니다:<br />
								- 이용자의 명시적 동의가 있는 경우<br />
								- 법령에 의해 정당하게 요구되는 경우<br /><br />

								■ 개인정보 처리위탁<br />
								회사는 원활한 서비스 제공을 위해 다음과 같은 외부업체에 위탁하고 있습니다.<br />
								- 택배사: 기부물품 배송<br />
								- PG사(전자결제사): 기부금 결제 대행<br />
								- 문자/이메일 발송업체: 알림/캠페인 발송 대행<br /><br />

								■ 이용자 및 법정대리인의 권리와 행사 방법<br />
								- 회원은 언제든지 개인정보 열람, 정정, 삭제, 동의철회를 요청할 수 있습니다.<br />
								- 마이페이지 또는 고객센터를 통해 직접 요청 가능하며, 탈퇴 시 모든 정보는 관련 법령에 따라 처리 후 파기됩니다.<br /><br />

								■ 개인정보 자동 수집 장치의 설치 및 거부<br />
								- 쿠키 수집 목적: 접속빈도 파악, 이용자 선호 분석, 맞춤 콘텐츠 제공<br />
								- 쿠키 차단 방법: 브라우저 설정에서 쿠키 사용 차단 설정 가능<br /><br />

								■ 개인정보 보호 책임자 및 민원서비스<br />
								▶ 개인정보 보호책임자<br />
								성명: 송성준<br />
								직책: 데이터보호팀장<br />
								전화: 02-1234-5678<br />
								이메일: privacy@happygivers.org<br /><br />

								▶ 민원 및 문의 접수처<br />
								고객센터: 02-1234-5678<br />
								이메일: support@happygivers.org<br /><br />

								▶ 기타 신고 기관<br />
								개인정보침해신고센터: privacy.kisa.or.kr / 국번없이 118<br />
								개인정보분쟁조정위원회: kopico.go.kr / 1833-6972<br />
								경찰청 사이버범죄 신고시스템: cyberbureau.police.go.kr / 국번없이 182<br /><br />

								■ 시행일<br />
								이 방침은 2025년 7월 10일부터 적용됩니다.<br />
							</p>

						</div>
						<div class="form-check mt-2">
							<input class="form-check-input" type="checkbox" id="privacy"
								name="privacy" required /> <label class="form-check-label"
								for="privacy">[필수] 개인정보 수집 및 이용에 동의합니다.</label>
						</div>
					</div>

					<!-- 다음 버튼 -->
					<div class="d-grid">
						<button class="btn btn-primary" type="button"
							onclick="goNextStep()">다음</button>
					</div>
				</div>


				<!-- Step 2: 아이디, 비밀번호, 이메일 -->
      <div class="border rounded-3 list-group p-3 gap-3 collapse" id="step2_account">
        <div class="form-floating my-2">
          <input type="text" class="form-control" placeholder="아이디" name="id" id="id" required>
          <label for="id">아이디</label>
        </div>

        <div class="form-floating my-2">
          <input type="password" class="form-control" placeholder="비밀번호" name="pw" id="pw" required>
          <label for="pw">비밀번호</label>
        </div>

        <div class="form-floating input-group my-2">
          <input type="email" class="form-control" name="email" id="email" placeholder="이메일" required>
          <label for="email" style="z-index: 10;">이메일</label>  
        </div>
        <!-- 일반회원: 닉네임 자동 생성 (서버에서 처리, 클라이언트는 hidden) -->
			  <c:if test="${mtype == 'USER'}">
			    <input type="hidden" name="nickname" value="" id="nickname-hidden" />
			  </c:if>
			
			  <!-- 기관회원: 기관명 입력 필드 -->
			  <c:if test="${mtype == 'ORG'}">
			    <div class="form-floating my-2">
			      <input type="text" class="form-control" name="orgname" id="orgname" placeholder="기관명" required>
			      <label for="orgname">기관명</label>
			    </div>
			  </c:if>


        <div class="d-grid">
          <button type="submit" class="btn btn-primary btn-lg btn-block">회원가입</button>
        </div>
      </div>
      <c:if test="${mtype == 'ORG' }">
      	<input type="hidden" name="status" value="READY">
      </c:if>
    </form>
  </main>
</div>

<%@ include file="../common/footer.jsp" %>

<!-- JS: 동의 전체선택, 단계전환, 이메일인증 -->
<script>
  // 이용약관 동의 후 다음단계 전환
  function goNextStep() {
    if (!document.querySelector("#tos").checked || !document.querySelector("#privacy").checked) {
      alert("필수 약관에 동의해주세요.");
      return;
    }

    $('#tosForm').stop().animate({ opacity: 0, height: 0 }, 300, function () {
      $(this).hide();

      $('#step2_account').css({ opacity: 0, display: 'block', height: 'auto' });
      const actualHeight = $('#step2_account').outerHeight();
      $('#step2_account').css({ height: 0 });

      $('#step2_account').animate({ opacity: 1, height: actualHeight }, 400, function () {
        $(this).css({ height: 'auto' });
      });
    });
  }

  // 모두 동의 클릭 시 전체 체크
  $('#agreeAll').click(e => {
    const checked = e.target.checked;
    $('#tos, #privacy').prop('checked', checked);
  });

  // 이메일 인증 전송
  document.querySelector("#emailckplz").addEventListener("click", function () {
    const email = document.querySelector("#email").value.trim();
    if (!email) {
      alert("이메일을 입력해주세요.");
      return;
    }
    fetch("/happygivers/member/email-auth?email=" + encodeURIComponent(email))
      .then(res => res.text())
      .then(msg => alert("인증메일이 전송되었습니다. 5분 이내 인증해주세요."));
  });
</script>

</body>
</html>
