<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="lnb">
    <ul>
        <li><span onclick="location.href='home'" style="cursor: pointer;">HOME</span></li>
        <li>
            <span>인사관리</span></span>
            <ul class="depth">

                <li><a href="attendance?id=2"<%--+${id}--%>>근태 조회</a></li>
                <li><a href="vacation?id=2"<%--+${id}--%>>결재 조회</a></li>
                <li><a href="paycheck">급여 조회</a></li>

            </ul>
        </li>
        <li>
            <span>업무관리</span>
            <ul class="depth">
                <li><a href="workBoard">게시판</a></li>
                <li><a href="#">메일</a></li>
                <li><a href="approvalMain">전자결재</a></li>
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

