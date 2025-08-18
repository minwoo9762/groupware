<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>

    <div class="main">
        <h2 class="title" style="font-size:40px;">이메일</h2>
        <div class="searchWrap">
            <input type="text" />
            <input type="button" />
                검색
        </div>
        <div class="tableWrap">
            <div class="table">
                <div class="thead">
                    <div class="tr">
                        <div class="th" style="flex: 1">No.</div>
                        <div class="th"  style="flex: 2">보낸이</div>
                        <div class="th"  style="flex: 8">내 용</div>
                        <div class="th"  style="flex: 2"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="writebutton">
            <input type="button" value="이메일 보내기" onclick="location.href='writeEmail'" />
        </div>
    <div style="display: flex; justify-content: center; font-size: 105%">
            <c:if test="${paging.prev}" >
                <a href="main?page=${paging.beginPage-1}">PREV</a>&nbsp;
            </c:if>
            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <c:if test="${index!=paging.page}">
                    <a href="main?page=${index}">${index}</a>&nbsp;
                </c:if>
                <c:if test="${index==paging.page}">
                    <span style="color:red">${index}&nbsp;</span>
                </c:if>
            </c:forEach>
            <c:if test="${paging.next}" >
                <a href="main?page=${paging.endPage+1}">NEXT</a>&nbsp;
            </c:if>
        </div>
    </div>

</section>

</body>
</html>
