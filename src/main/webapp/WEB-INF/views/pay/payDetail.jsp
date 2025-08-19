<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<!-- ✅ layout 시작 -->
<div class="layout" style="display: flex;">

  <!-- ✅ 왼쪽 메뉴 -->
  <%@ include file="../lnb.jsp" %>

  <article>
    <form>
      <h2>${PayDto.title}</h2>
      <div class="field">
        <div>${PayDto.content}</div>
      </div>
      <div class="btn">
        <input type="button" value="이전" onclick="location.href='paycheck'">
      </div>
    </form>
  </article>
</div>


<%@ include file="../footer.jsp" %>