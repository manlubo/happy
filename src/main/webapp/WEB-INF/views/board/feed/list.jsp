<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/head.jsp" %>
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
<%@ include file="../../common/header.jsp" %>
	<div class="container">
        <main>
        	<div class="row g-3" id="masonry-container">
	          <div class="grid-sizer col-6 col-md-4 col-lg-3"></div>
	          
	          <c:forEach items="${feeds }" var="f">
	          <div class="grid-item col-6 col-md-4 col-lg-3 mt-3">
	            <a href="#" class="card text-decoration-none" data-bs-toggle="modal" data-bs-target="#feedModal" data-bno="${f.bno}">
	              <div class="overflow-hidden rounded-top-1">
	                <img src="${f.thumbnail != null ? f.thumbnail : 'https://placehold.co/300x250?text=No+img' }" class="card-img-top img-zoomin" alt="img">
	              </div>
	              <div class="card-body">
	                <p class="card-text text-truncate fw-medium mb-2">${f.content }</p>
	                <p class="card-text text-truncate text-muted my-0 small" data-regdate="${f.regdate }"></p>
	              </div>
	            </a>
	          </div>
	          </c:forEach>
	          <div class="row p-0 position-fixed" style="max-height: 58px; max-width: 1120px; bottom: 60px; ">
					<form class="input-group col search-form">
						  <div class="form-floating" style="max-width: 200px;">
							  <select class="form-select" id="type" name="type">
							    <option value="TCN">전체</option>
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
					            <label for="keyword"" style="z-index: 10; max-height: 58px;">검색어 입력</label>
					            <button class="btn btn-outline-primary px-4" type="submit" style="max-height: 58px;">검색</button>
				          	</div>
					</form>					
					<a href="${cp}/feed/write" class="btn btn-primary col-1" style="max-height: 58px; line-height: 44px;">글쓰기</a>
				</div>
				<script type="text/javascript">
            		$(".search-form").submit(function() {
            			event.preventDefault();
            			this.keyword.value = encodeURIComponent(this.keyword.value);
						this.submit();          			
            		})
            	</script>	        
	        </div>
        </main>

    </div>

<%@ include file="feedmodal.jsp" %>
<%@ include file="../../common/footer.jsp" %>
<script type="text/javascript">
	dayjs.extend(window.dayjs_plugin_relativeTime);
	dayjs.locale('ko');
	const dayForm = 'YYYY-MM-DD HH:mm:ss';
	
	$("*[data-regdate]").each((v,i) => {
		const date = $(i).data("regdate");
		const deadlineText = dayjs(date, dayForm).fromNow();
		$(i).text(deadlineText);
	})
</script>
<script src="https://unpkg.com/imagesloaded@5/imagesloaded.pkgd.min.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script>
  const grid = document.querySelector('#masonry-container');
  imagesLoaded(grid, () => {
    new Masonry(grid, {
      itemSelector: '.grid-item',
      columnWidth: '.grid-sizer',
      percentPosition: true,
      gutter: 0
    });
  });
</script>
</body>
</html>