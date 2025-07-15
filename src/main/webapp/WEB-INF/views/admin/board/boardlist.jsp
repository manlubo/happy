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
				<select class="form-select mb-4" id="categorySelect">
					<option value="all" ${cno == null ? 'selected' : '' }>전체</option>
					<option value="1" ${cno == '1' ? 'selected' : '' }>공지사항</option>
					<option value="2" ${cno == '2' ? 'selected' : '' }>Q&A</option>
					<option value="3" ${cno == '3' ? 'selected' : '' }>청소년</option>
					<option value="4" ${cno == '4' ? 'selected' : '' }>어르신</option>
					<option value="5" ${cno == '5' ? 'selected' : '' }>동물</option>
					<option value="6" ${cno == '6' ? 'selected' : '' }>지구</option>
					<option value="7" ${cno == '7' ? 'selected' : '' }>환경</option>
					<option value="8" ${cno == '8' ? 'selected' : '' }>장애인</option>
					<option value="9" ${cno == '9' ? 'selected' : '' }>사회</option>
					<option value="10" ${cno == '10' ? 'selected' : '' }>피드</option>
				</select>
				<ul class="list-group small">
				<li class="list-group-item ">
					<div class="row my-0 align-items-center">
					<input class="form-check-input col-1 mx-2 my-0 p-0" type="checkbox" id="checkAll" style="width: 20px; height: 20px;">
					<span class="col-1 text-center fw-bold">글 번호</span>
					<span class="col-2 text-center fw-bold">제목</span>
					<span class="col text-center fw-bold">내용</span>
					<span class="col-1 text-center fw-bold">작성자</span>
					<span class="col-2 text-center fw-bold">목표금액</span>
					<span class="col-1 text-center fw-bold">등록일</span>
					<span class="col-1 text-center fw-bold">마감일</span>
					<span class="col-1 text-center fw-bold">관리</span>
					</div>
				</li>
				<c:forEach items="${boards }" var="b">
				<li class="list-group-item">
					<div class="row my-0 align-items-center">
						<input class="form-check-input col-1 mx-2 my-0 p-0 checkItem" type="checkbox" value="${b.bno }" style="width: 20px; height: 20px;">
						<span class="col-1 text-center">${b.bno }</span>
						<span class="col-2 text-center text-truncate">${b.title }</span>
						<c:if test="${b.cno != 10}">
							<span class="col text-center text-truncate"><a href="${cp }/board/view?bno=${b.bno}" class="text-black" target="_black">${b.content }</a></span>
						</c:if>
						<c:if test="${b.cno == 10}">
							<span class="col text-center text-truncate">${b.content }</span>
						</c:if>

						<span class="col-1 text-center">${b.name }</span>
						<span class="col-2 text-center"><fmt:formatNumber value="${b.round.goalamount}" />원</span>
						<span class="col-1 text-center">${b.regdate }</span>
						<span class="col-1 text-center">${b.round.voiddate }</span>
						<div class="btn-group btn-group-sm col-1">
							<c:if test="${b.status == 'ACTIVE' }">
							<a href="${cp }/admin/board/orgboardstatuschange?bno=${b.bno}&status=DISABLED&name=${b.name}" class="btn btn-outline-secondary">숨김</a>
							</c:if>
							<c:if test="${b.status == 'DISABLED' }">
							<a href="${cp }/admin/board/orgboardstatuschange?bno=${b.bno}&status=ACTIVE&name=${b.name}" class="btn btn-secondary">노출</a>
							</c:if>
						</div>
					</div>
				</li>
				</c:forEach>
				</ul>
				<div class="mt-4">
				<button class="btn btn-outline-secondary" id="deleteBtn">선택 삭제</button>
				</div>

			</div>
          </div>

            <%@ include file="../common/adminmenu.jsp" %>
            
        </main>
</div>



                
               
        <%@ include file="../../common/footer.jsp" %>
        
<script>
	$("#categorySelect").change(function(){
		const cno = $(this).val();
		console.log(cno);
		const targetUrl = cno === 'all' ? `${cp}/admin/board/list`  : `${cp}/admin/board/list?cno=` + cno;
		location.href = targetUrl;
	})
</script>
<script>
$('#deleteBtn').on('click', function () {
	  const checkedValues = $('.checkItem:checked').map(function () {
	    return $(this).val();
	  }).get();

	  if (checkedValues.length === 0) {
	    alert('삭제할 항목을 선택하세요.');
	    return;
	  }

	  if (!confirm('정말 삭제하시겠습니까?')) return;

	  // 삭제 요청 전송
	  $.ajax({
	    url: `${cp}/admin/board/delete`,
	    method: 'POST',
	    traditional: true, // 배열을 bno=1&bno=2 형태로 전송
	    data: { bno: checkedValues },
	    success: function (res) {
	      alert('삭제되었습니다.');
	      location.reload();
	    },
	    error: function () {
	      alert('삭제 실패');
	    }
	  });
	});

</script>
</body>
</html>