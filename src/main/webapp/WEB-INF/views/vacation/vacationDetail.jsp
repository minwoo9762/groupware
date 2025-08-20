<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>

<!-- ✅ layout 시작 -->
<div class="layout" style="display: flex;">

    <!-- ✅ 왼쪽 메뉴 -->
    <%@ include file="../lnb.jsp" %>

    <article>
        <form name="frmm">
            <h2>${vacationDetail.title}</h2>
            <div class="field">
                <div>${vacationDetail.content}</div>
            </div>
            <div class="btn">
                <input type="button" value="수정" onclick="location.href='vacationUpdate'">
                <input type="button" value="삭제" onclick="deleteVacation('${vacationDetail.pseq}')">
                <input type="button" value="이전" onclick="location.href='vacation'">
            </div>
        </form>
    </article>
</div>


<%@ include file="../footer.jsp" %>