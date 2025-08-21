<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    const appId = ${app.id};  // JSP EL 결과가 숫자라면 숫자 그대로 할당됨

    function approvalCheck() {
        // appId는 이미 숫자 타입이므로 parseInt 불필요
        const form = document.createElement('form');
        form.method = 'post';
        form.action = 'updateStatus';

        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = appId;

        const statusInput = document.createElement('input');
        statusInput.type = 'hidden';
        statusInput.name = 'status';
        statusInput.value = 2;

        form.appendChild(idInput);
        form.appendChild(statusInput);
        document.body.appendChild(form);
        form.submit();
    }
</script>

<%@include file="../header.jsp"%>
<section class="section admin">
  <%@include file="../lnb.jsp"%>

<div class="container">
    <h2 class="head">전자결제 상세보기</h2>
    <div class="mainBox">

        <div class="titleBar">
          <div class="titleWriter">작성자</div>
          <div class="titleTitle">제 목</div>
        </div>

        <div class="bar">
          <div class="left" >${app.username}(<c:choose>
                        <c:when test="${app.part == 1}">개발팀</c:when>
                        <c:when test="${app.part == 2}">기획팀</c:when>
                        <c:when test="${app.part == 3}">영업팀</c:when>
                        <c:when test="${app.part == 4}">운영팀 </c:when>
                        <c:when test="${app.part == 5}">인사팀 </c:when>
                        <c:otherwise>알 수 없음</c:otherwise> </c:choose>)
          </div>
          <div class="right">${app.title}</div>
        </div>

        <div class="bodyBar">
          <div class="titleWriter" >카테고리</div>
          <div class="titleTitle" >결재내용</div>
        </div>

        <div class="contentBar">
          <div class="contentLeft">
            <div class="first">
                <c:choose>
                        <c:when test="${app.category == 0}">휴가</c:when>
                        <c:when test="${app.category == 1}">영수증</c:when>
                        <c:when test="${app.category == 2}">법인차량</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
            </div>
            <div class="second">상 태</div>
            <div class="first">
                <c:choose>
                        <c:when test="${app.status == 0}">결재대기</c:when>
                        <c:when test="${app.status == 1}">결재중</c:when>
                        <c:when test="${app.status == 2}">결재완료</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
            </div>
          </div>

          <div class="contentBox">${app.content}</div>
        </div>

    <div class="updateBtns">
      <input type="button" value="결제확인" onClick="approvalCheck()"/>
      <input type="button" value="삭제" onClick="deleteApp('${app.id}')"/>
      <input type="button" value="목록으로" onClick="location.href='appMain'"/>
    </div>

        <div class="reply">
    <div class="reply_title">
      <div class="reply_titleWriter">작성자</div>
      <div class="reply_titleDate">작성일시</div>
      <div class="reply_titleContent" >댓글</div>
      <div class="reply_titleAD">작성/삭제</div>
    </div>

    <form action="addAppReply" method="post" name="addAppRep">
      <input type="hidden" name="appid" value="${app.id}" />
      <input type="hidden" name="userid" value="${loginUser.id}" />
      <input type="hidden" name="provider" value="${loginUser.provider}" />
      <div class="reply_body">
        <div class="reply_bodyWriter">
        <c:choose>
        <c:when test="${loginUser.provider==2}">부장</c:when>
        <c:when test="${loginUser.provider==3}">팀장</c:when>
        <c:when test="${loginUser.provider==4}">본부장</c:when>
        <c:otherwise>알 수 없음</c:otherwise>
        </c:choose>
        </div>
        <div class="reply_bodyDate">
          <c:set var="now" value="<%=new java.util.Date()%>"/>
          <fmt:formatDate value="${now}" pattern="MM/dd hh:mm"/>
        </div>
        <div class="reply_bodyContent"><input type="text" name="reply" size="80"></div>
        <div class="reply_btn">
          <input type="submit" value="작성" onclick="return replyAppCheck();" />
        </div>
      </div>
    </form>
    <c:choose>
      <c:when test="${replyList.size()==0}">
        <div class="">의견이 없습니다.</div>
      </c:when>
      <c:otherwise>
        <c:forEach items="${replyList}" var="reply">
          <div class="reply_body">
            <div class="reply_bodyWriter">
        <c:choose>
        <c:when test="${reply.provider==2}">부장</c:when>
        <c:when test="${reply.provider==3}">팀장</c:when>
        <c:when test="${reply.provider==4}">본부장</c:when>
        <c:otherwise>알 수 없음</c:otherwise>
        </c:choose>
            </div>
            <div class="reply_bodyDate"><fmt:formatDate value="${reply.writedate}" pattern="MM/dd hh:mm"/></div>
            <div class="reply_bodyContent">${reply.reply}</div>
            <div class="reply_btn">
                <c:if test="${reply.userid==loginUser.id}">
                  <input type="button" value="삭제" onClick="deleteAppReply('${reply.id}','${app.id}')" />
                </c:if>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
</div>
</div>
</div>


</section>

</body>
</html>
