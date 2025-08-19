<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/vacation.css">

<!-- ✅ layout 시작 -->
<div class="layout" style="display: flex;">

    <!-- ✅ 왼쪽 메뉴 -->
    <%@ include file="../lnb.jsp" %>

    <article>
        <form method="get" name="frr">
            <div class="tb">
                <div class="row">
                    <div class="col" style="display: flex; align-items: center;">
                        <input type="text" name="key" value="${key}" />&nbsp;
                        <input type="button" name="v_search" value="검색">
                        <input type="button"  style="margin-left:auto" value="결재신청" onClick="location.href='approval/approvalWrite'" />
                    </div>
                </div>

                <div class="row">
                    <div class="coltitle">번호</div>
                    <div class="coltitle">제목</div>
                    <div class="coltitle">등록자</div>
                    <div class="coltitle">등록일</div>
                    <div class="coltitle">확인/미확인</div>
                </div>

                <c:forEach items="${vacationList}" var="VacationDto">
                    <div class="row">
                        <div class="col">${VacationDto.pseq}</div>
                        <div class="col">
                            <a href="vacationDetail?pseq=${VacationDto.pseq}" style="display: block; text-decoration: none; color: inherit; padding-left: 10px;">
                               ${VacationDto.title}
                            </a>
                        </div>
                        <div class="col">${VacationDto.userid}</div>
                        <div class="col"><fmt:formatDate value="${VacationDto.indate}"/></div>
                        <div class="col">
                            <c:choose>
                                <c:when test='${VacationDto.checkyn=="N"}'>미확인</c:when>
                                <c:otherwise>확인</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>

                <div class="row">  <!-- 페이지의 시작 -->
                    <div class="col" style="font-size:120%; font-weight:bold;">
                        <c:if test="${paging.prev}" ><a href="vacation?page=${paging.beginPage-1}">◀</a>&nbsp;</c:if>

                        <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                            <c:if test="${index!=paging.page}"><a href="vacation?page=${index}">${index}</a>&nbsp;</c:if>
                            <c:if test="${index==paging.page}"><span style="color:red">${index}&nbsp;</span></c:if>
                        </c:forEach>

                        <c:if test="${paging.next}" ><a href="vacation?page=${paging.endPage+1}">▶</a>&nbsp;</c:if>
                    </div>
                </div><!-- 페이지의 끝 -->
            </div>
        </form>
    </article>
</div>

<%@ include file="../footer.jsp" %>