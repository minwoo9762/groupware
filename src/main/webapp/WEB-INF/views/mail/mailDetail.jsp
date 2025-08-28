<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>
    <div class="container">
        <h2 class="head">메일 상세보기</h2>
        <div class="mainbox" style="width: 100%">
            <div class="mail_header">
                <div style="display:flex; gap:15px">
                    <div class="titleBar" style="flex:1; justify-content: center;">제목</div>
                    <div class="bar" style="flex:4">${mail.subject}</div>
                </div>
                <div style="display:flex; gap:15px">
                    <div class="titleBar" style="flex:1; justify-content: center;">보낸사람</div>
                    <div class="bar" style="flex:4">${mail.senderName}</div>
                </div>
                <div style="display:flex; gap:15px">
                    <div class="titleBar" style="flex:1; justify-content: center;">받는사람</div>
                    <div class="bar" style="flex:4">${mail.receiverName}</div>
                </div>
                <div style="display:flex; gap:15px">
                    <div class="titleBar" style="flex:1; justify-content: center;">작성일</div>
                    <div class="bar" style="flex:4"><fmt:formatDate value="${mail.indate}" type="date" /></div>
                </div>
            </div>
            <div class="contentBar">
                <div class="contentBox" style="min-height: 200px">
                    <c:if test="${mail.reply != 0}">
                    <div>
                        <a href="mailDetail?id=${mail.reply}&from=${from}" class="reply"
                            style="color: gray !important; font-size: 80%">
                            '${replyName}'의 답장
                        </a>
                    </div>
                    </c:if>
                    ${mail.content}
                </div>
            </div>
            <div class="reply" style="margin-bottom: 15px">
                <c:choose>
                    <c:when test="${mail.replyCount != 0}">
                        <div style="color: gray;  font-size: 80%">${mail.replyCount}개의 답장이 있습니다.</div>
                        <div class="repliedList" style="display: flex">
                            <c:forEach items="${repliedList}" var="replied">
                                <div>&nbsp;&nbsp;
                                    <a href="mailDetail?id=${replied.id}&from=${from}"
                                    style="background: lightgray;">
                                        <u>${replied.subject}</u>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="color: gray; font-size: 80%">답장이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="btn">
                <c:if test="${mail.receiverName == loginUser.name}">
                    <input type="button" value="답장하기" onClick="location.href='writeMailForm?reply=${mail.id}'">
                </c:if>
                <input type="button" value="돌아가기" onClick="location.href='${from}'">
                <input type="button" value="삭제하기" onClick="location.href='deleteMail?id=${mail.id}'">
            </div>
        </div>
    </div>
</div>

</body>
</html>