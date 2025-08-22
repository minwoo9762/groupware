<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp" %>
<section class="section admin">
    <%@include file="../lnb.jsp" %>
    <div class="main">
        <h2 class="title">${title}</h2>
        <ul class="tabList">

            <li style="${parm == 1 ? 'font-weight: 700' : ''}" onclick="location.href='allInfoCtr?tabid=1'">직책</li>
            <li style="${parm == 2 ? 'font-weight: 700' : ''}" onclick="location.href='allInfoCtr?tabid=2'">부서</li>
            <li style="${parm == 3 ? 'font-weight: 700' : ''}" onclick="location.href='allInfoCtr?tabid=3'">직원 상태</li>
        </ul>
        <div class="tableWrap">
            <div class="boxWrap">
                <div class="table fncTable">
                    <h3 class="tableTitle">현재 구성</h3>
                    <div class="tr">
                        <div class="tl tableHeader">
                            No.
                        </div>
                        <div class="td tableHeader">
                            ${title}
                        </div>
                    </div>

                    <c:forEach items="${infoList}" var="info">
                        <div class="tr">
                            <div class="tl">
                                    ${info.id}
                            </div>
                            <div class="td">
                                    ${info.name}
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <form class="table fncTable">
                    <h3 class="tableTitle">변경 구성</h3>
                    <div class="tr">
                        <div class="tl tableHeader">
                            No.
                        </div>
                        <div class="td tableHeader">
                            ${title}
                        </div>
                    </div>

                    <c:forEach items="${infoList}" var="info">
                        <div class="tr">
                            <div class="tl">
                                    ${info.id}
                            </div>
                            <div class="td">
                                <input type="text" name="name" value="${info.name}" maxlength="10"/>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="bthWrap">
                        <button id="infoSave" type="submit">저장</button>
                    </div>
                </form>
            </div>


            <%--<div class="row">  <!-- 페이지의 시작 -->
                <div class="coltitle" style="text-align: center; font-size:120%; font-weight:bold;">
                    <c:if test="${paging.prev}"><a href="admin?page=${paging.beginPage-1}">◁</a></c:if>&nbsp;

                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                        <c:if test="${index!=paging.page}">
                            <a href="admin?page=${index}">${index}&nbsp;</a>
                        </c:if>
                        <c:if test="${index==paging.page}">
                            <span style="color:red">${index}&nbsp;</span>
                        </c:if>
                    </c:forEach>

                    &nbsp;
                    <c:if test="${paging.next}"><a href="admin?page=${paging.endPage+1}">▷</a></c:if>
                </div>
            </div>--%>
            <%--페이지의 끝--%>
        </div>
    </div>
</section>

<script src="/script/admin.js"></script>
</body>
</html>