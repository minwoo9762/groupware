<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>
    <article>
        <form method="get" name="frm">
            <div class="tb">
                <div class="find-box">
                    <div class="col search-box">
                        <input type="button" value="메일 작성" onclick="location.href='writeMailForm'">
                    </div>
                </div>
            </div>
            <div style="display: flex">
                <div class="tb">
                    <div class="mailbox"><a href="inbox">최근 받은메일함</a></div>
                    <div class="header-row">
                        <div class="coltitle" style="flex: 1.4">보낸사람</div>
                        <div class="coltitle" style="flex: 3">제목</div>
                        <div class="coltitle" style="flex: 1">작성일</div>
                        <div class="coltitle" style="flex: 1">답장</div>
                    </div>
                    <c:choose>
                        <c:when test="${empty receiveList}">
                            <div class="row" style="text-align: center"><br>메일이 없습니다.<br>&nbsp;</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${receiveList}" var="receive">
                                <div class="row" style="color:${receive.read ? 'gray' : 'black'}">
                                    <div class="col" style="flex: 1">${receive.senderName}</div>
                                    <div class="col" style="flex: 3">
                                        <a href="mailDetail?id=${receive.id}&from=mail" style="color:inherit !important">${receive.subject}</a>
                                    </div>
                                    <div class="col" style="flex: 1.5">
                                        <fmt:formatDate value="${receive.indate}" type="date" />
                                    </div>
                                    <div class="col" style="flex: 0.6">${receive.replyCount!=0 ? '○' : '×'}</div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="padding-left: 10px"></div>
                <div class="tb">
                    <div class="mailbox"><a href="sent">최근 보낸메일함</a></div>
                    <div class="header-row">
                        <div class="coltitle" style="flex: 1.4">받은사람</div>
                        <div class="coltitle" style="flex: 3">제목</div>
                        <div class="coltitle" style="flex: 1">작성일</div>
                        <div class="coltitle" style="flex: 1">답장</div>
                    </div>
                    <c:choose>
                        <c:when test="${empty sendList}">
                            <div class="row" style="text-align: center"><br>메일이 없습니다.<br>&nbsp;</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${sendList}" var="send">
                                <div class="row" style="color:${send.read ? 'gray' : 'black'}">
                                    <div class="col" style="flex: 1">${send.receiverName}</div>
                                    <div class="col" style="flex: 3">
                                        <a href="mailDetail?id=${send.id}&from=mail" style="color:inherit !important">${send.subject}</a>
                                    </div>
                                    <div class="col" style="flex: 1.5">
                                        <fmt:formatDate value="${send.indate}" type="date" />
                                    </div>
                                    <div class="col" style="flex: 0.6">${send.replyCount!=0 ? '○' : '×'}</div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            </form>
    </article>
</div>

</body>
</html>
