function deleteVacation(pseq){
    if(confirm("삭제하시겠습니까?")){
        location.href='deleteVacation?pseq=' + pseq;
    }
}

function go_search(url){
    document.fr.action = url;
    document.fr.submit();
}

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
    });

    // 캘린더 화면에 렌더링
    calendar.render();
});