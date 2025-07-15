<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="common/head.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.13/dayjs.min.js" integrity="sha512-FwNWaxyfy2XlEINoSnZh1JQ5TRRtGow0D6XcmAWmYCRgvqOUTnzCxPc9uF35u5ZEpirk1uhlPVA19tflhvnW1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.13/locale/ko.min.js" integrity="sha512-ycjm4Ytoo3TvmzHEuGNgNJYSFHgsw/TkiPrGvXXkR6KARyzuEpwDbIfrvdf6DwXm+b1Y+fx6mo25tBr1Icg7Fw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.13/plugin/relativeTime.min.js" integrity="sha512-MVzDPmm7QZ8PhEiqJXKz/zw2HJuv61waxb8XXuZMMs9b+an3LoqOqhOEt5Nq3LY1e4Ipbbd/e+AWgERdHlVgaA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style type="text/css">
.catemenu:hover p{ background-color: var(--col-main) !important; color: var(--col-0) !important;}
</style>
</head>
<body>
<c:if test="${not empty msg}">
    <script>alert('${msg}');</script>
</c:if>
<%@ include file="common/header.jsp" %>
	<div class="container px-0">
        <main class="row justify-content-between mx-0">
            <div class="col-lg-8 px-0" style="max-width: 700px;">
                <!-- 슬라이더 -->
                <div class="swiper rounded-4">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <a href="#"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/banner/mainbanner.png" alt="메인배너1"></a>
                        </div>
                        <div class="swiper-slide">
                            <a href="#"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/banner/mainbanner2.jpg" alt="메인배너2"></a>
                        </div>
                        <div class="swiper-slide">
                            <a href="#"><img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/banner/mainbanner3.png" alt="메인배너3"></a>
                        </div>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
                <!-- 메뉴 -->
                <div class="border p-4 rounded-4 mt-4">
                    <p class="fs-5 fw-semibold">나의 도움이 필요한 후원처</p>
                    <ul class="d-flex px-0 m-0">
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list" class="text-decoration-none d-flex flex-column align-items-center ">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/all.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">전체</p>
                            </a>
                        </li>
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list?cno=3" class="text-decoration-none d-flex flex-column align-items-center">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/kid.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">청소년</p>
                            </a>
                        </li>
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list?cno=4" class="text-decoration-none d-flex flex-column align-items-center">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/old.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">어르신</p>
                            </a>
                        </li>
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list?cno=5" class="text-decoration-none d-flex flex-column align-items-center">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/animal.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">동물</p>
                            </a>
                        </li>
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list?cno=6" class="text-decoration-none d-flex flex-column align-items-center">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/earth.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">지구</p>
                            </a>
                        </li>
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list?cno=7" class="text-decoration-none d-flex flex-column align-items-center">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/area.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">환경</p>
                            </a>
                        </li>
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list?cno=8" class="text-decoration-none d-flex flex-column align-items-center">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/needy.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">장애인</p>
                            </a>
                        </li>
                        <li style="width: 12.5%;" class="catemenu">
                            <a href="${cp }/board/list?cno=9" class="text-decoration-none d-flex flex-column align-items-center">
                                <img src="https://happygivers-bucket.s3.ap-northeast-2.amazonaws.com/static/icon/social.png" style="width: 32px;" alt="전체">
                                <p class="d-block py-1 m-0 rounded-5 text-center mt-2" style="background-color: var(--col-1); color: var(--col-6); min-width: 60px;">사회</p>
                            </a>
                        </li>
                    </ul>
                </div>
                <!-- 컨텐츠 1 -->
                <c:if test="${deadlineBoard != null }">
                <div class="border p-4 rounded-4 mt-4">
                    <p class="fs-5 fw-semibold mb-1">소중한 기부자를 찾고 있어요.</p>
                    <p class="fs-6 small" style="color: var(--col-3);">마감일까지 얼마 남지 않았어요!</p>
                    <div class="d-flex mt-4">
                        <div>
                            <div class="d-flex justify-content-between rounded-top-3" style="background-color: var(--col-6);">
                                <p class="m-2" style="color: var(--col-2);">남은 금액</p>
                                <p class="text-white m-2"><fmt:formatNumber value="${deadlineBoard.round.goalamount - deadlineBoard.round.nowamount }" /><span class="ms-2" style="color: var(--col-2);">원</span></p>
                            </div>
                            <div>
                                <img src="${deadlineBoard.thumbnail != null ? deadlineBoard.thumbnail : 'https://placehold.co/300x250?text=No+img' }" class="rounded-bottom-3" alt="img1" style="width: 280px; height:128px; object-fit: cover;  ">
                            </div>
                        </div>
                        <div class="d-flex flex-column justify-content-between ms-4 flex-grow-1">
                            <div class="card-body">
                                <p class="post-title mb-1 fw-semibold fs-6">${deadlineBoard.title }</p>
                                <div class="d-flex justify-content-between">
	                                <p class="post-meta mb-2 small" style="color: var(--col-3);">${deadlineBoard.name }</p>
	                                <p class="post-meta mb-2 small" style="color: var(--col-3);" data-voiddate="${deadlineBoard.round.voiddate }"></p>
                                </div>
                                <div class="progress my-2" style="height: 5px;">
                                    <div class="progress-bar" style="width:${Math.round(deadlineBoard.round.nowamount / deadlineBoard.round.goalamount * 100)}%"></div>
                                </div>
                                <div class="progress-wrapper d-flex justify-content-between mt-1">
                                    <span><strong><fmt:formatNumber value="${deadlineBoard.round.nowamount }" />원</strong></span>
                                    <span class="text-primary">${Math.round(deadlineBoard.round.nowamount / deadlineBoard.round.goalamount * 100)}%</span>
                                </div>
                            </div>
                            <a href="${cp }/board/view?bno=${deadlineBoard.bno}" class="btn btn-outline-light form-control" style="color: var(--col-3); border-color: var(--col-2);">기부하기</a>
                        </div>
                    </div>
                </div>
                </c:if>
                <!-- 컨텐츠 2 -->
                <c:if test="${newBoards != null }">
                <div class="border p-4 rounded-4 mt-4">
                    <p class="fs-5 fw-semibold mb-1">관심이 필요한 신규 모금함</p>
                    <p class="fs-6 small" style="color: var(--col-3);">당신의 따뜻한 관심이 필요해요!</p>
                    <ul class="px-0 d-flex justify-content-between mb-0">
                    	<c:forEach items="${newBoards }" var="b">
                        <li style="width: 31%;">
                            <a href="${cp }/board/view?bno=${b.bno}" class="text-decoration-none">
                                <div class="card-body">
                                    <img src="${b.thumbnail == null ? 'https://placehold.co/200x150?text=No+img' : b.thumbnail}" class="rounded-3" alt="이미지1" style="width:200px; height:140px; object-fit: cover;">
                                    <p class="post-title my-2 fw-medium fs-6" style="color: var(--col-6);">${b.title }</p>
                                    <p class="post-meta mb-2 small" style="color: var(--col-3);">${b.name }</p>
                                    <div class="progress my-2" style="height: 3px;">
                                        <div class="progress-bar" style="width:${Math.round(b.round.nowamount / b.round.goalamount * 100)}%"></div>
                                    </div>
                                    <div class="progress-wrapper d-flex justify-content-between mt-1">
                                        <span style="color: var(--col-6);"><strong><fmt:formatNumber value="${b.round.nowamount }" />원</strong></span>
                                        <span class="text-primary">${Math.round(b.round.nowamount / b.round.goalamount * 100)}%</span>
                                	</div>
                                    <p class="post-meta mb-2 small mt-1" style="color: var(--col-3);" data-voiddate="${b.round.voiddate }"></p>
                            	</div>
                            </a>
                        </li>
                    	</c:forEach>
                    </ul>
                </div>
                </c:if>
            </div>
            <div class="col-lg-4 px-0" style="max-width: 360px;">
                <!-- 로그인 전-->
                <c:if test="${empty member}">
                <div class="border p-4 rounded-3">
                    <p class="text-center" style="color: var(--col-5);">당신의 소중한 후원을 기다립니다.</p>
                    <a href="${cp }/member/login?mtype=USER" class="btn btn-primary form-control py-2 fs-6">로그인</a>
                    <ul class="d-flex gap-3 mt-3 mb-0 mx-auto px-0 justify-content-center small">
                        <li><a href="${cp}/member/find-id" class="text-decoration-none" style="color: var(--col-5);">아이디 찾기</a></li>
                       <li><a href="${cp}/member/findpw"class="text-decoration-none"style="color: var(--col-5);">비밀번호 찾기</a></li>
                        <li><a href="${cp}/member/register?mtype=USER" class="text-decoration-none" style="color: var(--col-5);">회원가입</a></li>

                    </ul>
                </div>
                </c:if>
                       
             



                <!-- 로그인 후-->
                <c:if test="${not empty member }">
                <div class="border rounded-3">
                    <div class="p-4 d-flex align-items-center gap-3 border-bottom">
                        <div class="overflow-hidden rounded-circle" style="width: 64px; height: 64px; border: 2px solid var(--border-1);">
                        
                        <!-- 프로필자동값부여 있으면 그이미지로 없으면 기본이미지 -->
                          <c:choose>
							  <c:when test="${not empty member.profile}">
							    <img src="${member.profile}" class="object-fit-cover" alt="프로필사진" style="width: 100%; height: 100%; object-fit: cover; object-position: center; display: block;;">
							  </c:when>
							  <c:otherwise>
							    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm38aJRuNJH9z0qvbVUWR9rDQ2N7DoUWDXSA&s" class="object-fit-cover" alt="기본프로필" style="width: 100%; height: 100%; object-fit: cover; object-position: center; display: block;">
							  </c:otherwise>
							</c:choose>

                        </div>
                        <p class="fw-semibold fs-6 mb-0 flex-grow-1 text-truncate" style="color: var(--col-4);"><span style="color: var(--col-6);">${member.name }</span> 님</p>
                        
                        
                        <a href="${cp}/member/logout" class="text-decoration-none border px-3 py-1 rounded-5 small" style="color: var(--col-3);">로그아웃</a>
                        
                        
                    </div>
                    <div class="p-3" style="background-color: var(--col-1);">
                        <div class="d-flex justify-content-around">
                            <a href="${cp}/mypage/editprofile" class="text-decoration-none fw-medium small" style="color: var(--col-5);">프로필 수정</a>
                             <a href="${cp}/mypage"class="text-decoration-none fw-medium small"style="color: var(--col-5);">마이페이지</a>
                        </div>
                    </div>
                </div>
                </c:if> 
               <!-- 후원처 -->
                <c:if test="${member.mtype == 'ORG' && member.emailcheck == true && member.status == 'ACTIVE' }">
                    <div class="border rounded-3 mt-4 p-4">
                        <div class="d-flex justify-content-between">
                            <p class="fs-6 fw-semibold m-0" style="color: var(--col-6);">현재 등록된 내 모금함</p>
                            <a href="${cp}/board/list?type=N&keyword=${member.name}" class="small text-decoration-none" style="color: var(--col-4);">더보기 <i class="fa-solid fa-chevron-right" style="color: var(--col-4);"></i></a>
                        </div>
                        <hr>
                        <c:if test="${not empty myDonates}">
                        <ul class="p-0 d-flex flex-column gap-3 m-0">
                            <c:forEach items="${myDonates}" var="d">
                                <li>
                                    <a href="${cp}/board/view?bno=${d.bno}" class="d-flex text-decoration-none">
                                        <img src="${d.thumbnail != null ? d.thumbnail : 'https://placehold.co/200x150?text=No+img'}" class="rounded-3" alt="이미지4" style="width: 100px; height: 85px; object-fit: cover;">
                                        <div class="ms-3">
                                            <p>${d.title}</p>
                                            <p class="m-0 small" style="color: var(--col-4);">${d.name}</p>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                        </c:if>
                        <a href="${cp }/board/write" class="btn btn-primary form-control fs-6 mt-4 py-2">모금 글 작성하기</a>
                    </div>
                </c:if>
				                
				                

                <!-- 기부금 -->
                <div class="border rounded-3 mt-4">
                    <div class="p-4">
                        <div class="d-flex justify-content-between">
                            <p class="fs-6 fw-semibold" style="color: var(--col-6);">전체 기부금</p>
                            <p class="small" style="color: var(--col-4);"><span class="today">2025.06.20</span> 기준</p>
                        </div>
                        <div class="rounded-3 py-2" style="background-color: var(--col-1);">
                            <p class="text-center fw-semibold fs-5 m-0"><fmt:formatNumber value="${totalAmount}" /><span>원</span></p>
                        </div>
                    </div>
                    <div class="p-4" style="background-color: var(--col-1);">
                        <div class="d-flex justify-content-between">
                            <p class="fs-6 fw-semibold" style="color: var(--col-6);">내 기부금</p>
                            <p class="small" style="color: var(--col-4);"><span class="today">2025.06.20</span> 기준</p>
                        </div>
                        <div class="rounded-3 py-2" style="background-color: var(--col-0);" >
                            <p class="text-center fw-semibold fs-5 m-0"><fmt:formatNumber value="${myTotalAmount}" /><span>원</span></p>
                        </div>
                    </div>


                </div>

                <!-- 공지사항 -->
                <c:if test="${notices != null}">
                <div class="border rounded-3 mt-4 p-4">
                    <div class="d-flex justify-content-between">
                        <p class="fs-6 fw-semibold m-0" style="color: var(--col-6);">공지사항</p>
                        <a href="${cp}/notice/list" class="small text-decoration-none" style="color: var(--col-4);">더보기 <i class="fa-solid fa-chevron-right" style="color: var(--col-4);"></i></a>
                    </div>
                    <hr>
                    <ul class="p-0 d-flex flex-column m-0">
                        <c:forEach items="${notices}" var="n">
                        <li><a href="${cp}/notice/view?bno=${n.bno}" class="text-decoration-none text-truncate py-3 border-bottom d-block" style="color: var(--col-6);">${n.title}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                </c:if>
                <!-- Q&A -->
                <c:if test="${qnas != null}">
                <div class="border rounded-3 mt-4 p-4">
                    <div class="d-flex justify-content-between">
                        <p class="fs-6 fw-semibold m-0" style="color: var(--col-6);">Q&A</p>
                        <a href="${cp}/qna/list" class="small text-decoration-none" style="color: var(--col-4);">더보기 <i class="fa-solid fa-chevron-right" style="color: var(--col-4);"></i></a>
                    </div>
                    <hr>
                    <ul class="p-0 d-flex flex-column m-0">
                        <c:forEach items="${qnas}" var="q">
                        <li><a href="${cp}/qna/view?bno=${q.bno}" class="text-decoration-none text-truncate py-3 border-bottom d-block" style="color: var(--col-6);">${q.title}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                </c:if>
            </div>
        </main>
    </div>
<%@ include file="common/footer.jsp" %>
<script>
        const swiper = new Swiper('.swiper', {
        // Optional parameters
        // direction: 'vertical',
        loop: true,

        // If we need pagination
        pagination: {
            el: '.swiper-pagination',
        },
        autoplay: {
            delay: 5000,   
            disableOnInteraction: true
        }
    });
    </script>
<script>
// 오늘 날짜 계산
$(function() {
    const today = new Date();

    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');

    const formatted =  year + '.' + month + '.' + day;

    
    $('.today').text(formatted);
  });
</script>
<script>
	dayjs.extend(window.dayjs_plugin_relativeTime);
	dayjs.locale('ko');
	const dayForm = 'YYYY-MM-DD HH:mm:ss';
	
	$("*[data-voiddate]").each((v,i) => {
		const date = $(i).data("voiddate");
		const deadlineText = dayjs(date, dayForm).fromNow();
		$(i).text(deadlineText + " 마감");
	})
</script>

</body>
</html>