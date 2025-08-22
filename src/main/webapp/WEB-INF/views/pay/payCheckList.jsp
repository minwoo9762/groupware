<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/payCheckList.css">

<!-- ✅ layout 시작 -->
<div class="layout" style="display: flex;" id="main">

    <!-- ✅ 왼쪽 메뉴 -->
    <%@ include file="../lnb.jsp" %>

        <article>
            <form method="get" name="fr">
                <div class="tb">
                    <div class="row">
                        <div class="col search-box">
                            제목&nbsp;<input type="text" name="key" value="${key}"/>&nbsp;
                            <input type="button" name="p_search" value="검색" onclick="go_search('paycheck')"/>
                        </div>
                    </div>

                    <div class="header-row">
                        <div class="coltitle">번호</div>
                        <div class="coltitle">제목</div>
                        <div class="coltitle">등록일</div>
                    </div>

                    <c:forEach items="${payList}" var="PayDto">
                        <div class="row">
                            <div class="col">${PayDto.pseq}</div>
                            <div class="col">
                                <a href="payDetail?pseq=${PayDto.pseq}" style="display: block; text-decoration: none; color: inherit; padding-left: 10px;">
                                    ${PayDto.title}
                                </a>
                            </div>
                            <div class="col"><fmt:formatDate value="${PayDto.indate}" pattern="yyyy-MM-dd"/></div>
                        </div>
                    </c:forEach>

                    <div class="row">  <!-- 페이지의 시작 -->
                    <div class="col" style="font-size:120%; font-weight:bold;">
                        <c:if test="${paging.prev}" ><a href="paycheck?page=${paging.beginPage-1}">◀</a>&nbsp;</c:if>

                        <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                            <c:if test="${index!=paging.page}"><a href="paycheck?page=${index}">${index}</a>&nbsp;</c:if>
                            <c:if test="${index==paging.page}"><span style="color:red">${index}&nbsp;</span></c:if>
                        </c:forEach>

                        <c:if test="${paging.next}" ><a href="paycheck?page=${paging.endPage+1}">▶</a>&nbsp;</c:if>
                    </div>
                </div><!-- 페이지의 끝 -->
            </div>
        </form>
    </article>
</div>


<%@ include file="../footer.jsp" %>