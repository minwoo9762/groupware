<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="./header.jsp"%>

<!-- FullCalendar 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/index.global.min.js"></script>


<section class="section home">
    <%@include file="lnb.jsp" %>
    <div class="main">
        <div class="boardLeft">
            <div id="attend">
                <h3 class="cardTit">근태관리</h3>
                <span id="today" class="today">

             <span id="clock" class="clock">

            </span>
          </span>

                <div class="attWrap">
                    <c:choose>
                        <c:when test="${confirmAtd != null}">
                            <div class="startTime">
                                <span>출근시간</span>
                                <span id="attendTime"><fmt:formatDate value="${confirmAtd.indate}"
                                                                      pattern="HH:mm:ss"/></span>
                            </div>
                            <div class="endTime">
                                <span>퇴근시간</span>
                                <span id="leaveTime"><fmt:formatDate value="${confirmAtd.outdate}"
                                                                     pattern="HH:mm:ss"/></span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="startTime">
                                <span>출근시간</span>
                                <span id="attendTime">00:00:00</span>
                            </div>
                            <div class="endTime">
                                <span>퇴근시간</span>
                                <span id="leaveTime">00:00:00</span>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>
                <div class="btnWrap">
                    <c:choose>
                        <%--1. 오늘 출석 O, 오늘 퇴근 O--%>
                        <c:when test="${indateTrue == 0 && outdateTrue == 0}">
                            <button id="btnAttend" class="btn btnAttend disable" type="button">
                                출근
                            </button>
                            <button id="btnleave" class="btn btnleave disable" type="button">
                                퇴근
                            </button>
                        </c:when>
                        <%--2. 오늘 출석 O, 오늘 퇴근 X--%>
                        <c:when test="${indateTrue == 0 && outdateTrue == 1}">
                            <button id="btnAttend" class="btn btnAttend disable" type="button">
                                출근
                            </button>
                            <button id="btnleave" class="btn btnleave" type="button"
                                    onclick="clickAttend(this);">
                                퇴근
                            </button>
                        </c:when>
                        <%--3. 오늘 출석 X, 오늘 퇴근 X--%>
                        <c:when test="${indateTrue == 1 && outdateTrue == 0}">
                            <button id="btnAttend" class="btn btnAttend" type="button" onclick="clickAttend(this);">
                                출근
                            </button>
                            <button id="btnleave" class="btn btnleave disable" type="button">
                                퇴근
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button id="btnAttend" class="btn btnAttend" type="button" onclick="clickAttend(this);">
                                출근
                            </button>
                            <button id="btnleave" class="btn btnleave disable" type="button">
                                퇴근
                            </button>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>

            <div id="notice">
                <h3 class="cardTit">공지사항</h3>
                <table>
                    <thead>
                    <tr>
                        <th>제목</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${notice.size() == 0}">
                          <tr>
                            <td colspan="1" style="text-align:center; height: 80px; vertical-align: middle; font-size: 20px; font-weight: bold;">
                              공지사항을 등록해주세요.
                            </td>
                          </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${notice}" var="ndto">
                                <tr onclick="location.href='noticeDetail?nseq=' + ${ndto.nseq}"
                                    style="cursor: pointer;">
   <%--                                 <td>${ndto.nseq}</td>--%>
                                    <td class="content">${ndto.title}</td>
<%--                                    <td><fmt:formatDate value="${ndto.indate}" pattern="yyyy-MM-dd HH:mm"/></td>--%>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
            <div id="mypage">
                <div class="top">
                    <img src="/images/${loginUser.profileimg}" alt="프로필사진"/>
                    <div class="npm">
                    <span class="name">
                        ${loginUser.name}
                        ${info.providerName}

                    </span>
                    <span class="part">
                        ${user.partName}
                    </span>
                    <div class="util">
                        <div class="list armMail" style="cursor: pointer" onclick="location.href='/mail'">
                            <span class="num">${today_mail}</span>
                            <span class="txt">오늘 온 메일</span>
                        </div>
                        <div class="list armSchedule ">
                            <span class="num">2</span>
                            <span class="txt">오늘의 일정</span>
                        </div>
                    </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="boardCenter">
            <div id="calendar"></div>


        </div>

<%--        <div class="boardRight">

        </div>--%>

    </div>
</section>

<div id="dim" onclick="popupClose();"></div>
<div id="popupApprovalWrite">
    <%@include file="./popupApproval.jsp"%>
</div>

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

</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="/script/home.js"></script>

</body>
</html>


