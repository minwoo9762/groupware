<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../header.jsp" %>

<!-- ✅ layout 시작 -->
<div class="layout">

    <!-- ✅ 왼쪽 메뉴 -->
<%@ include file="../../lnb.jsp" %>

<article>
    <form method="get" name="frm">
        <div class="tb">
            <div class="row">
                <div class="col">
                    <input type="text" name="key" value="${key}"/>
                    <input type="button" name="btn_search" value="검색"  onClick="go_search('vacationList')" />
                    <input type="button"  style="margin-left:auto" value="상품등록" onClick="location.href='vacationWriteForm'" />
                </div>
            </div>

            <div class="row">
                <div class="coltitle">번호</div>
                <div class="coltitle">제목</div>
                <div class="coltitle">등록자</div>
                <div class="coltitle">등록일</div>
            </div>

            <c:forEach items="${vList}" var="VacationDto">
                <div class="row">
                    <div class="col">"${VacationDto.pseq}"</div>
                    <div class="col" style="cursor: pointer" onclick="go_detail('${VacationDto.pseq}')">${VacationDto.title}</div>
                    <div class="col">${VacationDto.userid}</div>
                    <div class="col"><fmt:formatDate value="${productVO.indate}"/></div>
                    <div class="col">
                        <c:choose>
                            <c:when test='${VacationDto.check=="N"}'>미확인</c:when>
                            <c:otherwise>확인</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>

            <div class="row">  <!-- 페이지의 시작 -->
                <div class="col" style="font-size:120%; font-weight:bold;">
                    <c:if test="${paging.prev}" ><a href="adminProductList?page=${paging.beginPage-1}">PREV</a>&nbsp;</c:if>

                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                        <c:if test="${index!=paging.page}"><a href="adminProductList?page=${index}">${index}</a>&nbsp;                        </c:if>
                        <c:if test="${index==paging.page}"><span style="color:red">${index}&nbsp;</span></c:if>
                    </c:forEach>

                    <c:if test="${paging.next}" ><a href="adminProductList?page=${paging.endPage+1}">NEXT</a>&nbsp;</c:if>
                </div>
            </div><!-- 페이지의 끝 -->

        </div>
    </form>
</article>


<%@ include file="../../footer.jsp" %>