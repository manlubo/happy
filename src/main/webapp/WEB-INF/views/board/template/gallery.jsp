<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty pageDto.cri.type}">
    <div class="d-flex justify-content-around mx-5">
        <div >
            <a href="${cp }/board/list"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/all.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == null ? 'active-tab' : 'tab'}">전체</button></a>
        </div>
        <div >
            <a href="${cp }/board/list?cno=3"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/kid.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == '3' ? 'active-tab' : 'tab'}">청소년</button></a>
        </div>
        <div >
            <a href="${cp }/board/list?cno=4"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/old.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == '4' ? 'active-tab' : 'tab'}" >어르신</button></a>
        </div>
        <div>
            <a href="${cp }/board/list?cno=5"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/animal.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == '5' ? 'active-tab' : 'tab'}" >동물</button></a>
        </div>
        <div>
            <a href="${cp }/board/list?cno=6"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/earth.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == '6' ? 'active-tab' : 'tab'}" >지구</button></a>
        </div>
        <div>
            <a href="${cp }/board/list?cno=7"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/area.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == '7' ? 'active-tab' : 'tab'}" >환경</button></a>
        </div>
        <div>
            <a href="${cp }/board/list?cno=8"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/needy.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == '8' ? 'active-tab' : 'tab'}" >장애인</button></a>
        </div>
        <div>
            <a href="${cp }/board/list?cno=9"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/social.png" alt="all"><button class="btn btn-sm rounded-4 ms-2 ${pageDto.cri.cno == '9' ? 'active-tab' : 'tab'}">사회</button></a>
        </div>
    </div>
</c:if>


<div class="my-5">
    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4" id="boardList">
        <!-- 포스트 -->
        <c:if test="${not empty boards}">
            <c:forEach items="${boards }" var="b">
                <div class="col">
                    <a href="${cp}/board/view?bno=${b.bno}" class="card post-card h-100 border-0 text-decoration-none">
                        <div class="overflow-hidden rounded-3">
                            <img src="${b.thumbnail != null ? b.thumbnail : 'https://placehold.co/300x250?text=No+img' }" class="card-img-top img-zoom " alt="Post Image">
                        </div>
                        <div class="card-body d-flex flex-column px-0 pt-2">
                            <p class="post-title my-2 fw-medium fs-6" style="color: var(--col-6);">${b.title }</p>
                            <p class="post-meta mb-2 small" style="color: var(--col-3);">${b.name}</p>
                            <div class="progress my-2" style="height: 3px;">
                                <div class="progress-bar" style="width:${Math.round(b.round.nowamount / b.round.goalamount * 100) > 100 ? '100' : Math.round(b.round.nowamount / b.round.goalamount * 100)}%"></div>
                            </div>
                            <div class="progress-wrapper d-flex justify-content-between">
                                <span><strong><fmt:formatNumber value="${b.round.nowamount}" />원</strong></span>
                                <span class="text-primary">${Math.round(b.round.nowamount / b.round.goalamount * 100)}%</span>
                            </div>
                            <div class="d-flex justify-content-between mt-2">
                                <small class="text-muted ">${b.round.donatecount }명 참여중</small>
                                <small class="text-muted voidDate" data-voiddate="${b.round.voiddate }"></small>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </c:if>

    </div>
</div>