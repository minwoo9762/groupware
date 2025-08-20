<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<!-- ✅ layout 시작 -->
<div class="layout" style="display: flex;">

  <!-- ✅ 왼쪽 메뉴 -->
  <%@ include file="../lnb.jsp" %>

  <!-- ✅ 오른쪽 본문 -->
  <div class="calendar" style="flex: 2.5;">
    <h2>Calendar</h2>
    <div id="calendar"></div>
  </div>




  <div class="attendance5" style="flex: 1.5;">
    <h2>${userid}님의 근태 조회</h2>
    <div id="attendance5">
      <br />
      <label>지각 : ${lateCount}</label><br>
      <label>결석 : ${absentCount}</label><br>
      <label>조퇴 : ${earlyLeaveCount}</label><br>
      <label>휴가 : ${vacationCount}</label><br>
      <label>잔여 휴가 : ${remainingVacation}</label>
    </div>
  </div>

</div>
<!-- ✅ layout 끝 -->

<%@ include file="../footer.jsp" %>