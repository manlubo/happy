<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="common/head.jsp" %>
</head>
<body>
<%@ include file="common/header.jsp" %>
<div class="container px-0">

	<main class="d-flex justify-content-between mx-0">
            <div class="col-lg-8 px-0" style="max-width: 860px; width:100%;">
                <!-- 슬라이더 -->

				<div class="mb-4 table-responsive rounded-4 overflow-hidden border">
	            <table class="table m-0 text-center table-borderless">
	              <thead>
	                <tr>
	                  <th class="bg-light py-3">신규회원</th>
	                  <th class="bg-light py-3">방문회원</th>
	                  <th class="bg-light py-3">탈퇴회원</th>
	                  <th class="bg-light py-3">전체회원</th>
	                </tr>
	              </thead>
	              <tbody>


	                <tr>
	                  <td class="py-3"><span class="fw-semibold">0</span> 명</td>
	                  <td class="py-3"><span class="fw-semibold">0</span> 명</td>
	                  <td class="py-3"><span class="fw-semibold">0</span> 명</td>
	                  <td class="py-3"><span class="fw-semibold">0</span> 명</td>
	                </tr>
	              </tbody>
	            </table>
	          </div>




	          <div class="mb-4 table-responsive rounded-4 overflow-hidden border" >
	            <table class="table table-borderless m-0 text-center">
	            <thead>
	              <tr>
	                <th class="bg-light py-3">신규 게시글</th>
	                <th class="bg-light py-3">승인대기</th>
	                <th class="bg-light py-3">모금기간 만료</th>
	                <th class="bg-light py-3">전체 게시글</th>
	              </tr>
	            </thead>
	            <tbody>
	              <tr>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${todayBoardCount}" />개</td>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${readyCount}" />개</td>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${totalVoidCount}" />개</td>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${totalBoardCount}" />개</td>
	              </tr>
	            </tbody>
	          </table>
	          </div>
	          
	
	          <div class="mb-4 table-responsive rounded-4 overflow-hidden border" >
	            <table class="table table-borderless m-0 text-center">
	            <thead>
	              <tr>
	                <th class="bg-light py-3">신규 결제</th>
	                <th class="bg-light py-3">환불 수</th>
	                <th class="bg-light py-3">전체 결제횟수</th>
	                <th class="bg-light py-3">전체 결제금액</th>
	              </tr>
	            </thead>
	            <tbody>
	              <tr>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${todayPayCount}" />건</td>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${totalRefundCount}" />건</td>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${totalPayCount}" />건</td>
	                <td class="py-3 fw-semibold"><fmt:formatNumber value="${totalAmount}" />원</td>
	              </tr>
	            </tbody>
	          </table>
          </div>




                
               
            </div>
            <%@ include file="common/adminmenu.jsp" %>
        </main>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>