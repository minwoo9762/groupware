let formattedDate;
let formattedClock;
function updateTime() {
    const now = new Date();
    formattedDate = now.getFullYear() + '-' +
        String(now.getMonth() + 1).padStart(2, '0') + '-' +
        String(now.getDate()).padStart(2, '0');

    formattedClock =
        String(now.getHours()).padStart(2, '0') + ':' +
        String(now.getMinutes()).padStart(2, '0') + ':' +
        String(now.getSeconds()).padStart(2, '0');

    document.getElementById("today").innerHTML = formattedDate + '<span id="clock" class="clock">' + formattedClock + '</span>';
};
document.addEventListener("DOMContentLoaded", function () {
    updateTime();
    setInterval(updateTime, 1000);
});


// 출근 퇴근 클릭시 값 저장
let attendTime = {};
let leaveTime = {};
function clickAttend(target) {
    let targetId = target.getAttribute("id");
    let currentTime = document.getElementById("clock").innerText;
    target.classList.add("disable");
    if(targetId === "btnAttend") {
        attendTime.time = currentTime;
        attendTime.indate = formattedDate + " " + formattedClock;
        attendTime.state = "active";
        let attendTimeActive = document.getElementById("attendTime").innerText = attendTime.time;
        console.log("출근시간 : " + attendTime.time);
        console.log("출근 indate : " + attendTime.indate);
        console.log("출근상태 : " + attendTime.state);

        ajaxAttend(attendTime);
    } else  if(targetId === "btnleave") {
        leaveTime.time = currentTime;
        leaveTime.indate = formattedDate + " " + formattedClock;
        leaveTime.state = "active";
        let leaveTimeActive = document.getElementById("leaveTime").innerText = leaveTime.time;

        console.log("퇴근시간 : " + leaveTime.time);
        console.log("퇴근 indate : " + leaveTime.indate);
        console.log("퇴근상태 : " + leaveTime.state);

        ajaxLeave(leaveTime);
    };
}
// ajax에서 obj.state 가 active 이면 버튼 미리 비활성화.
function ajaxAttend(attendTime) {
    let formData = {attendIndate: attendTime.indate, state: attendTime.state}
    $.ajax({
        url: location.origin + "/attendance",
        type: "POST",
        contentType: 'application/json',
        data: JSON.stringify(formData),
        timeout: 10000,
        processData: false,
        success: function (data) {
            alert("출근 체크가 완료되었습니다.");
        },
        error: function () {
            alert('파일업로드실패');
        }
    });
}
function ajaxLeave(leaveTime) {

    let formData = {leaveTimeIndate: leaveTime.indate, state: leaveTime.state}
    $.ajax({
        url: location.origin + "/attendance",
        type: "POST",
        contentType: 'application/json',
        data:  JSON.stringify(formData),
        timeout: 10000,
        processData: false,
        success: function (data) {
            alert("퇴근 체크가 완료되었습니다.");
        },
        error: function () {
            alert('파일업로드실패');
        }
    });
}



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





