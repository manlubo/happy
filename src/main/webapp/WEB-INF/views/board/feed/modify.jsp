<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/head.jsp" %>
<style type="text/css">
.placeholder{background-color: transparent; font-size: 16px}
</style>
</head>
<body>
<%@ include file="../../common/header.jsp" %>
	<div class="container">
    	<main>
        	<h2 class="text-center my-5">피드 글 수정</h2>
	        <form class="my-4" id="writeForm" method="POST">
	          <div id="editor"></div>
		          <div class="d-flex border rounded-1 list-group p-3 gap-3 flex-row mt-2">
		            <div class="form-floating rounded-2 overflow-hidden">
		              <img src="${feed.thumbnail != null ? feed.thumbnail : 'https://placehold.co/250x250?text=No+img'}" alt="썸네일" id="thumbnailImg" style="height: 58px; object-fit: cover;">
		            </div>
		            <div class="form-floating d-flex flex-grow-1 position-relative">
					  <input type="text" class="form-control pe-5" id="thumbnailName" placeholder="이미지" value="${feed.attach.origin}" readonly>
					  <label for="thumbnailName" style="z-index: 10;">이미지</label>
					  <input type="file" id="thumbnailFile" class="d-none" accept=".jpg, .jpeg, .png, .bmp, .gif, .webp">
					  <button type="button" class="btn btn-outline-primary position-absolute top-50 end-0 translate-middle-y me-2" id="uploadThumbnailBtn">이미지 등록</button>
					</div>
		          </div>
		          
		          
			  	  <input type="hidden" name="content" id="content">
		          <input type="hidden" name="cno" value="${feed.cno}">
		          <input type="hidden" name="status" value="${feed.status}">
		          <input type="hidden" name="ctype" value="${feed.ctype}">
		          <input type="hidden" name="mno" value="${feed.mno }">
		          <input type="hidden" name="uuid" id="uuid" value="${feed.attach.uuid}">
				  <input type="hidden" name="path" id="path" value="${feed.attach.path}">
				  <input type="hidden" name="origin" id="origin" value="${feed.attach.origin}">
				  <input type="hidden" name="image" value="true">
	          <div class="float-end mt-4">
	            <a href="${cp }/feed/list" class="btn btn-outline-primary me-2">취소</a>
	            <button class="btn btn-primary me-2">수정하기</button>
	          </div>
	        </form>
      	</main>

    </div>

<%@ include file="../../common/footer.jsp" %>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
$(_ => {
	const content = `${feed.content}`

    const editor = new toastui.Editor({
      el: document.querySelector('#editor'), // 에디터를 표시할 요소
      height: '500px',
      initialEditType: 'markdown',  // 'wysiwyg' 또는 'markdown'
      previewStyle: 'vertical',     // 'vertical' 또는 'tab'
      placeholder: '이미지는 하단 이미지 등록 버튼으로 하나 올리실 수 있습니다.',
	  initialValue: content,
      toolbarItems: [
          ['heading', 'bold', 'italic', 'strike'],
          ['hr', 'quote'],
          ['ul', 'ol', 'task'],
          ['table'],
          ['code', 'codeblock']
        ],
        hooks: {
          addImageBlobHook: () => {
            alert('이미지 업로드는 사용할 수 없습니다.');
            return false;
          }
        }
    });

	
    $('#writeForm').on('submit', function () {
  	  event.preventDefault();
  	  const markdown = editor.getMarkdown(); // 또는 editor.getHTML();

  	  $('#content').val(markdown);
  	  
  	  this.submit();
  	});
})
</script>
<script type="text/javascript">
$('#uploadThumbnailBtn').on('click', function () {
    $('#thumbnailFile').click();
  });

 $('#thumbnailFile').on('change', function () {
    const fileName = $(this)[0].files[0]?.name || '';
    $('#thumbnailName').val(fileName);
  });

  const cp = '${pageContext.request.contextPath}';
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
					const imageUrl = 'https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/upload/' + a.path + '/' +  a.uuid;
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

    
	

</script>
</body>
</html>