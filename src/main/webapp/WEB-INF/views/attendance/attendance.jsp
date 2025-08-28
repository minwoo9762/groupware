<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/attendance.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/index.global.min.js"></script>

<!-- 전체 레이아웃 -->
<div class="main">
    <div class="container1">

        <!-- 왼쪽 사이드 메뉴 -->
        <%@ include file="../lnb.jsp" %>

        <!-- 본문 -->
        <div class="layout">

            <!-- 캘린더 영역 -->
            <div class="calendar2">
                <div id="calendar"></div>
            </div>

            <!-- 출결 통계 -->
            <div class="attendance5">
                <h2>${loginUser.name}님의 근태 조회</h2>
                <div id="attendance5">
                    <label>지각 : ${lateCount}</label><br>
                    <label>결석 : ${absentCount}</label><br>
                    <label>조퇴 : ${earlyLeaveCount}</label><br>
                    <label>휴가 : ${vacationCount}</label><br>
                    <label>잔여 휴가 : ${remainingVacation}</label>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // vacationList를 자바스크립트 객체 배열로 변환
    let vacationList = [
        <c:forEach items="${vacation}" var="v" varStatus="status">
        {
            title: "연차",
            start: "${v.startdate}",
            end: "${v.enddate}T23:59:59",
            textColor: "#1e90ff",
            backgroundColor: "yellow",
            allDay: false
        }
        <c:if test="${!status.last}">, </c:if>
        </c:forEach>
    ];

</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="/script/Hr.js"></script>



<%@ include file="../footer.jsp" %>