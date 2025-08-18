<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- FullCalendar 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/index.global.min.js"></script>



<%@include file="header.jsp"%>
<section class="section home">
  <%@include file="lnb.jsp"%>
  <div class="main">
    <h2 class="title">HOME</h2>
    <div class="boardLeft">
      <div id="attend">
        <h3 class="cardTit">근태관리</h3>
        <span id="today" class="today">

           <span id="clock" class="clock">

          </span>
        </span>

        <div class="attWrap">
          <div class="startTime">
            <span>출근시간</span>
            <span>9:30</span>
          </div>
          <div class="endTime">
            <span>퇴근시간</span>
            <span>6:30</span>
          </div>
        </div>
        <div class="btnWrap">
          <button class="btn btnAttend" type="button">
            출근
          </button>
          <button class="btn btnleave" type="button">
            퇴근
          </button>
        </div>
      </div>
      <div id="calendar"></div>
    </div>

    <div class="boardCenter">
      <div id="notice">
        <h3 class="cardTit">공지사항</h3>
        <table>
          <colgroup>
            <col width="44px">
            <col width="">
            <col width="120px">
            <col width="140px">
          </colgroup>
          <thead>
          <tr>
            <th>No.</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성날짜</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>5</td>
            <td class="content">안녕하세요 이번주 회식합니다.</td>
            <td>강희준 대표</td>
            <td>2025.08.13</td>
          </tr>
          <tr>
            <td>4</td>
            <td class="content">안녕하세요 이번주랑 다음주 회식합니다.</td>
            <td>강희준 대표</td>
            <td>2025.08.13</td>
          </tr>
          <tr>
            <td>3</td>
            <td class="content">안녕하세요 이번주 회식합니다.</td>
            <td>강희준 대표</td>
            <td>2025.08.13</td>
          </tr>
          <tr>
            <td>2</td>
            <td class="content">안녕하세요 이번주 회식합니다.</td>
            <td>강희준 대표</td>
            <td>2025.08.13</td>
          </tr>
          <tr>
            <td>1</td>
            <td class="content">안녕하세요 이번주 회식합니다.</td>
            <td>강희준 대표</td>
            <td>2025.08.13</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="boardRight">
      <div id="mypage">
        <div class="top">
          <h3 class="cardTit">내 정보</h3>
          <img src="data:image/jpeg;base64,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" alt="프로필사진" />
          <span class="name">강희준 대리</span>
          <span class="part">개발팀</span>
          <div class="util">
            <div class="list armMail">
              <span class="num">8</span>
              <span class="txt">오늘 온 메일</span>
            </div>
            <div class="list armSchedule ">
              <span class="num">2</span>
              <span class="txt">오늘의 일정</span>
            </div>
          </div>
        </div>
        <span class="line"></span>
        <div class="bottom">

        </div>
      </div>
    </div>

  </div>
</section>



<script>
  // 🔹 달력에 표시될 이벤트 데이터 정의 (서버에서 가져온 것이라 가정)
  const eventData = [
    {
      title: "생일 🎉",
      start: "2025-08-18",
      allDay: true
    },
    {
      title: "병가 🎉",
      start: "2025-08-18",
      end: "2025-08-19",
      textColor: "#1e90ff",
      backgroundColor: "yellow",
      allDay: true
    },
    {
      title: "휴가 🏖️",         // 이벤트 제목
      start: "2025-08-01",       // 시작 날짜
      end: "2025-08-04",         // 종료 날짜 (3일까지 포함되게 하려면 4일로 지정)
      allDay: true               // 하루 종일 일정 표시
    }
  ];

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

<script>
  function updateTime() {
    const now = new Date();
    const formattedDate = now.getFullYear() + '-' +
            String(now.getMonth() + 1).padStart(2, '0') + '-' +
            String(now.getDate()).padStart(2, '0');

    const formattedClock =
            String(now.getHours()).padStart(2, '0') + ':' +
            String(now.getMinutes()).padStart(2, '0') + ':' +
            String(now.getSeconds()).padStart(2, '0');

    document.getElementById("today").innerHTML = formattedDate + '<span id="clock" class="clock">' + formattedClock + '</span>';
  };

  document.addEventListener("DOMContentLoaded", function () {
    updateTime();
    setInterval(updateTime, 1000);
  });

</script>
</body>
</html>


