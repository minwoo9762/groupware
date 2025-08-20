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
          <div class="left" >${app.username}</div>
          <div class="right">${app.title}</div>
        </div>

        <div class="bodyBar">
          <div class="titleWriter" >카테고리</div>
          <div class="titleTitle" >전자결제</div>
        </div>

        <div class="contentBar">
          <div class="contentLeft">
            <div class="first">${categoryName}</div>
            <div class="second">상 태</div>
            <div class="imgField">${statusName}</div>
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
