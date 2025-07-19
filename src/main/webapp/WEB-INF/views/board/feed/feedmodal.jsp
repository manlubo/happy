<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="modal fade" id="feedModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content" style="border-radius: 10px; overflow: hidden;">

      <div class="row g-0">
        <!-- 왼쪽: 이미지 -->
        <div class="col-md-6 d-flex align-items-center justify-content-center bg-dark">
          <img src="https://placehold.co/600x600" class="img-fluid" id="feedImg" style="object-fit: cover; max-height: 600px; max-width: 600px; width: 100%; height: 100%; min-height: 400px" alt="게시글 이미지">
        </div>

        <!-- 오른쪽: 게시글 정보 -->
        <div class="col-md-6 bg-white">
          <div class="p-4 d-flex flex-column" style="height: 100%; overflow-y: auto;">

            <!-- 작성자 -->
            <div class="d-flex align-items-center mb-4">
              <img src="https://placehold.co/40x40" id="profileImg" class="rounded-circle me-2" alt="프로필" style="width: 40px; height: 40px; object-fit: cover;">
              <strong id="memberNickname">사용자닉네임</strong>
              <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- 게시글 내용 -->
            <div id="viewer" class="flex-grow-1 mb-3"></div>
              <div class="d-flex gap-2">
              <button class="btn-like form-control btn-outline-primary py-2" data-bno="${board.bno}" data-liked="${liked}">
                  <i class="${board.liked ? 'fa-solid' : 'fa-regular'} fa-heart me-1 text-primary"></i> 좋아요 <span class="like-count" data-bno="${board.bno}"></span>
              </button>
              <a href="#" class="btn btn-primary form-control" id="feedModify">수정</a>
              <a href="#" class="btn btn-outline-primary form-control" id="feedDelete">삭제</a>
              </div>
            <!-- 댓글 -->
            <div class="mb-3">
              <ul class="d-flex flex-column gap-1 m-0 p-0 pb-2" id="replys" style="max-height: 300px; overflow-y: auto;">
                  <li class="small m-0 d-flex justify-content-between reply align-items-center" data-rno="\${r.rno}" data-mno="\${r.mno}">
				      <div class="d-flex gap-2 content-wrap align-items-center flex-grow-1"><strong>\${r.nickname}</strong> <div class="m-0 reply-content w-75 d-flex align-items-center">\${r.content}</div></div>
				      <div class="dropdown float-end">
				        <button class="d-block btn btn-outline-light btn-sm" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical small text-muted" style="width: 20px; height: 20px;" ></i>
				        </button>
				        <ul class="dropdown-menu dropdown-menu-end">
				          <li><a class="dropdown-item btn-edit" href="#">수정</a></li>
				          <li><a class="dropdown-item btn-delete" href="#">삭제</a></li>
				        </ul>
				      </div>
				    </li>
              </ul>
            </div>

            <!-- 입력 -->
             <c:if test="${not empty member}">
            <form class="d-flex border-top pt-2">
              <input type="text" class="form-control me-2 border-0" id="content" placeholder="댓글 달기...">
              <button class="btn btn-primary btn-write-submit" style="width: 120px;">댓글 작성</button>
              <input type="hidden" id="writer" value="${member.mno}">
              <input type="hidden" id="bno" value="">
            </form>
              </c:if>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script>
  $.ajaxSetup({
    contentType: 'application/json; charset=utf-8'
  });

  $("#masonry-container").on("click", ".card", function(){
    event.preventDefault();
    const bno = $(this).data("bno");
    const cp = '${pageContext.request.contextPath}';
      const loginUserMno = ${empty member ? 'null' : member.mno};
    $.ajax({
      url: cp + '/api/feed/view?bno=' + bno,
      method: "GET",
      dataType: "json",
      success: function(data) {
        $("#feedModal #feedImg").attr("src", data.board.thumbnail);
        const name = data.board.nickname != null ? data.board.nickname : data.board.name
        $("#memberNickname").text(name);
        $("#viewer").text(data.board.content);
        $("#bno").val(data.board.bno);
        $("#profileImg").attr("src", data.profile);
        if(loginUserMno === null || data.board.mno != loginUserMno){
            $("#feedDelete").hide();
            $("#feedModify").hide();
        } else {
            $("#feedDelete").show();
            $("#feedModify").show();
        }


        $("#feedModify").attr("href", cp + '/feed/modify?bno=' + data.board.bno);

        $("#feedModal").on("click", "#feedDelete", function (e){
            e.preventDefault();
            const result = confirm("삭제하시겠습니까?");
            if(!result) return

            location.href = cp + '/board/remove?bno=' + data.board.bno;
        })

          $("#feedModal .btn-like").attr("data-bno", data.board.bno);
          $("#feedModal .btn-like").attr("data-liked", data.board.liked);
          const $icon = $("#feedModal .btn-like i"); // 아이콘 대상
          if (data.board.liked) {
              $icon.removeClass("fa-regular").addClass("fa-solid");
          } else {
              $icon.removeClass("fa-solid").addClass("fa-regular");
          }

          $("#feedModal .like-count")
              .attr("data-bno", data.board.bno)
              .text(data.board.likeCnt);
        let replyStr = "";
        
        for(let r of data.replys){
       		const isOwner = loginUserMno === r.mno;
       		console.log(isOwner);
          replyStr += `<li class="small m-0 d-flex justify-content-between reply align-items-center" style="height: 35px;" data-rno="\${r.rno}" data-mno="\${r.mno}">
		      <div class="d-flex gap-2 content-wrap align-items-center flex-grow-1"><strong>\${r.nickname}</strong> <div class="m-0 reply-content w-75 d-flex align-items-center">\${r.content}</div></div>
		      <div class="dropdown float-end">
		      \${isOwner ? `
		        <button class="d-block btn btn-outline-light btn-sm" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical small text-muted" style="width: 20px; height: 20px;" ></i>
		        </button>
		        <ul class="dropdown-menu dropdown-menu-end">
		          <li><a class="dropdown-item btn-edit" href="#">수정</a></li>
		          <li><a class="dropdown-item btn-delete" href="#">삭제</a></li>
		        </ul>
		        ` : ''
                }
		      </div>
		    </li>`;
        }

        
        $("#replys").html(replyStr);
        $("#feedModal").modal("show");
      },
      error: function () {
      alert("피드 로딩 실패🥲");
      }
    });
  });

  const content = `${board.content}`.replaceAll("\\n", "\n").replaceAll("\\\"", "\"");
  const viewer = new toastui.Editor.factory({
    el: document.querySelector('#viewer'),
    viewer: true,
    initialValue: content
  });
</script>




<script>
    const url = "${cp}" + "/reply/";

    
    function makeReplyLi(r) {
      return `<li class="small m-0 d-flex justify-content-between reply align-items-center" style="height: 35px;" data-rno="\${r.rno}" data-mno="\${r.mno}">
		      <div class="d-flex gap-2 content-wrap align-items-center flex-grow-1"><strong>\${r.nickname}</strong> <div class="m-0 reply-content w-75 d-flex align-items-center">\${r.content}</div></div>
		      <div class="dropdown float-end">
		        <button class="d-block btn btn-outline-light btn-sm" data-bs-toggle="dropdown"><i class="fa-solid fa-ellipsis-vertical small text-muted" style="width: 20px; height: 20px;" ></i>
		        </button>
		        <ul class="dropdown-menu dropdown-menu-end">
		          <li><a class="dropdown-item btn-edit" href="#">수정</a></li>
		          <li><a class="dropdown-item btn-delete" href="#">삭제</a></li>
		        </ul>
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
                  $(".btn-reply-more").prop("disabled", true).text("추가 댓글이 없습니다");
                  return;
                }
                $(".btn-reply-more").removeClass("d-none");
                let str = '';
                for(let r of data) {
                    str += makeReplyLi(r);  
                }
                $("#reviews").append(str); // 교체, 추가
            }
        })
    }
    // list(bno);
                    	
                    	
                    		



    // 글쓰기 버튼 이벤트 btn-write-submit
    $(".btn-write-submit").click(function() {
      event.preventDefault();
        const result = confirm("등록하시겠습니까?");
        if(!result) return;

        const content = $("#content").val().trim();
        const mno = $("#writer").val().trim();
        const bno = $("#bno").val().trim();
        

        const obj = {content, mno, bno};

        $.ajax({
            url,
            method : 'POST',
            data : JSON.stringify(obj),
            success : function(data) {
                if(data.result) { 
                    // 작성된 댓글
                    console.log(data);
                    
                    if(data.reply){ // not null, not undefined
                      const strLi = makeReplyLi(data.reply);
                      $("#replys").prepend(strLi);
                      $("#content").val("");
                    }
                }
            }
        })
    })
    

    // 글 수정 버튼 이벤트 btn-modify-submit
    $("#feedModal").on("click", ".btn-modify-submit", function() {
        const result = confirm("수정하시겠습니까?");
        if(!result) return;
        
        const li = $(this).closest('.reply');
        const rno = li.data('rno');
        const target = li.find('.reply-content').find("input");
        
        console.log(rno);
        
        const content = $(target).val().trim();
        const mno = $("#writer").val().trim();
    
        
        const obj = {content, mno, rno};

        $.ajax({
            url : url + rno,
            method : 'PUT',
            data : JSON.stringify(obj),
            success : function(data) {
                if(data.result){
                    // 재호출 (get)
                    $.getJSON(url + rno, function(data){
                      console.log(data);
                      // 문자열 생성
                      const strLi = makeReplyLi(data);
                      // rno를 가지고 수정할 li를 탐색
                      
                      const li = $(`#replys li[data-rno=\${data.rno}]`);
                      
                      // replaceWith 내용교체
                      li.replaceWith(strLi);
                    })
                }
            }
        })

        console.log("글수정 전송");
    })

    // 글 삭제 버튼 이벤트 btn-delete
    $("#feedModal").on("click",".btn-delete",function() {
        const result = confirm("삭제하시겠습니까?");
        if(!result) return;
        
        const $li = $(this).closest(".reply");
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
      const lastRno = $("#reviews div:last").data("rno");
      console.log(lastRno);
      
      list(bno, lastRno);
    })
        



    $("#feedModal").on("hide.bs.modal", function () {
      document.activeElement.blur(); // 포커스 날려서 경고 제거
    });

    
    const dropdownElements = document.querySelectorAll('#replys [data-bs-toggle="dropdown"]');
    dropdownElements.forEach(el => new bootstrap.Dropdown(el));

    $("#feedModal").on('click', '.btn-edit', function(e) {
      e.preventDefault();
	
      const li = $(this).closest('.reply');
      const rno = li.data('rno');
      const target = li.find('.reply-content');
      const content = target.text().trim();
      target.data("original", content);


      console.log(li);
      console.log(rno);
      console.log(content);
      let modifyStr = `<div class="input-group">
    	  <input type="text" class="form-control modifyReply" value="\${content}">
    	  <button class="btn btn-secondary btn-modify-submit" type="button">수정</button>
    	  <button class="btn btn-outline-secondary cancleBtn" type="button">취소</button>
    	</div>`;
      $(target).html(modifyStr);
    });
    
    $("#feedModal").on("click", ".cancleBtn", function(){
      const target = $(this).closest('.reply-content')
      const original = target.data("original");
      target.html(original);
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