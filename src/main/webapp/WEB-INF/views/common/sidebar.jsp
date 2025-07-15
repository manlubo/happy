<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="offcanvas offcanvas-end" id="sidebar">
  <div class="p-3 bg-white" style="min-height: 100vh;">
    <!-- 프로필 -->
    <c:if test="${empty member}">
    <div class="d-flex align-items-center my-4">
      <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm38aJRuNJH9z0qvbVUWR9rDQ2N7DoUWDXSA&s" style="width: 40px; height: 40px; object-fit: cover"  class="rounded-circle me-3" alt="profile">
      <a href="${cp}/member/login?mtype=USER" class="text-secondary fw-semibold">로그인하세요.</a>
    </div>
    </c:if>
    <c:if test="${not empty member }">

        <div class="d-flex align-items-center gap-3 mb-3 mt-4">
          <div class="overflow-hidden rounded-circle" style="width: 40px; height: 40px; border: 2px solid var(--border-1);">

            <!-- 프로필자동값부여 있으면 그이미지로 없으면 기본이미지 -->
            <c:choose>
              <c:when test="${not empty member.profile}">
                <img src="${member.profile}" class="object-fit-cover" alt="프로필사진" style="width: 36px; height: 36px; object-fit: cover; object-position: center; display: block;;">
              </c:when>
              <c:otherwise>
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm38aJRuNJH9z0qvbVUWR9rDQ2N7DoUWDXSA&s" class="object-fit-cover" alt="기본프로필" style="width: 36px; height: 36px; object-fit: cover; object-position: center; display: block;">
              </c:otherwise>
            </c:choose>

          </div>
          <p class="fw-semibold fs-6 mb-0 flex-grow-1 text-truncate" style="color: var(--col-4);"><span style="color: var(--col-6);">${member.name }</span> 님</p>


          <a href="${cp}/member/logout" class="text-decoration-none border px-3 py-1 rounded-5 small" style="color: var(--col-3);">로그아웃</a>


        </div>
        <div class="p-3 rounded-3 mb-4" style="background-color: var(--col-1);">
          <div class="d-flex justify-content-around">
            <a href="${cp}/mypage/editprofile" class="text-decoration-none fw-medium small" style="color: var(--col-5);">프로필 수정</a>
            <a href="${cp}/mypage"class="text-decoration-none fw-medium small"style="color: var(--col-5);">마이페이지</a>
          </div>
        </div>
      <c:if test="${member.mtype == 'ORG'}">
      <a href="${cp }/board/write" class="btn btn-primary form-control py-2 fs-6 mb-4">모금 글 작성하기</a>
      </c:if>
    </c:if>
    <!-- 기부 메뉴 (아코디언 형식) -->
    <div class="accordion mb-3" id="donationMenu">
      <div class="accordion-item border-0">
        <h2 class="accordion-header">
          <button class="accordion-button py-3 px-3 bg-light rounded collapsed fs-5" type="button" data-bs-toggle="collapse" data-bs-target="#donationCollapse">
            기부
          </button>
        </h2>
        <div id="donationCollapse" class="accordion-collapse collapse show" data-bs-parent="#donationMenu">
          <div class="accordion-body py-2 px-3">
            <ul class="list-unstyled mb-0 mt-2 d-flex flex-column gap-2">
              <li class="mb-1"><a href="${cp}/board/list" class="text-decoration-none text-secondary">전체</a></li>
              <li class="mb-1"><a href="${cp}/board/list?cno=3" class="text-decoration-none text-secondary">청소년</a></li>
              <li class="mb-1"><a href="${cp}/board/list?cno=4" class="text-decoration-none text-secondary">어르신</a></li>
              <li class="mb-1"><a href="${cp}/board/list?cno=5" class="text-decoration-none text-secondary">동물</a></li>
              <li class="mb-1"><a href="${cp}/board/list?cno=6" class="text-decoration-none text-secondary">지구</a></li>
              <li class="mb-1"><a href="${cp}/board/list?cno=7" class="text-decoration-none text-secondary">환경</a></li>
              <li class="mb-1"><a href="${cp}/board/list?cno=8" class="text-decoration-none text-secondary">장애인</a></li>
              <li><a href="${cp}/board/list?cno=9" class="text-decoration-none text-secondary">사회</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!-- 피드 메뉴 -->
    <div class="mb-3">
      <a href="${cp}/feed/list" class="d-block py-3 px-3 bg-light text-decoration-none text-black rounded fs-5">피드 &rsaquo;</a>
    </div>


    <!-- 고객센터 메뉴 -->
    <div class="accordion mb-3" id="supportMenu">
      <div class="accordion-item border-0">
        <h2 class="accordion-header">
          <button class="accordion-button py-3 px-3 bg-light rounded collapsed fs-5" type="button" data-bs-toggle="collapse" data-bs-target="#supportCollapse">
            고객센터
          </button>
        </h2>
        <div id="supportCollapse" class="accordion-collapse collapse" data-bs-parent="#supportMenu">
          <div class="accordion-body py-2 px-3">
            <ul class="list-unstyled mb-0 mt-2 d-flex flex-column gap-2">
              <li><a href="${cp}/notice/list" class="text-decoration-none text-secondary">공지사항</a></li>
              <li><a href="${cp}/qna/list" class="text-decoration-none text-secondary">Q&A</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <hr>
  </div>
</div>
