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
				<ul class="list-group small">
					<li class="list-group-item ">
						<div class="row my-0 align-items-center">
							<span class="col-1 text-center fw-bold">글 번호</span>
							<span class="col-2 text-center fw-bold">제목</span>
							<span class="col text-center fw-bold">내용</span>
							<span class="col-2 text-center fw-bold">등록일</span>
							<c:if test="${member.mtype == 'ORG'}">
							<span class="col-1 text-center fw-bold">마감일</span>
							<span class="col-2 text-center fw-bold">목표금액</span>
							</c:if>
							<span class="col-2 text-center fw-bold">관리</span>
						</div>
					</li>
					<c:forEach items="${boards }" var="b">
						<li class="list-group-item">
							<div class="row my-0 align-items-center">
								<span class="col-1 text-center">${b.bno }</span>
								<span class="col-2 text-center text-truncate">${b.title }</span>
								<c:if test="${b.ctype == 'DONATE'}">
									<span class="col text-center text-truncate"><a href="${cp }/board/view?bno=${b.bno}" class="text-black" target="_blank">${b.content }</a></span>
								</c:if>
								<c:if test="${b.ctype == 'NOTICE'}">
									<span class="col text-center text-truncate"><a href="${cp }/notice/view?bno=${b.bno}" class="text-black" target="_blank">${b.content }</a></span>
								</c:if>
								<c:if test="${b.ctype == 'QNA'}">
									<span class="col text-center text-truncate"><a href="${cp }/qna/view?bno=${b.bno}" class="text-black" target="_blank">${b.content }</a></span>
								</c:if>
								<c:if test="${b.ctype == 'FEED'}">
									<span class="col text-center text-truncate">${b.content }</span>
								</c:if>
								<span class="col-2 text-center">${b.regdate }</span>
								<c:if test="${member.mtype == 'ORG'}">
								<span class="col-1 text-center">${b.round.voiddate }</span>
								<span class="col-2 text-center"><fmt:formatNumber value="${b.round.goalamount}" />원</span>
								</c:if>
								<div class="btn-group btn-group-sm col-2">
									<c:if test="${b.status == 'ACTIVE' }">
										<c:if test="${b.ctype == 'DONATE'}">
										<a href="${cp }/board/modify?bno=${b.bno}" class="btn btn-secondary">수정</a>
										</c:if>
										<c:if test="${b.ctype == 'FEED'}">
										<a href="${cp }/feed/modify?bno=${b.bno}" class="btn btn-secondary">수정</a>
										</c:if>
										<c:if test="${b.ctype == 'NOTICE'}">
										<a href="${cp }/notice/modify?bno=${b.bno}" class="btn btn-secondary">수정</a>
										</c:if>
										<c:if test="${b.ctype == 'QNA'}">
										<a href="${cp }/qna/modify?bno=${b.bno}" class="btn btn-secondary">수정</a>
										</c:if>
										<button type="button" class="btn btn-outline-secondary btn-delete" data-bno="${b.bno}">삭제</button>
									</c:if>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>

                
            </div>
            <%@ include file="membermenu.jsp" %>	
        </main>
    </div>

<%@ include file="../../common/footer.jsp" %>
<script>
	$(document).on('click', '.btn-delete', function (e) {
		const bno = $(this).data('bno');

		if (!confirm('정말 삭제하시겠습니까?')) return;

		// 삭제 요청 전송
		$.ajax({
			url: `${cp}/admin/board/delete`,
			method: 'POST',
			traditional: true, // 배열을 bno=1&bno=2 형태로 전송
			data: { bno: bno },
			success: function (res) {
				alert('삭제되었습니다.');
				$(`*[data-bno='\${bno}']`).closest("li").remove();
			},
			error: function () {
				alert('삭제 실패');
			}
		});
	});

</script>
</body>
</html>