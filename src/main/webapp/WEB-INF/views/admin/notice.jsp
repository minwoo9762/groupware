<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">

    <%@include file="../lnb.jsp" %>
<article>
    <form method="get" name="fr">
    <div class="tb">
        <div class="find-box">
            <div class="col search-box">
            <input type="text" name="key" placeholder="검색 제목 입력" value="${key}">
            <input type="button" name="btn_search" value="검색" onClick="go_search('notice')" />
            <input type="button" value="공지 작성" onclick="location.href='noticeWrite'" />
            </div>
        </div>

        <div class="header-row">
            <div class="coltitle">No.</div>
            <div class="coltitle">제목</div>
            <div class="coltitle">내용</div>
            <div class="coltitle">날짜</div>
        </div>

        <c:forEach items="${noticeList}" var="notice" varStatus="i">
            <div class="row">
                <div class="col">${notice.nseq}</div>
                <div class="col">${notice.title}</div>
                <div class="col">
                    <a href="noticeDetail?nseq=${notice.nseq}">
                        ${notice.content}
                    </a>
                </div>
                <div class="col">
                    <fmt:formatDate value="${notice.indate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </div>
            </div>
        </c:forEach>

            <div class="row">  <!-- 페이지의 시작 -->
        <div class="col" style="font-size:120%; font-weight:bold;">
            <c:if test="${paging.prev}" >
                <a href="notice?page=${paging.beginPage-1}">PREV</a>&nbsp;
            </c:if>

            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <c:if test="${index!=paging.page}">
                    <a href="notice?page=${index}">${index}</a>&nbsp;
                </c:if>
                <c:if test="${index==paging.page}">
                    <span style="color:red">${index}&nbsp;</span>
                </c:if>
            </c:forEach>


            <c:if test="${paging.next}" >
                <a href="notice?page=${paging.endPage+1}">NEXT</a>&nbsp;
            </c:if>
			</div>
            </div>
        </div>
    </form>
</article>
</div>


<%@ include file="../footer.jsp" %>