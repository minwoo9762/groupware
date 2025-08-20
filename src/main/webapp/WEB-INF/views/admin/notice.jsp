<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp" %>
<section class="section admin">
    <%@include file="../lnb.jsp" %>
    <div class="main">
        <h2 class="title">Admin</h2>
        <div class="searchWrap">
            <input type="text" class="inputStyle" id="key"/>
            <button class="btn btnSearch" type="button" onClick="go_search(this)"/>
            검색
            </button>
        </div>
        <div class="tableWrap">
            <table style="table-layout: fixed;">
                <colgroup>
                    <col width="44px">
                    <col width="420px">
                    <col width="">
                    <col width="300px">
                </colgroup>
                <thead>
                <tr>
                    <th>No.</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>날짜</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${noticeList}" var="notice" varStatus="i">
                    <tr>
                        <td>${notice.nseq}</td>
                        <td class="content" style="text-align: center;">${notice.title}</td>
                        <td class="content" style="text-align: left;"><a href="noticeDetail?nseq=${notice.nseq}"><c:out value="${notice.content}" /></a></td>
                        <td>
                            <fmt:formatDate value="${notice.indate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="btnWrap topright">
                <button type="button" class="btn btnWrite" onclick="location.href='noticeWrite'">글 쓰기</button>
            </div>
            <div class="row">  <!-- 페이지의 시작 -->
                <div class="coltitle" style="text-align: center; font-size:120%; font-weight:bold;">
                    <c:if test="${paging.prev}"><a href="notice?page=${paging.beginPage-1}">◁</a></c:if>&nbsp;

                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                        <c:if test="${index!=paging.page}">
                            <a href="notice?page=${index}">${index}&nbsp;</a>
                        </c:if>
                        <c:if test="${index==paging.page}">
                            <span style="color:red">${index}&nbsp;</span>
                        </c:if>
                    </c:forEach>

                    &nbsp;
                    <c:if test="${paging.next}"><a href="notice?page=${paging.endPage+1}">▷</a></c:if>
                </div>
            </div>
            <%--페이지의 끝--%>
        </div>
    </div>
</section>

<script src="/script/admin.js"></script>
</body>
</html>