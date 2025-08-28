<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp" %>
<script type="text/javascript">
    const appId = ${app.id};  // JSP EL 결과가 숫자라면 숫자 그대로 할당됨

    function approvalCheck() {
        // appId는 이미 숫자 타입이므로 parseInt 불필요
        const form = document.createElement('form');
        form.method = 'post';
        form.action = 'updateStatus';

        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = appId;

        const statusInput = document.createElement('input');
        statusInput.type = 'hidden';
        statusInput.name = 'status';
        statusInput.value = 2;

        form.appendChild(idInput);
        form.appendChild(statusInput);
        document.body.appendChild(form);
        form.submit();
    }
</script>

<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp" %>

    <div class="container">
        <h2 class="head">전자결제 상세보기</h2>
        <div class="mainBox">

            <div class="titleBar">
                <div class="titleWriter">작성자</div>
                <div class="titleTitle">제 목</div>
            </div>


        <div class="bar">
          <div class="left" >${app.username}
              <c:forEach items="${partList}" var="part">
                        <c:if test="${app.part == part.id}">
                            (${part.name})
                        </c:if>
                    </c:forEach>
          </div>
          <div class="right">${app.title}</div>
        </div>


            <div class="bodyBar">
                <div class="titleWriter">카테고리</div>
                <div class="titleTitle">결재내용</div>
            </div>

            <div class="contentBar" style="height: 180px;">
                <div class="contentLeft">
                    <div class="second">결재분류</div>
                    <div class="first">
                        <c:choose>
                            <c:when test="${app.category == 0}">휴가</c:when>
                            <c:when test="${app.category == 1}">영수증</c:when>
                            <c:when test="${app.category == 2}">법인차량</c:when>
                            <c:otherwise>알 수 없음</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="second">상 태</div>
                    <div class="first">
                        <c:choose>
                            <c:when test="${app.status == 0}">결재대기</c:when>
                            <c:when test="${app.status == 1}">결재중</c:when>
                            <c:when test="${app.status == 2}">결재완료</c:when>
                            <c:otherwise>알 수 없음</c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="contentBox">${app.content}</div>
            </div>


            <c:choose>
                <c:when test="${app.category == 0 && loginUser.provider == 1}">
                <div class="bodyBar">
                    <div class="titleWriter">연차 기간</div>
                    <div class="titleTitle">
                        <label style="font-size: 16px;">발생일 : </label><input id="startDay" name="startday" style="border: 1px solid #ddd;width: 120px;height: 28px;padding: 0 10px;box-sizing: border-box;" type="date" onchange="calDay()" value="${app.startdate}"/>
                        &nbsp;&nbsp;
                        <label style="font-size: 16px;">만료일 : </label><input id="endDay" name="endday" style="border: 1px solid #ddd;width: 120px;height: 28px;padding: 0 10px;box-sizing: border-box;" type="date" onchange="calDay()" value="${app.enddate}"/>
                        &nbsp;&nbsp;
                        <button type="button" class="btn" onclick="ajaxViewDate();">저장</button>
                    </div>
                </div>
                </c:when>
                <c:when test="${app.category == 0}">
                    <div class="bodyBar">
                    <div class="titleWriter">연차 기간</div>
                    <div class="titleTitle">
                        <label style="font-size: 16px;">발생일 : </label><span id="startDay" name="startday" style="display: inline-block; border: 1px solid #ddd;width: 120px;height: 28px; line-height:28px;padding: 0 10px;box-sizing: border-box; font-size: 16px;">${app.startdate}</span>
                        &nbsp;&nbsp;
                        <label style="font-size: 16px;">만료일 : </label><span id="endDay" name="endday" style="display: inline-block;; border: 1px solid #ddd;width: 120px;height: 28px; line-height:28px;padding: 0 10px;box-sizing: border-box; font-size: 16px;" >${app.enddate}</span>
                    </div>
                </div>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <div class="updateBtns">
                <c:if test="${loginUser.provider == 1}">
                    <input type="button" value="결제확인" onClick="approvalCheck()"/>
                </c:if>
                <input type="button" value="삭제" onClick="deleteApp('${app.id}')"/>
                <input type="button" value="목록으로" onClick="location.href='appMain'"/>
            </div>

            <div class="reply">
                <div class="reply_title">
                    <div class="reply_Writer">작성자</div>
                    <div class="reply_Date">작성일시</div>
                    <div class="reply_Content">의견</div>
                    <div class="reply_AD">작성/삭제</div>
                </div>

                <form action="addAppReply" method="post" name="addAppRep">
                    <input type="hidden" name="appid" value="${app.id}"/>
                    <input type="hidden" name="userid" value="${loginUser.id}"/>
                    <input type="hidden" name="provider" value="${loginUser.provider}"/>
                    <div class="reply_body">
                        <div class="reply_Writer">
                            <c:forEach items="${providerList}" var="provider">
                                <c:if test="${loginUser.provider == provider.id}">${provider.name}</c:if>
                            </c:forEach>
                        </div>
                        <div class="reply_Date">
                            <c:set var="now" value="<%=new java.util.Date()%>"/>
                            <fmt:formatDate value="${now}" pattern="MM/dd hh:mm"/>
                        </div>
                        <div class="reply_Content"><input type="text" name="reply" size="40" placeholder="의견을 입력하세요">
                        </div>
                        <div class="reply_AD">
                            <input type="submit" value="작성" onclick="return replyAppCheck();"/>
                        </div>
                    </div>
                </form>
                <c:choose>
                    <c:when test="${replyList.size()==0}">
                        <div class="reply_msg">의견이 없습니다.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${replyList}" var="reply">
                            <div class="reply_body">
                                <div class="reply_Writer">
                                    <c:forEach items="${providerList}" var="provider">
                                <c:if test="${loginUser.provider == provider.id}">${provider.name}</c:if>
                            </c:forEach>
                                </div>
                                <div class="reply_Date"><fmt:formatDate value="${reply.writedate}"
                                                                        pattern="MM/dd hh:mm"/></div>
                                <div class="reply_Content">${reply.reply}</div>
                                <div class="reply_AD">
                                    <c:if test="${reply.userid==loginUser.id}">
                                        <input type="button" value="삭제"
                                               onClick="deleteAppReply('${reply.id}','${app.id}')"/>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

</div>


<script>
    function calDay() {
        const startInput = document.getElementById("startDay");
        const endInput = document.getElementById("endDay");

        const startDate = new Date(startInput.value);
        const endDate = new Date(endInput.value);

        // 입력된 값이 둘 다 유효할 경우에만 비교
        if (startInput.value && endInput.value) {
            if (endDate < startDate) {
                alert("만료일은 발생일보다 이전일 수 없습니다.");
                endInput.value = ""; // 만료일 초기화
                endInput.focus();    // 다시 입력 유도
            }
        }
    }

    function ajaxViewDate() {
        const startInput = document.getElementById("startDay");
        const endInput = document.getElementById("endDay");
        const searchid = new URLSearchParams(location.search).get("id");

        if (startInput.value && endInput.value) {
            if (endInput.value < startInput.value) {
                alert("만료일은 발생일보다 이전일 수 없습니다.");
                endInput.value = "";
                endInput.focus();
            } else {
                let formData = {
                    id: searchid,
                    startdate: startInput.value,  // "yyyy-MM-dd"
                    enddate: endInput.value
                };

                $.ajax({
                    url: location.origin + "/ajaxViewDate",
                    type: "POST",
                    data: JSON.stringify(formData),
                    contentType: 'application/json',
                    timeout: 10000,
                    success: function (data) {
                        alert("연차 기안일이 저장되었습니다.");
                    },
                    error: function () {
                        alert("실패했습니다.");
                    }
                });
            }
        }
    }
</script>

<%@ include file="../footer.jsp" %>
