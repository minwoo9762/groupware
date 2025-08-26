<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>

<div class="container">
    <h2 class="head">게시글 상세보기</h2>
    <div class="mainBox">

        <div class="titleBar">
          <div class="titleWriter">작성자</div>
          <div class="titleTitle">제 목</div>
        </div>

        <div class="bar">
          <div class="left" >${board.name} (<c:choose>
                        <c:when test="${board.part == 1}">개발팀</c:when>
                        <c:when test="${board.part == 2}">기획팀</c:when>
                        <c:when test="${board.part == 3}">영업팀</c:when>
                        <c:when test="${board.part == 4}">운영팀 </c:when>
                        <c:when test="${board.part == 5}">인사팀 </c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>)
          </div>
          <div class="right">${board.title}</div>
        </div>

        <div class="bodyBar">
              <div class="titleWriter" >카테고리</div>
              <div class="titleTitle" >내 용</div>
        </div>

        <div class="contentBar">
          <div class="contentLeft">
              <div class="second">게시판</div>
              <div class="first">상세보기</div>
              <div class="second">이미지</div>
      <div class="imgField">
        <c:choose>
          <c:when test="${empty board.savefilename}">
            <img src="/images/noname.jpg" /><br>
          </c:when>
          <c:otherwise>
            <img src="/images/${board.savefilename}" />
          </c:otherwise>
        </c:choose>
      </div>
          </div>
          <div class="contentBox">${board.content} </div>
        </div>

    <div class="updateBtns">
      <input type="button" value="수정" onClick="location.href='updateBoardForm?id=${board.id}'"/>
      <input type="button" value="삭제" onClick="deleteBoard('${board.id}')" />
      <input type="button" value="목록으로" onClick="location.href='workBoard'" />
    </div>

    <div class="reply">
    <div class="reply_title">
      <div class="reply_Writer">작성자</div>
      <div class="reply_Date">작성일시</div>
      <div class="reply_Content" >댓글</div>
      <div class="reply_AD">작성/삭제</div>
    </div>

    <form action="addBoardReply" method="post" name="addBoardRep">
      <input type="hidden" name="boardid" value="${board.id}" />
      <input type="hidden" name="userid" value="${loginUser.id}" />
      <input type="hidden" name="name" value="${loginUser.name}" />
      <div class="reply_body">
        <div class="reply_Writer">${loginUser.name}</div>
        <div class="reply_Date">
          <c:set var="now" value="<%=new java.util.Date()%>"/>
          <fmt:formatDate value="${now}" pattern="MM/dd hh:mm"/>
        </div>
        <div class="reply_Content"><input type="text" name="reply" size="80"></div>
        <div class="reply_AD">
          <input type="submit" value="작성" onclick="return replyBoardCheck();" />
        </div>
      </div>
    </form>
    <c:choose>
      <c:when test="${replyList.size()==0}">
        <div class="reply_msg">댓글이 없습니다.</div>
      </c:when>
      <c:otherwise>
        <c:forEach items="${replyList}" var="reply">
          <div class="reply_body">
            <div class="reply_Writer">${reply.name}</div>
            <div class="reply_Date"><fmt:formatDate value="${reply.writedate}" pattern="MM/dd hh:mm"/></div>
            <div class="reply_Content">${reply.reply}</div>
            <div class="reply_AD">
                <c:if test="${reply.userid==loginUser.id}">
                  <input type="button" value="삭제" onClick="deleteBoardReply('${reply.id}','${board.id}')" />
                </c:if>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
</div>
</div>
</div>


</div>

<%@ include file="../footer.jsp" %>