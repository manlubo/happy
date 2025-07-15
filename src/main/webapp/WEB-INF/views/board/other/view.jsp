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
<style>
.toastui-editor-contents *:not([data-nodeid='1']){
	margin: 1.5rem 0 !important;
}

.toastui-editor-contents [data-nodeid='1'] *:not(:first-child) {
	margin: 1.5rem 0 !important;
}

.toastui-editor-contents > *:first-child{
	margin: 0 !important;
}
.toastui-editor-contents p {
  font-size: 18px; /* 원하는 글씨 크기로 조정 */
}
.toastui-editor-contents img {
	display: block;
	width: 100%;
	height: auto;
	object-fit: cover;
	border-radius: 1rem;
	border: 0;
}
</style>
</head>

<body>
<%@ include file="../../common/header.jsp" %>
	<div class="container px-0">
        <main class="row justify-content-between mx-0">
            <div class="card rounded-2 shadow-sm mb-4 px-0">
                <div class="card-header bg-light py-3">
                <h5 class="mb-0">${board.title}</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between text-muted small mb-2">
                        <div>작성자: <strong>${board.nickname}</strong></div>
                        <div data-regdate="${board.regdate}"></div>
                    </div>
                    <div id="viewer" class="pb-4"></div>
                </div>
                <div class="card-footer bg-white d-flex justify-content-end gap-2">
                    <c:if test="${cri.ctype == 'NOTICE'}">
                    <a href="${cp}/notice/list?${cri.qs2}" class="btn btn-primary btn-sm">목록</a>
                    </c:if>
                    <c:if test="${cri.ctype == 'QNA'}">
                    <a href="${cp}/qna/list?${cri.qs2}" class="btn btn-primary btn-sm">목록</a>
                    </c:if>

                    <c:if test="${not empty member && (member.mtype == 'ADMIN' || member.mtype == 'MANAGER')}">
                        <c:if test="${cri.ctype == 'NOTICE'}">
                        <a href="${cp}/notice/modify?bno=${board.bno}" class="btn btn-outline-primary btn-sm">수정</a>
                        </c:if>
                        <c:if test="${cri.ctype == 'QNA'}">
                        <a href="${cp}/qna/modify?bno=${board.bno}" class="btn btn-outline-primary btn-sm">수정</a>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
<%@ include file="../../common/footer.jsp" %>



<script type="text/javascript">
	dayjs.extend(window.dayjs_plugin_relativeTime);
	dayjs.locale('ko');
	const dayForm = 'YYYY-MM-DD HH:mm:ss';
	
	$("*[data-regdate]").each((v,i) => {
		const date = $(i).data("regdate");
		const deadlineText = dayjs(date, dayForm).fromNow() + ' 작성';
		$(i).text(deadlineText);
	})


	const content = `${board.content}`.replaceAll("\\n", "\n").replaceAll("\\\"", "\"");
  const viewer = new toastui.Editor.factory({
    el: document.querySelector('#viewer'),
    viewer: true,
    initialValue: content
  });

</script>

</body>
</html>