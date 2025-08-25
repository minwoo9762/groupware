<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp" %>
<section class="section admin">
    <%@include file="../lnb.jsp" %>
    <div class="main">
        <h2 class="title">${title}</h2>
        <ul class="tabList">

            <li style="${parms == 1 ? 'font-weight: 700' : ''}" onclick="location.href='allInfoCtr?tabid=1'">직책</li>
            <li style="${parms == 2 ? 'font-weight: 700' : ''}" onclick="location.href='allInfoCtr?tabid=2'">부서</li>
            <li style="${parms == 3 ? 'font-weight: 700' : ''}" onclick="location.href='allInfoCtr?tabid=3'">직원 상태</li>
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

                    <c:forEach items="${infoList}" var="info" varStatus="i">
                        <div class="tr">
                            <div class="tl">
                                    ${i.count}
                            </div>
                            <div class="td">
                                    ${info.name}
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <form class="table fncTable" action="allInfoCtrAction?tabid=${parms}" method="post">
                    <h3 class="tableTitle">변경 구성</h3>
                    <div class="tr">
                        <div class="tl tableHeader">
                            No.
                        </div>
                        <div class="td tableHeader">
                            ${title}
                        </div>
                    </div>

                    <c:forEach items="${infoList}" var="info" varStatus="i">
                        <div class="tr">
                            <div class="tl">
                                    ${i.count}
                                <input type="hidden" name="id" value="${info.id}">
                            </div>
                            <div class="td fnc">
                                <input type="text" name="name" value="${info.name}" maxlength="10"/>
                            </div>
                            <c:choose>
                                <c:when test="${i.index==0}">
                                    <div class="td delete">
                                        <button type="button" class="deleteInfo disable">
                                            삭제
                                        </button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="td delete">
                                        <button type="button" class="deleteInfo" onclick="deleteInfo(this)">
                                            삭제
                                        </button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                    <div class="bthWrap">
                        <button id="infoSave" type="submit">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script src="/script/admin.js"></script>
</body>
</html>