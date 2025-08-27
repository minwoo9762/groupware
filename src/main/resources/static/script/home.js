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

    if(targetId === "btnAttend") {
        attendTime.time = currentTime;
        attendTime.indate = formattedDate + " " + formattedClock;
        attendTime.state = 2;
        document.getElementById("attendTime").innerText = attendTime.time;

        ajaxAttend(attendTime, target);
    } else  if(targetId === "btnleave") {
        leaveTime.time = currentTime;
        leaveTime.indate = formattedDate + " " + formattedClock;
        leaveTime.state = 2;
        document.getElementById("leaveTime").innerText = leaveTime.time;

        ajaxLeave(leaveTime, target);
    };
}

function ajaxAttend(attendTime, target) {
    let formData = {
        indate: attendTime.indate,
        state: attendTime.state
    }
    $.ajax({
        url: location.origin + "/addAttendance",
        type: "POST",
        contentType: 'application/json',
        data: JSON.stringify(formData),
        timeout: 10000,
        processData: false,
        success: function (data) {
            alert("출근 체크가 완료되었습니다.");
            target.classList.add("disable");
            target.closest(".btnWrap").querySelector("#btnleave").remove();
            let btn = `<button id="btnleave" class="btn btnleave" type="button" onclick="clickAttend(this);">퇴근</button>`;
            target.closest(".btnWrap").insertAdjacentHTML("beforeend", btn);

            console.log("출근시간 : " + attendTime.time);
            console.log("출근 indate : " + attendTime.indate);
            console.log("출근상태 : " + attendTime.state);
        },
        error: function () {
            alert('파일업로드실패');
        }
    });
}
function ajaxLeave(leaveTime, target) {

    let formData = {outdate: leaveTime.indate, state: leaveTime.state}
    $.ajax({
        url: location.origin + "/addAttendance",
        type: "POST",
        contentType: 'application/json',
        data:  JSON.stringify(formData),
        timeout: 10000,
        processData: false,
        success: function (data) {
            alert("퇴근 체크가 완료되었습니다.");
            target.classList.add("disable");

            console.log("퇴근시간 : " + leaveTime.time);
            console.log("퇴근 indate : " + leaveTime.indate);
            console.log("퇴근상태 : " + leaveTime.state);
        },
        error: function () {
            alert('파일업로드실패');
        }
    });
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

        // 🔹 날짜를 클릭했을 때 실행되는 함수

        dateClick: function(info) {
            if(adminState == 1) {
                location.href = 'appMain?first=y';
            } else {
                // 클릭한 날짜 정보는 info.date 또는 info.dateStr에 들어 있음
                if(confirm("전자결재 문서를 작성하시겠습니까?")) {
                    document.getElementById("popupApprovalWrite").classList.add("active");
                    document.getElementById("dim").classList.add("active");
                }
            }
        }
    });

    // 캘린더 화면에 렌더링
    calendar.render();
});

function popupClose() {
    document.getElementById("popupApprovalWrite").classList.remove("active");
    document.getElementById("dim").classList.remove("active");
}





