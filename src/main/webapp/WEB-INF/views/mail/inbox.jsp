<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>
<section class=" section mail">
<%@include file="../lnb.jsp"%>
    <div class="main">
        <h2 class="title" style="font-size:40px;">받은메일함</h2>
        <form class="searchWrap" action="mail">
            <input type="text" name="key" placeholder="제목 검색" value="${key}">
            <input type="submit" value="검색">
        </form>
        <div class="writebutton" style="display: flex; justify-content: flex-end">
            <input type="button" value="메일 작성" onclick="location.href='writeMailForm'">
        </div>
        <div class="mailList">
            <div class="tableWrap">
                <div class="table">
                    <div class="thead" style="display: flex">
                        <div class="th" style="flex: 1">보낸사람</div>
                        <div class="th" style="flex: 8">제목</div>
                        <div class="th" style="flex: 2">작성일</div>
                        <div class="th" style="flex: 1">답장여부</div>
                    </div>
                    <c:choose>
                        <c:when test="${empty receiveList}">
                            <div class="tr" style="text-align: center"><br>메일이 없습니다.<br>&nbsp;</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${receiveList}" var="receive">
                                <div class="tr" style="display: flex; color:${receive.read ? 'gray' : 'black'}">
                                    <div class="td" style="flex: 1">${receive.senderName}</div>
                                    <div class="td" style="flex: 8">
                                        <a href="mailDetail?id=${receive.id}&from=inbox" style="color:inherit !important">
                                            ${receive.subject}
                                        </a>
                                    </div>
                                    <div class="td" style="flex: 2">
                                        <fmt:formatDate value="${receive.indate}" type="date" />
                                    </div>
                                    <div class="td" style="flex: 1">${receive.replyCount!=0 ? '○' : '×'}</div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

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