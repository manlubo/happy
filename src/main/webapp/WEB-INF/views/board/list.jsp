<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.13/dayjs.min.js" integrity="sha512-FwNWaxyfy2XlEINoSnZh1JQ5TRRtGow0D6XcmAWmYCRgvqOUTnzCxPc9uF35u5ZEpirk1uhlPVA19tflhvnW1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.13/locale/ko.min.js" integrity="sha512-ycjm4Ytoo3TvmzHEuGNgNJYSFHgsw/TkiPrGvXXkR6KARyzuEpwDbIfrvdf6DwXm+b1Y+fx6mo25tBr1Icg7Fw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.13/plugin/relativeTime.min.js" integrity="sha512-MVzDPmm7QZ8PhEiqJXKz/zw2HJuv61waxb8XXuZMMs9b+an3LoqOqhOEt5Nq3LY1e4Ipbbd/e+AWgERdHlVgaA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style type="text/css">
.tab {
  background-color: var(--col-1);
}
.active-tab {
  background-color: var(--col-main);
  color: #fff;
}
</style>
</head>

<body>
<%@ include file="../common/header.jsp" %>
	<div class="container">
        <main>
        	<c:if test="${not empty pageDto.cri.type}">
            <div class="search text-center">
            	
            	
                <h3>Search</h3>
                <p class="mb-5">'<span class="fw-semibold">${pageDto.cri.keyword }</span>'으로 검색하신 결과입니다</p>
            </div>
            </c:if>

			<c:if test="${pageDto.cri.ctype == 'DONATE'}">
			<%@ include file="template/gallery.jsp" %>
			</c:if>
			<c:if test="${pageDto.cri.ctype == 'NOTICE' || pageDto.cri.ctype == 'QNA'}">
			<%@ include file="template/list.jsp" %>
			</c:if>

            <ul class="pagination my-5 justify-content-center">
            	
            	<c:if test="${pageDto.doubleLeft }">
				<li class="page-item"><a class="page-link" href="list?&page=1&${pageDto.cri.qs }"><i class="fa-solid fa-angles-left"></i></a></li>
            	</c:if>
				
				<c:if test="${pageDto.left }">
				<li class="page-item"><a class="page-link" href="list?&page=${pageDto.start - 1}&${pageDto.cri.qs}"><i class="fa-solid fa-angle-left"></i></a></li>
				</c:if>
				
				<c:forEach begin="${pageDto.start}" end="${pageDto.end}" var="i">
					<li class="page-item"><a class="page-link ${i == pageDto.cri.page ? 'active' : ''}" href="list?page=${i}&${pageDto.cri.qs}">${i}</a></li>
				</c:forEach>
				
				<c:if test="${pageDto.right }">
				<li class="page-item"><a class="page-link" href="list?page=${pageDto.end + 1}&${pageDto.cri.qs}"><i class="fa-solid fa-angle-right"></i></a></li>
				</c:if>
				
        		<c:if test="${pageDto.doubleRight }">
				<li class="page-item"><a class="page-link" href="list?page=${pageDto.realEnd}&${pageDto.cri.qs}"><i class="fa-solid fa-angles-right"></i></a></li>
				</c:if>
			</ul>
    		<div class="row p-0" style="max-height: 58px; ">
					<form class="input-group col search-form">
						  <div class="form-floating" style="max-width: 200px;">
							  <select class="form-select" id="type" name="type">
							    <option value="TCN">전체</option>
		                        <option value="T">제목</option>
		                        <option value="C">내용</option>
		                        <option value="N">작성자</option>
							  </select>
						  		<label for="type" class="form-label">검색 범위</label>
							</div>
							<input type="hidden" name="page" value="1">
                    		<input type="hidden" name="amount" value="${pageDto.cri.amount}">
                    		<input type="hidden" name="cno" value="${pageDto.cri.cno}">
							<div class="form-floating input-group bg-white rounded-2">
					            <input type="text" class="form-control" placeholder="검색어 입력" name="keyword" id="keyword">
					            <label for="keyword" style="z-index: 10; max-height: 58px;">검색어 입력</label>
					            <button class="btn btn-outline-primary px-4" type="submit" style="max-height: 58px;">검색</button>
				          	</div>
					</form>
				<c:if test="${pageDto.cri.ctype == 'DONATE'}">
					<c:if test="${not empty member && (member.mtype == 'ORG' || member.mtype == 'ADMIN')}">
					<a href="${cp}/board/write" class="btn btn-primary col-1" style="max-height: 58px; line-height: 44px;">글쓰기</a>
					</c:if>
				</c:if>
				<c:if test="${pageDto.cri.ctype == 'NOTICE'}">
					<c:if test="${not empty member && (member.mtype == 'MANAGER' || member.mtype == 'ADMIN')}">
					<a href="${cp}/notice/write" class="btn btn-primary col-1" style="max-height: 58px; line-height: 44px;">글쓰기</a>
					</c:if>
				</c:if>
				<c:if test="${pageDto.cri.ctype == 'QNA'}">
					<c:if test="${not empty member && (member.mtype == 'MANAGER' || member.mtype == 'ADMIN')}">
					<a href="${cp}/qna/write" class="btn btn-primary col-1" style="max-height: 58px; line-height: 44px;">글쓰기</a>
					</c:if>
				</c:if>
				</div>
      
                <script type="text/javascript">
            		$(".search-form").submit(function() {
            			event.preventDefault();
            			this.keyword.value = encodeURIComponent(this.keyword.value);
						this.submit();          			
            		})
            	</script>
        </main>

    </div>

<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
	dayjs.extend(window.dayjs_plugin_relativeTime);
	dayjs.locale('ko');
	const dayForm = 'YYYY-MM-DD HH:mm:ss';
	
	$("*[data-voiddate]").each((v,i) => {
		const date = $(i).data("voiddate");
		const deadlineText = dayjs(date, dayForm).fromNow();
		$(i).text(deadlineText + " 마감");
	})
</script>
</body>
</html>