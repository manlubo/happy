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
                    <img src="${member.profile}" alt="현재 프로필" style="width:100px;height:100px;border-radius:50%;border:1px solid var(--border-1);">
                </div>

                <div class="mb-3">
                    <label for="profileImage" class="form-label">새 프로필 사진 선택</label>
                    <input class="form-control" type="file" id="profileImage" name="profileImage" accept="image/*">
                </div>

                <button type="submit" class="btn btn-primary">저장</button>
            </form>
        </div>

        <%@ include file="membermenu.jsp" %>
    </main>
</div>

<script>
  // 이미지 미리보기
  document.getElementById("profileImage").addEventListener("change", function(e) {
    const preview = document.querySelector("img[alt='현재 프로필']");
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(evt) {
        preview.src = evt.target.result;
      }
      reader.readAsDataURL(file);
    }
  });
</script>

<%@ include file="../../common/footer.jsp" %>
</body>
</html>
