let eventSource = null;
window.addEventListener("DOMContentLoaded", function () {
    if (eventSource !== null) return;
    eventSource = new EventSource("/sse/subscribe");
    eventSource.onopen = () => console.log("SSE 연결 성공");

    eventSource.addEventListener("mail", (event) => {
        console.log("기본 메시지 이벤트 도착", event.data);
        try {
            const data = JSON.parse(event.data);
            showToast(data.mailId, data.mailSubject);
        } catch(e) {
            console.error("이벤트 데이터 파싱 실패", e);
        }
    });

    eventSource.onerror = function () {
        console.error("SSE 연결 끊김");
        eventSource.close();
        eventSource = null;
    };
});

window.addEventListener("beforeunload", () => {
    if (eventSource) {
        eventSource.close();
        eventSource = null;
    }
});

function showToast(mailId, mailSubject) {
    const toast = document.getElementById("toast");
    toast.innerHTML = `<a href="/mailDetail?id=${mailId}&from=mail" style="color:white;text-decoration:underline;">새 메일이 도착했습니다.<br />${mailSubject}</a>`;
    toast.className = "show";
    setTimeout(() => {
        toast.className = toast.className.replace("show", "");
    }, 10000);
}

