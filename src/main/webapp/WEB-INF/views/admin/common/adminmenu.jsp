<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value="${fn:replace(reqUri, pageContext.request.contextPath, '')}" />
<div class="col-lg-4 px-0" style="max-width: 200px; width:100%;">

                
                <!-- 공지사항 -->
                <div class="border rounded-3 p-4 d-flex flex-column gap-4">
                    <div>
                        <div class="d-flex">
                            <p class="fs-5 fw-semibold m-0" style="color: var(--col-6);">회원</p>
                        </div>
                        <ul class="p-0 d-flex flex-column mt-2 mb-0">
                            <li><a href="#" class="text-decoration-none text-truncate py-2  d-block " style="color: var(--col-3);">회원목록 조회</a></li>
                            <li><a href="${cp}/admin/member/orgapprove?ctype=MEMBER" class="text-decoration-none text-truncate py-2  d-block ${fn:contains(uri, '/admin/member/orgapprove') ? 'text-primary' : ''}" style="color: var(--col-3);">기관회원 승인</a></li>
                            <li><a href="${cp}/admin/member/orgstatus?ctype=MEMBER" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/member/orgstatus') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">기관회원 승인여부 조회</a></li>
                            <li><a href="#" class="text-decoration-none text-truncate py-2  d-block" style="color: var(--col-3);">서브관리자 생성</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="d-flex">
                            <p class="fs-5 fw-semibold m-0" style="color: var(--col-6);">기부/결제</p>
                        </div>
                        <ul class="p-0 d-flex flex-column mt-2 mb-0">
                            <li><a href="${cp }/admin/donate/roundlist?ctype=DONATE" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/donate/roundlist') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">모금함 조회</a></li>
                            <li><a href="${cp }/admin/donate/actionlist" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/donate/actionlist') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">기부내역 조회</a></li>
                            <li><a href="${cp }/admin/donate/paylist" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/donate/paylist') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">결제내역 조회</a></li>
                            <li><a href="${cp }/admin/donate/refundlist" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/donate/refundlist') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">환불 로그</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="d-flex">
                            <p class="fs-5 fw-semibold m-0" style="color: var(--col-6);">게시판</p>
                        </div>
                        <ul class="p-0 d-flex flex-column mt-2 mb-0">
                            <li><a href="${cp }/admin/board/orgcheck" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/board/orgcheck') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">기부 게시글 승인</a></li>
                            <li><a href="${cp }/admin/board/list" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/board/list') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">게시글 관리</a></li>
                            <li><a href="${cp}/admin/reply/list" class="text-decoration-none text-truncate py-2 ${fn:contains(uri, '/admin/reply/list') ? 'text-primary' : ''} d-block" style="color: var(--col-3);">댓글 관리</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="d-flex">
                            <p class="fs-5 fw-semibold m-0" style="color: var(--col-6);">기타 관리</p>
                        </div>
                        <ul class="p-0 d-flex flex-column mt-2 mb-0">
                            <li><a href="#" class="text-decoration-none text-truncate py-2  d-block" style="color: var(--col-3);">로그인 로그</a></li>
                            <li><a href="#" class="text-decoration-none text-truncate py-2  d-block" style="color: var(--col-3);">탈퇴회원 로그</a></li>
                            <li><a href="#" class="text-decoration-none text-truncate py-2  d-block" style="color: var(--col-3);">이메일 인증 로그</a></li>
                            <li><a href="#" class="text-decoration-none text-truncate py-2  d-block" style="color: var(--col-3);">뱃지 관리</a></li>
                        </ul>
                    </div>
                    
                </div>
                
            </div>