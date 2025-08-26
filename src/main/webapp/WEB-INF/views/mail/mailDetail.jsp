<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<div class="section">
    <%@include file="../lnb.jsp"%>
    <div class="container">
        <div class="main">
            <div class="mail_header">
                <div class="title">
                    <label>제목</label>
                    <div>${mail.subject}</div>
                </div>
                <div class="sender">
                    <label>보낸사람</label>
                    <div>${mail.senderName}</div>
                </div>
                <div class="receiver">
                    <label>받는사람</label>
                    <div>${mail.receiverName}</div>
                </div>
                <div class="date">
                    <label>작성일</label>
                    <div>${mail.indate}</div>
                </div>
            </div>
            <a class="mail_content">
                <c:if test="${mail.reply != 0}">
                    <a href="mailDetail?id=${mail.reply}&from=${from}" class="reply"
                       style="color: gray !important; font-size: 80%">
                        '${replyName}'의 답장
                    </a>
                </c:if>
                <div class="content">${mail.content}</div>
            </div>
            <div class="mail_reply">
                <c:choose>
                    <c:when test="${mail.replyCount != 0}">
                        <div style="color: gray; font-size: 80%">${mail.replyCount}개의 답장이 있습니다.</div>
                        <c:forEach items="${repliedList}" var="replied">
                            <div>&nbsp;&nbsp;
                                <a href="mailDetail?id=${replied.id}&from=${from}">
                                    ${replied.subject}
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="color: gray; font-size: 80%">답장이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="btn">
                <input type="button" value="답장하기" onClick="location.href='writeMailForm?reply=${mail.id}'">
                <input type="button" value="돌아가기" onClick="location.href='${from}'">
                <input type="button" value="삭제하기" onClick="location.href='deleteMail?id=${mail.id}'">
            </div>
        </div>
    </div>
</div>

</body>
</html>