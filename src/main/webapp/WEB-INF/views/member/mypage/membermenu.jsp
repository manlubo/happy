<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value="${fn:replace(reqUri, pageContext.request.contextPath, '')}" />
<div class="col-lg-4 px-0" style="max-width: 360px; width:100%;">

                <div class="border rounded-3">
                    <div class="p-4 d-flex align-items-center gap-3 border-bottom">
                        <div class="overflow-hidden rounded-circle" style="width: 64px; height: 64px; border: 2px solid var(--border-1);">
                            <img src="${member.profile}" class="object-fit-cover" alt="프로필사진" style="width: 100%; height: 100%; object-fit: cover; object-position: center; display: block;">
                        </div>
                        <p class="fw-semibold fs-6 mb-0 flex-grow-1 text-truncate" style="color: var(--col-4);"><span style="color: var(--col-6);">${member.name }</span> 님</p>
                        
                        
                        <a href="${cp}/member/logout" class="text-decoration-none border px-3 py-1 rounded-5 small" style="color: var(--col-3);">로그아웃</a>
                        
                        
                    </div>
                    <div class="p-2">
                    	<c:if test="${member.emailcheck}">
	                        <span class="text-primary small p-4" style="white-space: nowrap;">
	                            <i class="fa-solid fa-circle-check me-1 text-success"></i> 이메일 인증 완료
	                        </span>
	                    </c:if>
                    	<c:if test="${member.emailcheck == false}">
	                        <span class=" small p-4" style="white-space: nowrap;">
	                            <a href="${cp}/mypage/email-verify" class="text-danger"><i class="fa-solid fa-triangle-exclamation" style="color: orange;"></i> 이메일 인증이 필요합니다.</a>
	                        </span>
	                    </c:if>
                    </div>
                    
                </div>
                <!-- 공지사항 -->
                <div class="border rounded-3 p-4 d-flex flex-column gap-4 mt-4">
                    <div>
                        <div class="d-flex">
                            <p class="fs-5 fw-semibold m-0" style="color: var(--col-6);">회원</p>
                        </div>
                        <ul class="p-0 d-flex flex-column mt-2 mb-0">
                            <li><a href="${cp}/mypage/editprofile"class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/mypage/editprofile') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">프로필 수정</a></li>
                         <li>
							 <a href="${cp}/mypage/updateinfo"
								 class="text-decoration-none text-truncate py-2 d-block ${fn:contains(uri, '/mypage/updateinfo') ? 'text-primary' : ''}"
								  style="color: var(--col-3);">회원정보 수정</a>
							</li>
							
							 <li><a href="${cp}/mypage?page=update-password" class="text-decoration-none ${fn:contains(uri, 'password') ? 'text-primary' : ''} text-truncate py-2  d-block" style="color: var(--col-3);">비밀번호 변경</a></li>

                        </ul>
                    </div>
                    <div>
                        <div class="d-flex">
                            <p class="fs-5 fw-semibold m-0" style="color: var(--col-6);">기부/결제</p>
                        </div>
                        <ul class="p-0 d-flex flex-column mt-2 mb-0">
                            <li><a href="${cp}/mypage/action/list" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/mypage/action/list') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">기부내역 조회</a></li>
                            <li><a href="${cp}/mypage/pay/list" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/mypage/pay/list') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">결제내역 조회</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="d-flex">
                            <p class="fs-5 fw-semibold m-0" style="color: var(--col-6);">게시판</p>
                        </div>
                        <ul class="p-0 d-flex flex-column mt-2 mb-0">
                            <li><a href="${cp}/mypage/board/list" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/mypage/board/list') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">내가 쓴 게시글 조회</a></li>
                            <li><a href="${cp}/mypage/reply/list" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/mypage/reply/list') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">내가 쓴 댓글 조회</a></li>
                        </ul>
                    </div>

                    
                </div>
                
            </div>