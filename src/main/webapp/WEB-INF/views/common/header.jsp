<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value="${fn:replace(reqUri, pageContext.request.contextPath, '')}" />
<header>
        <div class="container d-flex justify-content-between py-3 align-items-center px-0" >
            <a href="${cp }/index"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/logo/logo.svg" alt="Happy  Givers"></a>
            <nav>
                <ul class="d-flex list-unstyled align-items-center gap-4 m-0">
                    <li><a href="${cp }/board/list" class="p-4 text-decoration-none fw-semibold ${fn:contains(uri, '/board') ? 'text-primary' : ''}">기부</a></li>
                    <li><a href="${cp }/feed/list" class="p-4 text-decoration-none fw-semibold ${fn:contains(uri, '/feed') ? 'text-primary' : ''}" >피드</a></li>
                    <li><a href="${cp }/notice/list" class="p-4 text-decoration-none fw-semibold ${fn:contains(uri, '/notice') ? 'text-primary' : ''}" >공지사항</a></li>
                    <li><a href="${cp }/qna/list" class="p-4 text-decoration-none fw-semibold ${fn:contains(uri, '/qna') ? 'text-primary' : ''}">Q&A</a></li>
                </ul>
            </nav>
            <div class="d-flex align-items-center gap-4">
                <a href="#" class="p-3"><i class="fa-solid fa-magnifying-glass" style="color: var(--col-5);"></i></a>
                <a href="#" class="p-3" data-bs-toggle="offcanvas" data-bs-target="#sidebar" ><i class="fa-solid fa-bars" style="color: var(--col-5);"></i></a>
            </div>
        </div>
    </header>
    <%@ include file="sidebar.jsp" %>