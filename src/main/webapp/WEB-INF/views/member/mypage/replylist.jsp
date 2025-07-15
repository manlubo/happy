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
								<span class="col-2 text-center fw-bold">글 번호</span>
								<span class="col text-center fw-bold">내용</span>
								<span class="col-2 text-center fw-bold">등록일</span>
								<span class="col-2 text-center fw-bold">관리</span>
							</div>
						</li>
						<c:forEach items="${replys }" var="r">
							<li class="list-group-item">
								<div class="row my-0 align-items-center">
									<span class="col-2 text-center">${r.bno }</span>
									<span class="col text-center text-truncate">${r.content }</span>
									<span class="col-2 text-center">${r.regdate }</span>
									<div class="btn-group btn-group-sm col-2">
										<button type="button" class="btn btn-outline-secondary btn-delete" data-rno="${r.rno}">삭제</button>
									</div>
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
<script>
	$(document).on('click', '.btn-delete', function (e) {
		const rno = $(this).data('rno');

		if (!confirm('정말 삭제하시겠습니까?')) return;

		// 삭제 요청 전송
		$.ajax({
			url: `${cp}/admin/reply/delete`,
			method: 'POST',
			traditional: true,
			data: { rno: rno },
			success: function (res) {
				alert('삭제되었습니다.');
				$(`*[data-rno='\${rno}']`).closest("li").remove();
			},
			error: function () {
				alert('삭제 실패');
			}
		});
	});

</script>
</body>
</html>