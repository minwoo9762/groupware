<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>

    <div class="main">
        <h2 class="title" style="font-size:40px;">Mail</h2>
        <form class="searchWrap" action="mail">
            <input type="text" name="key" placeholder="제목 검색" value="${key}">
            <input type="submit" value="검색">
        </form>
        <div class="writebutton" style="display: flex; justify-content: flex-end">
            <input type="button" value="메일 작성" onclick="location.href='writeMail'">
        </div>
        <div class="content" style="display: flex; flex-direction: column; justify-content: space-around">
            <div class="mailList">
                <h2><a href="location.href='inbox'">최근 받은메일함</a></h2>
                <div class="tableWrap">
                    <div class="table">
                        <div class="thead" style="display: flex">
                            <div class="th" style="flex: 1">보낸사람</div>
                            <div class="th" style="flex: 4">제목</div>
                            <div class="th" style="flex: 2">작성일</div>
                            <div class="th" style="flex: 1">답장여부</div>
                        </div>
                        <c:forEach items="${receiveList}" var="receive">
                            <div class="tr" style="display: flex; color:${receive.read ? 'gray' : 'black'}">
                                <div class="td" style="flex: 1">${receive.senderName}</div>
                                <div class="td" style="flex: 4">${receive.subject}</div>
                                <div class="td" style="flex: 2">
                                    <fmt:formatDate value="${receive.indate}" type="date" />
                                </div>
                                <c:choose>
                                    <c:when test="${receive.reply} != 0">
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
            </div>
            <div class="mailList">
                <h2><a href="location.href='sent'">최근 보낸메일함</a></h2>
                <div class="tableWrap">
                    <div class="table">
                        <div class="thead" style="display: flex">
                            <div class="th" style="flex: 1">받은사람</div>
                            <div class="th" style="flex: 4">제목</div>
                            <div class="th" style="flex: 2">작성일</div>
                            <div class="th" style="flex: 1">답장여부</div>
                        </div>
                        <c:forEach items="${sendList}" var="send">
                            <div class="tr" style="display: flex; color:${send.read ? 'gray' : 'black'}">
                                <div class="td" style="flex: 1">${send.receiverName}</div>
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
            </div>
        </div>
    </div>

</section>

</body>
</html>
