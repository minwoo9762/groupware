<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
<%@include file="../lnb.jsp"%>
    <div class="main">
        <h2 class="title" style="font-size:40px;">받은메일함</h2>
        <form class="searchWrap" action="mail">
            <input type="text" name="key" placeholder="제목 검색" value="${key}">
            <input type="submit" value="검색">
        </form>
        <div class="writebutton" style="display: flex; justify-content: flex-end">
            <input type="button" value="메일 작성" onclick="location.href='writeMail'">
        </div>
        <div class="mailList">
            <div class="tableWrap">
                <div class="table">
                    <div class="thead" style ="display: flex">
                        <div class="th" style="flex: 1">보낸사람</div>
                        <div class="th"  style="flex: 4">제목</div>
                        <div class="th"  style="flex: 2">작성일</div>
                        <div class="th"  style="flex: 1">답장여부</div>
                    </div>
                    <c:forEach items="${sendList}" var="send">
                        <div class="tr" style="display: flex; color:${send.read ? 'gray' : 'black'}">
                            <div class="td" style="flex: 1">${send.senderName}</div>
                            <div class="td" style="flex: 4">${send.subject}</div>
                            <div class="td" style="flex: 2">
                                <fmt:formatDate value="${send.indate}" type="date" />
                            </div>
                            <c:choose>
                                <c:when test="${send.reply} != 0">
                                    <div class="td" style="flex: 1">○</div>
                                </c:when>
                                <c:otherwise>
                                <div class="td" style="flex: 1">×</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
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
    </div>
</section>
</body>
</html>