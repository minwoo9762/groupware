<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/attendance.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/index.global.min.js"></script>

<!-- ✅ layout 시작 -->
<div class="layout" style="display: flex;">

  <!-- ✅ 왼쪽 메뉴 -->
  <%@ include file="../lnb.jsp" %>

  <!-- ✅ 오른쪽 본문 -->
  <div class="calendar2" >
    <h2>Calendar</h2>
    <div id="calendar"></div>

  </div>



<%--<style>--%>
<%--  .main #calendar { flex-shrink: 0; padding: 20px; width: 100%; height:calc(100% - 230px); border: 1px solid #e5e5e5; box-sizing: border-box; border-radius: 18px; }--%>
<%--</style>--%>

  <div class="attendance5" >
    <h2>${loginUser.name}님의 근태 조회</h2>
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

<script>
  // vacationList를 자바스크립트 객체 배열로 변환
  let vacationList = [
    <c:forEach items="${vacation}" var="vacation" varStatus="status">
    {
      "title": "<%--${vacation.title}--%>연차",
      "start": "${vacation.indate}",
      "end": "${vacation.outdate}",
      "textColor": "#1e90ff",
      "backgroundColor": "yellow",
      "allDay": true
    }
    <c:if test="${!status.last}">, </c:if>
    </c:forEach>
  ];

  // 🔹 달력에 표시될 이벤트 데이터 정의 (서버에서 가져온 것이라 가정)
  const eventData = vacationList;

  // 🔹 DOM이 모두 로드되면 캘린더를 생성
  document.addEventListener('DOMContentLoaded', function () {
    // 캘린더가 표시될 HTML 요소를 가져옴
    var calendarEl = document.getElementById('calendar');

    // 오늘 날짜를 가져와 초기 표시 달로 설정
    var today = new Date(); // 현재 날짜 객체

    // FullCalendar 인스턴스 생성
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',  // 월간 보기 (그리드 형식)
      initialDate: today,           // 캘린더가 열릴 때 표시할 기본 날짜 (오늘 날짜 기준)
      events: eventData,            // 위에서 정의한 이벤트 배열

      // 🔹 날짜를 클릭했을 때 실행되는 함수
      dateClick: function(info) {
        // 클릭한 날짜 정보는 info.date 또는 info.dateStr에 들어 있음
        alert("선택한 날짜는: " + info.dateStr);
      }
    });

    // 캘린더 화면에 렌더링
    calendar.render();
  });


</script>



<%@ include file="../footer.jsp" %>