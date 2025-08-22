<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/payDetail.css">

<!-- ✅ layout 시작 -->
<div class="layout" style="display: flex;" id="main">

  <!-- ✅ 왼쪽 메뉴 -->
  <%@ include file="../lnb.jsp" %>

  <article>
      <form>
        <h2>${payDetail.title}</h2>
        <div class="field">
          <div>${payDetail.content}</div>
        </div>
        <div class="btn">
          <input type="button" value="목록으로" onclick="location.href='paycheck'">
        </div>
      </form>
    </article>
</div>


<%@ include file="../footer.jsp" %>