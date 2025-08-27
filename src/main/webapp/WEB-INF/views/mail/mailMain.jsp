<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section mail">
    <%@include file="../lnb.jsp"%>
    <div class="main">
        <h2 class="title" style="font-size:40px;">Mail</h2>
        <form class="searchWrap" action="mail">
            <input type="text" name="key" placeholder="제목 검색" value="${key}">
            <input type="submit" value="검색">
        </form>
        <div class="writebutton" style="display: flex; justify-content: flex-end">
            <input type="button" value="메일 작성" onclick="location.href='writeMailForm'">
        </div>
        <div class="content" style="display: flex; flex-direction: column; justify-content: space-around">
            <div class="mailList">
                <h2><a href="inbox">최근 받은메일함</a></h2>
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
                                            <a href="mailDetail?id=${receive.id}&from=mail" style="color:inherit !important">
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
            </div>
            <div class="mailList">
                <h2><a href="sent">최근 보낸메일함</a></h2>
                <div class="tableWrap">
                    <div class="table">
                        <div class="thead" style="display: flex">
                            <div class="th" style="flex: 1">받은사람</div>
                            <div class="th" style="flex: 8">제목</div>
                            <div class="th" style="flex: 2">작성일</div>
                            <div class="th" style="flex: 1">답장여부</div>
                        </div>
                        <c:choose>
                            <c:when test="${empty sendList}">
                                <div class="tr" style="text-align: center"><br>메일이 없습니다.<br>&nbsp;</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${sendList}" var="send">
                                    <div class="tr" style="display: flex; color:${send.read ? 'gray' : 'black'}">
                                        <div class="td" style="flex: 1">${send.receiverName}</div>
                                        <div class="td" style="flex: 8">
                                        <a href="mailDetail?id=${send.id}&from=mail" style="color:inherit !important">
                                            ${send.subject}
                                        </a>
                                    </div>
                                        <div class="td" style="flex: 2">
                                            <fmt:formatDate value="${send.indate}" type="date" />
                                        </div>
                                        <div class="td" style="flex: 1">${send.replyCount!=0 ? '○' : '×'}</div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
