<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>
<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>
    <article>
        <div>
            <div class="tb">
                <div class="find-box">
                    <form class="col search-box" action="inbox">
                        <input type="text" name="key" placeholder="제목 검색" value="${key}">
                        <input type="submit" value="검색">
                        <input type="button" value="메일 작성" onclick="location.href='writeMailForm'">
                    </form>
                </div>
                <div class="mailbox">받은메일함</div>
                <div class="header-row">
                    <div class="coltitle" style="flex: 1">보낸사람</div>
                    <div class="coltitle" style="flex: 4">제목</div>
                    <div class="coltitle" style="flex: 2">작성일</div>
                    <div class="coltitle" style="flex: 1">답장여부</div>
                </div>
                <c:choose>
                    <c:when test="${empty receiveList}">
                        <div class="row" style="text-align: center"><br>메일이 없습니다.<br>&nbsp;</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${receiveList}" var="receive">
                            <div class="row" style="display: flex; color:${receive.read ? 'gray' : 'black'}">
                                <div class="col" style="flex: 1">${receive.senderName}</div>
                                <div class="col" style="flex: 4">
                                    <a href="mailDetail?id=${receive.id}&from=inbox" style="color:inherit !important">${receive.subject}</a>
                                </div>
                                <div class="col" style="flex: 2">
                                    <fmt:formatDate value="${receive.indate}" type="date" />
                                </div>
                                <div class="col" style="flex: 1">${receive.replyCount!=0 ? '○' : '×'}</div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
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
    </article>
</div>
</body>
</html>