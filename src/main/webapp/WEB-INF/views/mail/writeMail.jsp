<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>

    <form method="post" name="writeMailForm" action="writeMail">
        <div class="mail_header">
            <div class="mail_sender">
                <label>보내는 사람</label>
                <div>${loginUser.name}</div>
                <input type="hidden" name="senderId" value="${loginUser.id}">
            </div>
            <div class="mail_receiver">
                <label>받는 사람</label>
                <c:choose>
                    <c:when test="${replyCheck != 0}">
                        <input type="text" name="receiverName" value="${replyUserName}" readonly>
                    </c:when>
                    <c:otherwise>
                        <input type="text" name="receiverName" value="${dto.receiverName}">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mail_subject">
                <label>제목</label>
                <input type="text" name="subject" value="${dto.subject}">
            </div>
        </div>
        <div class="mail_content">
            <label>내용</label>
            <c:if test="${replyCheck != 0}">
                <div style="color: gray; font-size: 80%">'${replyName}'의 답장</div>
                <input type="hidden" name="replyCheck" value="${replyCheck}">
                <input type="hidden" name="replyName" value="${replyName}">
            </c:if>
            <textarea rows="8" name="content" placeholder="내용을 입력하세요">${dto.content}</textarea>
        </div>
        <div class="btn">
            <input type="submit" value="메일 전송">
            <input type="button" value="뒤로가기" onclick="history.go(-1)">
        </div>
        <div>${message}</div>
    </form>
</section>>

</body>
</html>
