<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.7/js/bootstrap.min.js" integrity="sha512-zKeerWHHuP3ar7kX2WKBSENzb+GJytFSBL6HrR2nPSR1kOX1qjm+oHooQtbDpDBSITgyl7QXZApvDfDWvKjkUw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.7/css/bootstrap.min.css" integrity="sha512-fw7f+TcMjTb7bpbLJZlP8g2Y4XcCyFZW8uy8HsRZsH/SwbMw0plKHFHr99DN3l04VsYNwvzicUX/6qurvIxbxw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.7/js/bootstrap.bundle.min.js" integrity="sha512-Tc0i+vRogmX4NN7tuLbQfBxa8JkfUSAxSFVzmU31nVdHyiHElPPy2cWfFacmCJKw0VqovrzKhdd2TSTMdAxp2g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div class="container px-0">

	<main class="d-flex justify-content-between mx-0">
            <div class="px-0" style="max-width: 860px; width:100%;">
              <div>
	            <ul class="list-group small">
	              <li class="list-group-item ">
	                <div class="row my-0 align-items-center">
	                  <span class="col-1 text-center fw-bold">글 번호</span>
	                  <span class="col-1 text-center fw-bold">분류</span>
	                  <span class="col text-center fw-bold">제목</span>
	                  <span class="col-1 text-center fw-bold">작성자</span>
	                  <span class="col-2 text-center fw-bold">목표금액</span>
	                  <span class="col-1 text-center fw-bold">등록일</span>
	                  <span class="col-1 text-center fw-bold">마감일</span>
	                  <span class="col-2 text-center fw-bold">관리</span>
	                </div>
	              </li>
	              <c:forEach items="${boards }" var="b">
	              <li class="list-group-item">
	                <div class="row my-0 align-items-center">
	                  <span class="col-1 text-center">${b.bno}</span>
	                  <span class="col-1 text-center">${b.cname }</span>
	                  <span class="col text-center text-truncate"><a href="${cp}/board/view?bno=${b.bno}" class="text-black ">${b.title}</a></span>
	                  <span class="col-1 text-center">${b.name }</span>
	                  <span class="col-2 text-center"><fmt:formatNumber value="${b.round.goalamount}" />원</span>
	                  <span class="col-1 text-center">${b.regdate}</span>
	                  <span class="col-1 text-center">${b.round.voiddate}</span>
	                  <div class="btn-group btn-group-sm col-2">
	                    <a href="${cp }/admin/board/orgboardstatuschange?bno=${b.bno}&status=ACTIVE&name=${b.name}" class="btn btn-outline-secondary">승인</a>
	                  </div>
	                </div>
	              </li>
	              </c:forEach>
	            </ul>
	
	          </div>
          </div>

            <%@ include file="../common/adminmenu.jsp" %>
            
        </main>
</div>



                
               
        <%@ include file="../../common/footer.jsp" %>
</body>
</html>