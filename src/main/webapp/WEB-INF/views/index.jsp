<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- FullCalendar 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/index.global.min.js"></script>


<%@include file="header.jsp" %>
<section class="section home">
    <%@include file="lnb.jsp" %>
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
            <div id="calendar"></div>
        </div>

        <div class="boardCenter">
            <div id="notice">
                <h3 class="cardTit">공지사항</h3>
                <table>
                    <colgroup>
                        <col width="44px">
                        <col width="200px">
                        <col width="">
                        <col width="180px">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>제목</th>
                        <th>내용</th>
                        <th>작성날짜</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${notice.size() == 0}">
                            <div style="display:flex; align-items: center; justify-content: center; font-size: 32px; font-weight: 700;">
                                공지사항을 등록해주세요.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${notice}" var="ndto">
                                <tr onclick="location.href='noticeDetail?nseq=' + ${ndto.nseq}"
                                    style="cursor: pointer;">
                                    <td>${ndto.nseq}</td>
                                    <td class="content">${ndto.title}</td>
                                    <td class="content">${ndto.content}</td>
                                    <td><fmt:formatDate value="${ndto.indate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="boardRight">
            <div id="mypage">
                <div class="top">
                    <h3 class="cardTit">내 정보</h3>
                    <img src="/images/${loginUser.profileimg}" alt="프로필사진"/>
                    <span class="name">
                        ${loginUser.name}
                        ${loginUser.provider == 1 ? "사원" : loginUser.provider == 2 ? "주임" : loginUser.provider == 3 ? "대리" : loginUser.provider == 4 ? "과장" : loginUser.provider == 5 ? "부장" : loginUser.provider == 99 ? "대표(관리자)" : "미정"}
                    </span>
                    <span class="part">
                        ${loginUser.part == 1 ? "개발팀" : loginUser.part == 2 ? "기획팀" : loginUser.part == 3 ? "영업팀" : loginUser.part == 4 ? "운영팀" : loginUser.part == 5 ? "인사팀" : "미정"}
                    </span>
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


