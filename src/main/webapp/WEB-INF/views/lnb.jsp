<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="/css/lnb.css">
<div class="lnb">
    <ul>
        <li><span id="home" onclick="location.href='home'" style="cursor: pointer;">HOME</span></li>
        <li>
            <span>인사관리</span></span>
            <ul class="depth">

                <li><a href="attendance?aseq=${loginUser.id}">근태 조회</a></li>
                <li><a href="appMain">전자 결재</a></li>
                <li><a href="paycheck?=${loginUser.id}">급여 조회</a></li>

            </ul>
        </li>
        <li>
            <span>업무관리</span>
            <ul class="depth">
                <li><a href="workBoard">게시판</a></li>
                <li><a href="#">메일</a></li>
                <li><a href="#">자료실</a></li>
            </ul>
        </li>
        <li>
            <span>관리자</span>
            <ul class="depth">
                <li><a href="admin">사원 관리</a></li>
                <li><a href="notice">공지사항</a></li>
            </ul>
        </li>
    </ul>

</div>

