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
	
}
</style>
</head>

<body>
<%@ include file="../common/header.jsp" %>
	<div class="container px-0">
        <main class="row justify-content-between mx-0">
            <div class="col-lg-8 px-0" style="max-width: 700px;">
               
                <!-- 컨텐츠 -->
                <div id="viewer" class="pb-4"></div>
                

                <!-- 댓글 -->
                <div>
                    <div class="d-flex justify-content-between align-items-center mt-5">
                        <p class="fs-5 fw-semibold m-0">댓글<span class="small"> ${replyCount}</span></p>
                        <c:if test="${not empty member and member.status == 'ACTIVE' }">
                        <button class="btn btn-outline-primary btn-write-form">댓글 작성</button>
                        </c:if>
                        <c:if test="${empty member }">
                        <a href="${cp }/member/login?mtype=USER" class="btn btn-outline-primary">로그인</a>
                        </c:if>
                        <c:if test="${member.status != 'ACTIVE' and not empty member}">
                        <button  class="btn btn-secondary" disabled>권한없음</button>
                        </c:if>
                    </div>
                    <hr>
                    <ul class="m-0 p-0 d-flex flex-column gap-4 reviews">
                    </ul>
                    <div class="d-flex justify-content-center mt-4">
                        <button class="btn btn-outline-secondary rounded-5 px-4 btn-reply-more">댓글 더보기 <i class="fa-solid fa-chevron-down small ms-1" style="color: var(--col-3);"></i></button>
                    </div>
                </div>

                
            </div>
            <div class="col-lg-4 px-0" style="max-width: 360px;">
                <!-- 제목, 모금 정보 -->
                <div>
                    <div class="d-flex flex-column justify-content-between flex-grow-1">
                        <div class="card-body">
                            <p class="fs-3 fw-semibold mb-1">${board.title }</p>
                            <p class="post-meta my-3 fs-5 fw-bold text-end" style="color: var(--col-6);"><fmt:formatNumber value="${board.round.nowamount}" />원</p>
                            
                            <div class="progress my-3" style="height: 5px;">
                                <div class="progress-bar" style="width:${Math.round(board.round.nowamount / board.round.goalamount * 100) > 100 ? '100' : Math.round(board.round.nowamount / board.round.goalamount * 100)}%"></div>
                            </div>
                            <div class="progress-wrapper d-flex justify-content-between mb-4">
                                <span class="text-primary ">${Math.round(board.round.nowamount / board.round.goalamount * 100)}% 달성</span>
                                <span><strong><fmt:formatNumber value="${board.round.goalamount}" />원 목표</strong></span>
                            </div>
                        </div>
                        <div class="d-flex flex-column gap-2">
                            <div class="d-flex gap-2">
	                            <button type="button" class="btn btn-primary form-control py-2" data-bs-toggle="modal" data-bs-target="#donatePay">기부하기</button>
                                <button class="btn-like form-control btn-outline-primary py-2" data-bno="${board.bno}" data-liked="${liked}">
                                    <i class="${board.liked ? 'fa-solid' : 'fa-regular'} fa-heart me-1 text-primary"></i> 좋아요 <span class="like-count" data-bno="${board.bno}">${board.likeCnt}</span>
                                </button>
                            </div>
	                        <c:if test="${not empty member and (member.mno == board.mno or member.mtype == 'ADMIN')}">
	                        <a href="${cp }/board/modify?bno=${board.bno}" class="btn btn-outline-primary form-control py-2" >수정하기</a>
	                        </c:if>
                        </div>
                    </div>
                </div>




                <!-- 모금함 기부정보 -->
                <div class="border rounded-3 mt-4">
                    <div class="p-4">
                        <div class="d-flex justify-content-between">
                            <p class="fs-6 fw-semibold" style="color: var(--col-6);">모금함 기부 현황</p>
                            <p class="small" style="color: var(--col-4);">${board.round.donatecount}<span>명 참여</span></p>
                        </div>
                        <div class="rounded-3 py-2" style="background-color: var(--col-1);">
                            <p class="text-center fw-semibold fs-5 m-0"><fmt:formatNumber value="${board.round.nowamount}" /><span>원</span></p>
                        </div>
                    </div>
                    <div class="p-4" style="background-color: var(--col-1);">
                        <div class="">
                            <p class="fs-6 fw-semibold" style="color: var(--col-6);">내 기부금</p>
                        </div>
                        <div class="rounded-3 py-2" style="background-color: var(--col-0);" >
                            <p class="text-center fw-semibold fs-5 m-0"><fmt:formatNumber value="${myamount}" /><span>원</span></p>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty board.round.top3}">
                <div class="border rounded-3 mt-4">
                    <div class="p-4">
                        <div class="">
                            <p class="fs-6 fw-semibold" style="color: var(--col-6);">이 모금함의 우수 후원자</p>
                        </div>
                        <ul class="m-0 p-0 d-flex flex-column gap-2">
                            <c:forEach items="${board.round.top3}" var="m">
                            <li class="d-flex align-items-center gap-3 rounded-2 p-2" style="background-color: var(--bg-1);">
                                <img src="${m.profile != null ? m.profile : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm38aJRuNJH9z0qvbVUWR9rDQ2N7DoUWDXSA&s'}" class="rounded-5" alt="프로필 사진" style="width: 40px; height: 40px; object-fit: cover;">
                                <p class="m-0 flex-grow-1 fw-medium"><span>${m.nickname}</span>님</p>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                </c:if>
                <div class="border rounded-3 mt-4">
                    <div class="p-4">
                        <div class="d-flex">
                            <div class="rounded-5 overflow-hidden" style="border:2px solid var(--col-main);">
                                <img src="${owner.profile != null ? owner.profile : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm38aJRuNJH9z0qvbVUWR9rDQ2N7DoUWDXSA&s'}" alt="" style="width: 40px; height: 40px; object-fit: cover;">
                            </div>
                            <div class="ms-3">
                                <p class="fs-6 fw-semibold m-0" style="color: var(--col-6);">${board.name}</p>
                                <p class="small m-0" style="color: var(--col-3);">후원기관</p>
                            </div>
                        </div>
                        <p class="small mt-3 mb-0">${owner.content}</p>
                        
                    </div>
                </div>



                <!-- 해당 후원기관의 모금함들 -->
                <div class="border rounded-3 mt-4 p-4">
                    <div class="">
                        <p class="fs-6 fw-semibold m-0" style="color: var(--col-6);">이 후원기관의 모금함들</p>
                    </div>
                    <hr>
                    <ul class="p-0 d-flex flex-column gap-3 m-0">
                        <c:forEach items="${orgDonates}" var="d">
                        <li>
                            <a href="${cp}/board/view?bno=${d.bno}" class="d-flex text-decoration-none">
                                <img src="${d.thumbnail != null ? d.thumbnail : 'https://placehold.co/200x150?text=No+img'}" class="rounded-2" alt="이미지4" style="height: 68px; width: 100px; object-fit: cover;">
                                <div class="ms-3 small">
                                    <p>${d.title}</p>
                                    <p class="m-0 small" style="color: var(--col-4);">${d.name}</p>
                                </div>
                            </a>
                        </li>
                        </c:forEach>
                    </ul>
                </div>
                
            </div>
        </main>
    </div>
<div class="modal fade" id="reviewModal">
   <div class="modal-dialog">
       <div class="modal-content">

           <!-- Modal Header -->
           <div class="modal-header">
               <h4 class="modal-title fs-5">댓글 작성</h4>
               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
           </div>

           <!-- Modal body -->
           <div class="modal-body">
               <form action="/action_page.php">
                   <div class="mb-3 mt-3">
                       <label for="content" class="form-label"><i class="fa-solid fa-comment text-secondary me-2"></i> 댓글 내용</label>
                       <textarea class="form-control no-resize" id="content" placeholder="Enter Content" name="content" rows="5"  ></textarea>
                   </div>
                   <div class="mb-3">
                       <label for="writer" class="form-label"><i class="fa-solid fa-user text-secondary me-2"></i> 작성자</label>
                       <input type="text" class="form-control" placeholder="작성자" value="${member.nickname != null ? member.nickname : member.name }" disabled="disabled">
                   </div>
                       <input type="hidden" id="writer" name="writer" value="${member.mno }">
               </form>
           </div>

           <!-- Modal footer -->
           <div class="modal-footer">
               <button type="button" class="btn btn-primary btn-sm btn-write-submit">댓글 쓰기</button>
               <button type="button" class="btn btn-outline-primary btn-sm btn-modify-submit">수정</button>
               <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
           </div>

       </div>
   </div>
</div>
<%@ include file="donatemodal.jsp" %>
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


	const content = `${board.content}`.replaceAll("\\n", "\n").replaceAll("\\\"", "\"");
  const viewer = new toastui.Editor.factory({
    el: document.querySelector('#viewer'),
    viewer: true,
    initialValue: content
  });

</script>
<script>
    $.ajaxSetup({
        contentType: 'application/json; charset=utf-8'
    });

    $(_ => {
    	const bno = '${board.bno}'
        const url = "${cp}" + "/reply/";
        const modal = new bootstrap.Modal($("#reviewModal").get(0), {})
        const loginUserMno = ${member.mno != null ? member.mno : 'null'};

        // makeReplyLi(reply) > str
        
        function makeReplyLi(r) {
            const liked = r.liked === true;
        	const isOwner = loginUserMno === r.mno; 
        	return `<li class="d-flex gap-3" data-rno="\${r.rno}">
            <div class="rounded-5 overflow-hidden border-2" style="border: 2px solid var(--border-1); width: 40px; height: 40px; box-sizing: border-box;"><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm38aJRuNJH9z0qvbVUWR9rDQ2N7DoUWDXSA&s" alt="프로필 사진" style="width: 100%; height: 100%; object-fit: cover;" ></div>
            <div class="flex-grow-1">
                <div class="d-flex my-2">
                    <p class="fw-medium m-0" style="color: var(--col-6);">\${r.nickname == null ? r.name : r.nickname}</p>
                </div>
                <div class="p-3 rounded-3 mt-3" style="background-color: var(--col-1);">
                    <p class="m-0 small">\${r.content}</p>
                </div>
                <div class="small d-flex justify-content-end gap-3 mt-2">
                    <button class="btn-like border-0 bg-transparent" data-rno="\${r.rno}" data-liked="\${liked}">
                    <i class="\${liked ? 'fa-solid' : 'fa-regular'} fa-heart me-1 text-primary"></i> 좋아요 <span class="like-count" data-rno="\${r.rno}">\${r.likeCnt}</span>
                    </button>
                    <span>\${dayjs(r.regdate, dayForm).fromNow()}</span>
                    \${isOwner ? `
                    <label class="text-decoration-underline " style="color: var(--col-3); cursor: pointer;">수정<button class="d-none btn-modify-form"></button></label>
                    <label class="text-decoration-underline" style="color: var(--col-3); cursor: pointer;">삭제<button class="d-none btn-remove-submit"></button></label>
                    ` : ''
                    }
                </div>
            </div>
        </li>`;
        }
        
        function list(bno, lastRno) {
        	lastRno = lastRno ? ("/" + lastRno) : '';
        	let reqUrl = url + 'list/' + bno  + lastRno;
        	
            $.ajax({
                 url : reqUrl,
                success : function(data){
                    if(!data || data.length === 0) {
                    	if($(".reviews li").length === 0){
                    		$(".reviews").html("<li class='list-group-item text-center text-muted'>댓글이 없습니다</li>");
                    	}
                    	else {
                    		$(".btn-reply-more").prop("disabled", true).text("추가 댓글이 없습니다");
                    	}
                    	return;
                    		
                    }
                    $(".btn-reply-more").removeClass("d-none");
                    let str = '';
                    for(let r of data) {
                        str += makeReplyLi(r);  
                    }
                    $(".reviews").append(str); // 교체, 추가
                }
            })
        }
        list(bno);


        // 글쓰기 폼 활성화 btn-write-form 작동 확인 완료
        $(".btn-write-form").click(function() {
            console.log("글쓰기 폼");
            $("#reviewModal form").get(0).reset();
            $("#reviewModal .modal-footer button").show().eq(1).hide();
            modal.show();
        })
        
        // 글쓰기 버튼 이벤트 btn-write-submit
        $(".btn-write-submit").click(function() {
            const result = confirm("등록하시겠습니까?");
            if(!result) return;

            const content = $("#content").val().trim();
            const mno = $("#writer").val().trim();
            

            const obj = {content, mno, bno};
            console.log(obj);
            console.log("글쓰기 전송");

            $.ajax({
                url,
                method : 'POST',
                data : JSON.stringify(obj),
                success : function(data) {
                    if(data.result) { 
                        modal.hide();
                        // 작성된 댓글
                        if(data.reply){ // not null, not undefined
	                        data.reply.regdate = dayjs().format(dayForm);
	                        const strLi = makeReplyLi(data.reply);
	                        $(".reviews").prepend(strLi);
                        }
                    }
                }
            })
        })
        // 글수정 폼 활성화 btn-modify-form
        $(".reviews").on("click",".btn-modify-form",function() {
            console.log("글수정 폼");
            const rno = $(this).closest("li").data("rno");
            $.getJSON(url + rno, function(data){
                $("#reviewModal .modal-footer button").show().eq(0).hide();
                $("#content").val(data.content);
                $("#writer").val(data.mno);
                $("#reviewModal").data("rno", rno);
                console.log(data);
                modal.show();
            })
        })

        // 글 수정 버튼 이벤트 btn-modify-submit
        $(".btn-modify-submit").click(function() {
            const result = confirm("수정하시겠습니까?");
            if(!result) return;
            
            const rno = $("#reviewModal").data("rno");
            console.log(rno);
            
            const content = $("#content").val().trim();
            const mno = $("#writer").val().trim();
       
            
            const obj = {content, mno, rno};

            $.ajax({
                url : url + rno,
                method : 'PUT',
                data : JSON.stringify(obj),
                success : function(data) {
                    if(data.result){
                        modal.hide();
                        // 재호출 (get)
                        $.getJSON(url + rno, function(data){
                        	console.log(data);
                        	// 문자열 생성
                        	const strLi = makeReplyLi(data);
                        	// rno를 가지고 수정할 li를 탐색
                        	const $li = $(`.reviews li[data-rno=\${rno}]`);
                        	console.log($li.html());
                        	// replaceWith 내용교체
                        	$li.replaceWith(strLi);
                        })
                    }
                }
            })

            console.log("글수정 전송");
        })

        // 글 삭제 버튼 이벤트 btn-remove-submit
        $(".reviews").on("click",".btn-remove-submit",function() {
            const result = confirm("삭제하시겠습니까?");
            if(!result) return;
            
            const $li = $(this).closest("li");
            const rno = $li.data("rno");
            console.log("글 삭제 전송");
            $.ajax({
                url : url + rno,
                method : 'DELETE',
                success : function(data) {
                    if(data.result){
                       $li.remove();
                    }
                }
            })
        })
        // 댓글 더보기 버튼 이벤트
        $(".btn-reply-more").click(_ => {
        	// 현재 댓글 목록 중 마지막 댓글 번호를 가져오기
        	const lastRno = $(".reviews li:last").data("rno");
        	console.log(lastRno);
        	
        	list(bno, lastRno);
        })
        
    })
</script>
<script>
    $(document).on('click', '.btn-like', function() {
        const $btn = $(this);
        const rno = $btn.data('rno');
        const bno = $btn.data('bno');
        const mno =  ${member.mno};
        const param = {};
        if (rno) param.rno = rno;
        if (bno) param.bno = bno;
        if (mno) param.mno = mno;

        $.ajax({
            url: '${cp}/api/like',
            method: 'POST',
            data: JSON.stringify(param),
            success: function(res) {
                const liked = res.liked;
                const $icon = $btn.find('i');

                // 아이콘 변경
                if (liked) {
                    $icon.removeClass('fa-regular').addClass('fa-solid');
                } else {
                    $icon.removeClass('fa-solid').addClass('fa-regular');
                }

                // data-liked 상태도 갱신해줌
                $btn.data('liked', liked);

                // 좋아요 수 동기화
                const countUrl = rno ? `${cp}/api/like?rno=\${rno}` : `${cp}/api/like?bno=\${bno}`;
                $.get(countUrl, function (cnt) {
                    if (rno)
                        $(`.like-count[data-rno='\${rno}']`).text(cnt);
                    else
                        $(`.like-count[data-bno='\${bno}']`).text(cnt);
                });

            }
        })




    });

</script>
</body>
</html>