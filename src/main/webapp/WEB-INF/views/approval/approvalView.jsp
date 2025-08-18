<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
  <%@include file="../lnb.jsp"%>
<div class="main">
    <h2 class="title" style="font-size:40px;">전자결제 상세보기</h2>
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
          <div class="th"  style="flex: 6"><%--${approval.title}--%></div>
        </div>

        <div class="tr">
          <div class="th" >카테고리</div>
          <div class="th" >전자결제</div>
          <div class="th" >진행상태</div>
          <div class="th" >${approval.status}</div>
        </div>

        <div class="tr" id="appContent">
          <div class="th" style="flex: 1" >내 용</div>
          <div class="th"  style="flex: 6" ><%--${approval.content}--%> </div>
        </div>

    <div class="field">
      <div class="label">이미지</div>
      <div class="text">
        <c:choose>
          <c:when test="${empty approval.savefilename}">
            <img src="/images/noname.jpg" width="250"/><br>
            이미지가 없습니다
          </c:when>
          <c:otherwise>
            <img src="${approval.savefilename}" width="350"/><br />
            ${approval.image}
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="login-button">
      <input type="button" value="결제승인" onClick="location.href='approvalCheck()'"/>
      <input type="button" value="삭제" onClick="deleteApp('${approval.id}')"/>
      <input type="button" value="목록으로" onClick="location.href='approvalMain'"/>
    </div>
  </div>
</div>
</div>


</section>

</body>
</html>
