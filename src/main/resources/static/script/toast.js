// header에 상주하는 SSE 연결 및 알림 이벤트 수신 스크립트
let eventSource = null;
function connectSSE() {
    eventSource = new EventSource("/sse/subscribe"); // 페이지가 바뀔 때마다 연결 시도
    eventSource.onopen = () => console.log("SSE 연결 성공");

    // 메일 수신 알림 이벤트 (온라인 상태일 때만 전송됨)
    eventSource.addEventListener("mail", (event) => {
        console.log("메시지 수신 이벤트 도착", event.data);
        try {
            const data = JSON.parse(event.data);
            showMailToast(data.mailId, data.mailSubject);
        } catch (e) {
            console.error("이벤트 데이터 파싱 실패", e);
        }
        eventSource.onerror = (err) => {
            console.error("SSE 연결 끊김", err); // 연결이 끊길 경우 자동으로 3초마다 재연결 시도
        };
    });

    // 오프라인 수신 메일 알림 이벤트 (첫 로그인 후에만 전송됨)
    let InitialLogin = false; // 첫 로그인 검사 변수
    eventSource.addEventListener('unnotified-mail', function(event) {
        if (!InitialLogin) { // 처음 로그인한 상황일 경우
            console.log("미수신 메시지 이벤트 도착", event.data);
            const count = parseInt(event.data, 10);
            if (count > 0) {
                showUnnotifiedToast(count);
            }
            InitialLogin = true; // 이후 페이지에서는 나오지 않도록 변수값 변경
        }
    });


}

window.addEventListener("DOMContentLoaded", connectSSE);

window.addEventListener("beforeunload", () => {
    if (eventSource) {
        eventSource.close();
        eventSource = null;
    }
});

function showMailToast(mailId, mailSubject) {
    const toast = document.getElementById("toast");
    toast.innerHTML = `<a href="/mailDetail?id=${mailId}&from=mail" style="color:white;text-decoration:underline;">새 메일이 도착했습니다.<br />${mailSubject}</a>`;
    toast.className = "show";
    setTimeout(() => {
        toast.className = toast.className.replace("show", "");
    }, 10000);
}

function showUnnotifiedToast(count) {
    const toast = document.getElementById("toast");
    toast.innerHTML = `<a href="/inbox" style="color:white;text-decoration:underline;">확인하지 않은 ${count}개의 메일이 수신되었습니다.</a>`;
    toast.className = "show";
    setTimeout(() => {
        toast.className = toast.className.replace("show", "");
    }, 10000);
}
