<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
        <div class="container d-flex justify-content-between py-3 align-items-center px-0" >
            <a href="${cp }/admin"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/logo/logo.svg" alt="Happy  Givers"></a>
  
            <div class="dropdown ">
			  <a class="overflow-hidden rounded-5 d-block dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false" style="width: 40px; height: 40px; border: 2px solid var(--col-main);">
			    <img src="${member.profile}" class="object-fit-cover" alt="프로필사진" style="width: 36px; height: 36px;">
			  </a>
			
			  <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink">
			    <li><a class="dropdown-item py-2" href="#">Logout</a></li>
			  </ul>
			</div>
        </div>
    </header>