<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">

    <%@include file="../lnb.jsp"%>

<article>
    <form method="get" name="frm">
        <div class="tb">
            <div class="find-box">
            <select name="part" class="dropdown">
                <c:forEach items="${partList}" var="part">
                    <option value="${part.id}">${part.name}</option>
                </c:forEach>
            </select>
            <div class="col search-box">
                <input type="text" name="key" placeholder="검색 제목 입력" value="${key}">
                <input type="button" name="btn_search" value="검색" onclick="go_searchWork('appMain')" />
                <c:if test="${loginUser.provider != 1}">
                <input type="button" value="결재 신청" onclick="location.href='appWrite'" />
                </c:if>
            </div>
            </div>

        <div class="header-row">
            <div class="coltitle">부서명</div>
            <div class="coltitle">사용자명</div>
            <div class="coltitle">카테고리</div>
            <div class="coltitle">제 목</div>
            <div class="coltitle">작성 일자</div>
            <div class="coltitle">상 태</div>
        </div>

        <c:forEach items="${appList}" var="app">
        <a href="appView?id=${app.id}" style="text-decoration: none; color: inherit; padding-left: 0;">
            <div class="row">
                <div class="col">
                   <c:forEach items="${partList}" var="part">
                        <c:if test="${app.part == part.id}">
                            ${part.name}
                        </c:if>
                    </c:forEach>
                </div>
                <div class="col">
                    ${app.username}
                </div>
                <div class="col">
                    <c:choose>
                        <c:when test="${app.category == 0}">휴가</c:when>
                        <c:when test="${app.category == 1}">영수증</c:when>
                        <c:when test="${app.category == 2}">법인차량</c:when>
                        <c:otherwise>미정</c:otherwise>
                    </c:choose>
                </div>
                <div class="col">
                         ${app.title}

                </div>
                <div class="col">
                    <fmt:formatDate value="${app.indate}" pattern="yyyy-MM-dd"/>
                </div>
                <div class="col">
                    <c:choose>
                        <c:when test="${app.status == 0}">결재대기</c:when>
                        <c:when test="${app.status == 1}">결재보류</c:when>
                        <c:when test="${app.status == 2}">결재완료</c:when>
                        <c:otherwise>미정</c:otherwise>
                    </c:choose>
                </div>
            </div>
            </a>
        </c:forEach>

        <div class="row">  <!-- 페이지의 시작 -->
        <div class="col" style="font-size:120%; font-weight:bold;">
            <c:if test="${paging.prev}" >
                <a href="appMain?page=${paging.beginPage-1}">PREV</a>&nbsp;
            </c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <c:if test="${index!=paging.page}">
                    <a href="appMain?page=${index}">${index}</a>&nbsp;
                </c:if>
                <c:if test="${index==paging.page}">
                    <span style="color:red">${index}&nbsp;</span>
                </c:if>
            </c:forEach>


            <c:if test="${paging.next}" >
                <a href="appMain?page=${paging.endPage+1}">NEXT</a>&nbsp;
            </c:if>
			</div>
            </div>
        </div>
    </form>
</article>
</div>


<%@ include file="../footer.jsp" %>