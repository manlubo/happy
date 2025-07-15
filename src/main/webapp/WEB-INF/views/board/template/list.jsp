<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<div class="list-group">
                <div href="board _view.html" class="list-group-item">
                    <div class="row text-center align-items-center small text-black">
                        <span class="col-1 small">글 번호</span>
                        <span class="col text-start small text-center">제목</span>
                        <span class="col-2 small">작성일</span>
                    </div>
                </div>
                <c:forEach items="${boards}" var="b">
                <a href="view?bno=${b.bno}&${pageDto.cri.qs2}" class="list-group-item list-group-item-action">
                    <div class="row text-center align-items-center small text-muted">
                        <span class="col-1 small fw-bold">${b.bno}</span>
                        <span class="col text-start text-black">${b.title}</span>
                        <span class="col-2 small">${b.regdate }</span>
                    </div>
                </a>
                </c:forEach>
            </div>
            