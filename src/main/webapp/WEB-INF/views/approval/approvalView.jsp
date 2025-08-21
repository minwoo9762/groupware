<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

    <div class="login-updateBtns">
      <input type="button" value="결제확인" onClick="location.href='approvalCheck()'"/>
      <input type="button" value="삭제" onClick="deleteApp('${approval.id}')"/>
      <input type="button" value="목록으로" onClick="location.href='approvalMain'"/>
    </div>
</div>
</div>


</section>

</body>
</html>
