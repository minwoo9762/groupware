<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>
    <form method="post" name="writeMailForm" action="writeMail" class="container">
        <h2 class="head">메일 작성</h2>
        <div class="mainbox" style="width: 100%">
            <div class="mail_header">
                <div style="display:flex; gap:15px">
                    <div class="titleBar" style="flex:1; justify-content: center;">제목</div>
                    <div class="bar" style="flex:4">
                        <input type="text" style="border: none; font-size: 14px" placeholder="제목을 입력하세요"
                               name="subject" value="${dto.subject}">
                    </div>
                </div>
                <div style="display:flex; gap:15px">
                    <div class="titleBar" style="flex:1; justify-content: center;">보내는 사람</div>
                    <div class="bar" style="flex:4">
                        ${loginUser.name}
                    </div>
                    <input type="hidden" name="senderId" value="${loginUser.id}">
                </div>
                <div style="display:flex; gap:15px">
                    <div class="titleBar" style="flex:1; justify-content: center;">받는 사람</div>
                    <div class="bar" style="flex:4">
                        <c:choose>
                            <c:when test="${replyCheck != 0}">
                                <input type="text" style="border: none; font-size: 14px"
                                name="receiverName" value="${replyUserName}" readonly>
                            </c:when>
                            <c:otherwise>
                                    <input type="text" style="border: none; font-size: 14px" placeholder="이름을 입력하세요"
                                    name="receiverName" value="${dto.receiverName}">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="contentBar">
                    <div class="contentBox" style="min-height: 200px">
                        <c:if test="${replyCheck != 0}">
                            <div style="color: gray !important; font-size: 80%; margin-bottom: 10px">'${replyName}'의 답장</div>
                            <input type="hidden" name="replyCheck" value="${replyCheck}">
                            <input type="hidden" name="replyName" value="${replyName}">
                        </c:if>
                        <textarea rows="8" name="content" placeholder="내용을 입력하세요">${dto.content}</textarea>
                    </div>
                </div>
                <div style="color: red; font-weight: bold;">${message}</div>
                <div class="btn">
                    <input type="submit" value="메일 전송">
                    <input type="button" value="뒤로가기" onclick="history.go(-1)">
                </div>
            </div>
        </div>
    </form>
</div>

</body>
</html>
