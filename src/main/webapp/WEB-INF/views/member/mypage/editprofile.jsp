<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <h3 class="mb-4">프로필 수정</h3>

            <form method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">현재 프로필 사진</label><br/>
                    <img src="${member.profile}" alt="현재 프로필" id="memberProfile" style="width:100px; height:100px; border-radius:50%; border:1px solid var(--border-1); object-fit: cover;">
                </div>

                <div class="mb-3">
                    <label for="profileImage" class="form-label">새 프로필 사진 선택</label>
                    <input class="form-control" type="file" id="profileImage" name="profileImage" accept=".jpg, .jpeg, .png, .bmp, .gif, .webp">
                </div>
                <input type="hidden" name="uuid" id="uuid">
                <input type="hidden" name="path" id="path">
                <input type="hidden" name="origin" id="origin">
                <input type="hidden" name="image" value="true">
                <input type="hidden" name="mno" value="${member.mno }">
                <button type="submit" class="btn btn-primary">저장</button>
            </form>
        </div>

        <%@ include file="membermenu.jsp" %>
    </main>
</div>

<script>
    const cp = '${pageContext.request.contextPath}';
    // 썸네일 파일 변경시 사이즈, 확장자 체크
    $('#profileImage').on('change', function (e) {
        event.preventDefault();
        const file = this.files[0];
        if (!file) return;

        const MAX_FILE_SIZE = 1 * 1024 * 1024;
        const ONLY_EXT = ['jpg', 'jpeg', 'png', 'bmp', 'gif', 'webp'];
        const ext = file.name.split(".").pop().toLowerCase();

        if (!ONLY_EXT.includes(ext) || file.size > MAX_FILE_SIZE) {
            alert("프로필 이미지는 이미지 파일(jpg, jpeg, png, bmp, gif, webp)만 등록 가능하며 최대 1MB입니다.");
            $(this).val("");
            $("#profileImage").val("");
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
                        $('#uuid').val(a.uuid);
                        $('#path').val(a.path);
                        $('#origin').val(a.origin);
                        $('#memberProfile').attr("src", imageUrl);
                    }
                }
                else {
                    alert('이미지가 없습니다.');
                }
            },
            error: function () {
                alert('이미지 업로드 실패');
            }
        });
    });

</script>

<%@ include file="../../common/footer.jsp" %>
</body>
</html>
