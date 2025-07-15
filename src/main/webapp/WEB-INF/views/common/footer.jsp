<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<footer style="background-color: var(--col-1);" class="py-4">
        <div class="container px-0">
            <div class="d-flex justify-content-between align-items-center">
                <a href="${cp}/index"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/logo/logo_f.svg" alt="Happy Givers"></a>
                <a href="https://github.com/manlubo/happygivers"><i class="fa-brands fa-github fs-4" style="color: var(--col-5);"></i></a>
            </div>
            <ul class="list-unstyled d-flex gap-3 small mt-5 mb-3">
                <li><a href="${cp}/notice/list" class="text-decoration-none" style="color: var(--col-5);">공지사항</a></li>
                <li><a href="${cp}/qna/list" class="text-decoration-none" style="color: var(--col-5);">Q&A</a></li>
                <li><a href="${cp}/privacy" class="text-decoration-none fw-bold" style="color: var(--col-5);">개인정보처리방침</a></li>
                <li><a href="${cp}/terms" class="text-decoration-none" style="color: var(--col-5);">이용약관</a></li>
            </ul>
            <p class="small" style="color: var(--col-5);">&copy;Copyright Happy Givers All rights reserved.</p>
        </div>
    </footer>