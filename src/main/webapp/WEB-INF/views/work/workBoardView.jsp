
<%@include file="../header.jsp"%>
<section class="section admin">
<%@include file="../lnb.jsp"%>

  <div class="main">
    <h2 class="title" style="font-size:40px;">게시글 상세보기</h2>
    <div class="tableWrap">
      <div class="table">

        <div class="thead">
          <div class="tr">
            <div class="th" style="flex: 1">작성자</div>
            <div class="th"  style="flex: 6">제 목</div>
          </div>
        </div>

        <div class="tr">
          <div class="th" style="flex: 1">작성자<%--${loginUser.name}--%></div>
          <div class="th"  style="flex: 6"><%--${board.title}--%></div>
        </div>

        <div class="tr">
          <div class="th" >카테고리</div>
          <div class="th" >게시판</div>
        </div>

        <div class="tr" id="textarea">
          <div class="th" style="flex: 1" >내 용</div>
          <div class="th"  style="flex: 6" ><%--${board.content}--%> </div>
        </div>

    <div class="field">
      <div class="label">이미지</div>
      <div class="text">
        <c:choose>
          <c:when test="${empty board.savefilename}">
            <img src="/images/noname.jpg" width="250"/><br>
            이미지가 없습니다
          </c:when>
          <c:otherwise>
            <img src="${board.savefilename}" width="350"/><br />
            ${board.image}
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="login-button">
      <input type="button" value="수정" onClick="location.href='workBoardWrite?id=${board.id}'"/>
      <input type="button" value="삭제" onClick="deleteBoard('${board.id}')"/>
      <input type="button" value="패스워드 수정" onClick="updateBoardPass('${board.id}')"/>
      <input type="button" value="목록으로" onClick="location.href='workBoard'"/>
    </div>
  </div>

  <div class="reply">
    <div class="reply_row">
      <div class="reply_col reply_title">작성자</div>
      <div class="reply_col reply_title">작성일시</div>
      <div class="reply_col reply_title" >댓글</div>
      <div class="reply_col reply_title">작성/삭제</div>
    </div>

    <form action="addReply" method="post" name="addRep">
      <input type="hidden" name="boardid" value="${board.id}" />
      <input type="hidden" name="userid" value="${loginUser.userid}" />
      <div class="reply_row">
        <div class="reply_col">${loginUser.userid}</div>
        <div class="reply_col">
          <c:set var="now" value="<%=new java.util.Date()%>"/>
          <fmt:formatDate value="${now}" pattern="MM/dd hh:mm"/>
        </div>
        <div class="reply_col"><input type="text" name="content" size="60"></div>
        <div class="reply_col">
          <input type="submit" value="댓글작성" onclick="return replyCheck();">
        </div>
      </div>
    </form>
    <c:choose>
      <c:when test="${replyList.size()==0}">
        <div class="reply_col">댓글이 하나도 없습니다.</div>
      </c:when>
      <c:otherwise>
        <c:forEach items="${replyList}" var="reply">
          <div class="reply_row">
            <div class="reply_col">${reply.userid}</div>
            <div class="reply_col"><fmt:formatDate value="${reply.writedate}" pattern="MM/dd hh:mm"/></div>
            <div class="reply_col">${reply.reply}</div>
            <div class="reply_col">
                <c:if test="${reply.userid==loginUser.userid}">
                  <input type="button" value="삭제" onClick="deleteReply('${reply.id}','${board.id}')" />
                </c:if>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
</div>




</section>
</body>
</html>