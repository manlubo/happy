<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div class="container">
        <main>
        <c:if test="${cri.ctype == 'DONATE'}">
        <h2 class="text-center my-5">기부 글 수정</h2>
        </c:if>
        <c:if test="${cri.ctype == 'NOTICE'}">
        <h2 class="text-center my-5">공지사항 수정</h2>
        </c:if>
        <c:if test="${cri.ctype == 'QNA'}">
        <h2 class="text-center my-5">Q&A 수정</h2>
        </c:if>

        <form class="my-4" id="writeForm" method="post">
          <div class="form-control d-flex gap-2 mb-2">
            <c:if test="${cri.ctype == 'DONATE'}">
            <div>
              <select class="form-select" style="min-width: 200px;" name="cno">
                <option value="3">청소년</option>
                <option value="4">어르신</option>
                <option value="5">동물</option>
                <option value="6">지구</option>
                <option value="7">환경</option>
                <option value="8">장애인</option>
                <option value="9">사회</option>
              </select>
            </div>
            </c:if>
            <input type="text" class="form-control" placeholder="제목" name="title" value="${board.title }" required>
          </div>
          <div id="editor"></div>
          <c:if test="${cri.ctype == 'DONATE'}">
          <div class="d-flex border rounded-1 list-group p-3 gap-3 flex-row mt-2">
            <div class="form-floating flex-grow-1">
              <input type="number" class="form-control" placeholder="모금 목표 금액(최대 1억)" name="goalamount" id="goalamount" value="${board.round.goalamount }" min="1000000" max="100000000" value="1000000" required>
              <label for="goalamount">모금 목표 금액(최대 1억)</label>
            </div>
            
            <div class="form-floating flex-grow-1">
              <input type="text" class="form-control" placeholder="마감일" name="voiddate" id="voiddate" value="${board.round.voiddate }" required>
              <label for="voiddate">마감일</label>
            </div>
          </div>
          <div class="d-flex border rounded-1 list-group p-3 gap-3 flex-row mt-2">
            <div class="form-floating rounded-2 overflow-hidden">
              <img src="${board.thumbnail != null ? board.thumbnail : 'https://placehold.co/250x250?text=No+img' }" alt="썸네일" id="thumbnailImg" style="height: 58px; object-fit: cover;">
            </div>
            <div class="form-floating d-flex flex-grow-1 position-relative">
			  <input type="text" class="form-control pe-5" id="thumbnailName" placeholder="썸네일" value="${board.attach.origin}" readonly>
			  <label for="thumbnailName" style="z-index: 10;">썸네일</label>
			  <input type="file" id="thumbnailFile" class="d-none" accept=".jpg, .jpeg, .png, .bmp, .gif, .webp">
			  <button type="button" class="btn btn-outline-primary position-absolute top-50 end-0 translate-middle-y me-2" id="uploadThumbnailBtn">썸네일 등록</button>
			</div>
          </div>
          </c:if>
          <!-- 히든으로 값 전달 -->
          <input type="hidden" name="content" id="content">
          <input type="hidden" name="mno" value="${board.mno }">
          <c:if test="${cri.ctype == 'DONATE'}">
          <input type="hidden" name="uuid" id="uuid" value="${board.attach.uuid }">
		  <input type="hidden" name="path" id="path" value="${board.attach.path }">
		  <input type="hidden" name="origin" id="origin" value="${board.attach.origin }">
		  <input type="hidden" name="image" value="true" >
          <input type="hidden" name="drno" value="${board.drno}">
          </c:if>
          <c:if test="${cri.ctype != 'DONATE'}">
            <input type="hidden" name="cno" value="${board.cno}" >
          </c:if>
          <input type="hidden" name="status" value="${board.status}">
          <input type="hidden" name="imgList" id="imgList">
          
          
          
          <div class="float-end mt-4">
            <c:if test="${cri.ctype == 'DONATE'}">
            <a href="${cp }/board/view?bno=${board.bno}" class="btn btn-outline-primary me-2">취소</a>
            </c:if>
            <c:if test="${cri.ctype == 'NOTICE'}">
            <a href="${cp }/notice/view?bno=${board.bno}" class="btn btn-outline-primary me-2">취소</a>
            </c:if>
            <c:if test="${cri.ctype == 'QNA'}">
            <a href="${cp }/qna/view?bno=${board.bno}" class="btn btn-outline-primary me-2">취소</a>
            </c:if>
            <button class="btn btn-primary me-2">수정하기</button>
          </div>
        	
        </form>
      </main>

    </div>

<%@ include file="../common/footer.jsp" %>
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  <script>
    $(_ => {
	  const content = `${board.content}`;

      const editor = new toastui.Editor({
        el: document.querySelector('#editor'), // 에디터를 표시할 요소
        height: '500px',
        initialEditType: 'markdown',  // 'wysiwyg' 또는 'markdown'
        previewStyle: 'vertical',     // 'vertical' 또는 'tab'
        initialValue: content,
        hooks: {
      	  addImageBlobHook: (blob, callback) => {
      	    const formData = new FormData();
      	    formData.append('uploadFile', blob);

      	    fetch(cp + '/upload', {
      	      method: 'POST',
      	      body: formData
      	    })
      	    .then(res => res.json())
      	    .then(data => {
      	      if (Array.isArray(data) && data.length > 0) {
      	        const file = data[0];
      	        console.log(file);
      	        const imageUrl = 'https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/upload/' + file.path + '/' +  file.uuid;
      	        callback(imageUrl, file.origin);
      	      } else {
      	        alert("이미지 업로드 실패");
      	      }
      	    })
      	    .catch(err => {
      	      console.error(err);
      	      alert("이미지 업로드 오류 발생");
      	    });
      	  }
      	}
      });

      flatpickr("#voiddate", {
        dateFormat: "Y-m-d",   // Y-m-d
        locale: "ko",          // 한국어
        minDate: new Date().fp_incr(15), // 오늘로부터 15일 이후 부터만 선택 가능
        maxDate: new Date().fp_incr(180), // 최대 6개월 뒤까지 선택 가능
        disableMobile: true, // 모바일 기본 날짜 선택기 비활성화
        animate: "true",
        allowInput: false
      });

      $('#writeForm').on('submit', function () {
    	  event.preventDefault();

        <c:if test="${cri.ctype == 'DONATE'}">
    	  if($("#voiddate").val().trim() === ""){
    		  alert("마감일을 선택해주세요.");
    		  return;
    	  }
        </c:if>


    	  const markdown = editor.getMarkdown(); // 또는 editor.getHTML();
    	  console.log(markdown);
    	  $('#content').val(markdown);

    	  const imgList = imgListFromMarkdown(markdown);
    	  $('#imgList').val(JSON.stringify(imgList));


    	  this.submit();
    	});
      <c:if test="${cri.ctype == 'DONATE'}">

      $("#goalamount").on("keyup", function(e){
    	  let num = e.target.value;
    	  console.log(num);
    	  if (/^0[0-9]+/.test(num)) {
    		  num = num.replace(/^0+/, '');
    		  }

          let value = parseInt(e.target.value, 10);
          // 1억보다 크면 1억으로 고정
          if (value > 100000000) {
            e.target.value = 100000000;
          }

          // 음수 방지
          if (value < 0) {
            e.target.value = 0;
          }
        })

        $('#uploadThumbnailBtn').on('click', function () {
    	    $('#thumbnailFile').click();
    	  });

    	 $('#thumbnailFile').on('change', function () {
    	    const fileName = $(this)[0].files[0]?.name || '';
    	    $('#thumbnailName').val(fileName);
    	  });

      </c:if>
    })
  </script>
  <script type="text/javascript">
  const cp = '${pageContext.request.contextPath}';
  <c:if test="${cri.ctype == 'DONATE'}">
  // 썸네일 파일 변경시 사이즈, 확장자 체크
  $('#thumbnailFile').on('change', function (e) {
	  event.preventDefault();
	  const file = this.files[0];
	  if (!file) return;

	  const MAX_FILE_SIZE = 1 * 1024 * 1024;
	  const ONLY_EXT = ['jpg', 'jpeg', 'png', 'bmp', 'gif', 'webp'];
	  const ext = file.name.split(".").pop().toLowerCase();

	  if (!ONLY_EXT.includes(ext) || file.size > MAX_FILE_SIZE) {
	    alert("썸네일은 이미지 파일(jpg, jpeg, png, bmp, gif, webp)만 등록 가능하며 최대 1MB입니다.");
	    $(this).val("");
	    $("#thumbnailName").val("");
	    return;
	  }
		
		const formData = new FormData();
		formData.append("uploadFile", file);
		
			
		$.ajax({
			url : '${cp}/upload',
			method : 'POST',
			data : formData,
			processData : false, // data를 queryString으로 쓰지 않겠다.
			contentType : false, // multipart/form-data; 이후에 나오게될 브라우저 정보도 포함시킨다, 즉 기본 브라우저 설정을 따르는 옵션.
			success : function(data) {
				if(Array.isArray(data) && data.length > 0){
					const a = data[0];
					const imageUrl = cp + '/display?uuid=' + a.uuid + '&path=' + a.path;
					if(a.image){
						$('#thumbnailName').val(a.origin);
						$('#uuid').val(a.uuid);
				        $('#path').val(a.path);
				        $('#origin').val(a.origin);
				        console.log($('#thumbnailImg'));
				        $('#thumbnailImg').attr("src", imageUrl);
				     
					}
				}
				else {
					alert('썸네일이 없습니다.');
				}
			},
			error: function () {
				alert('썸네일 업로드 실패');
			}
		});
	});
  </c:if>
    
  function imgListFromMarkdown(markdown) {
	  const regex = /!\[(.*?)\]\(https:\/\/happygivers-bucket\.s3\.ap-northeast-2\.amazonaws\.com\/upload\/([\d\/]+)\/([^)\s]+)\)/g;
	  const result = [];
	  let match;

	  while ((match = regex.exec(markdown)) !== null) {
	    result.push({
	      origin: match[1],   
	      path: match[2],     
	      uuid: match[3]      
	    });
	  }

	  return result;
	}

</script>
</body>
</html>