<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="/css/lnb.css">
<div class="lnb">
    <ul>
        <li><span id="home" onclick="location.href='home'" style="cursor: pointer;">HOME</span></li>
        <li>
            <span>인사관리</span></span>
            <ul class="depth">

                <li><a href="attendance?aseq=${loginUser.id}">근태 조회</a></li>
                <li><a href="appMain?first=y">전자 결재</a></li>
                <li><a href="paycheck?=${loginUser.id}&first=y">급여 조회</a></li>
                <li><a href="allInfoCtr?tabid=1">정보 수정</a></li>

            </ul>
        </li>
        <li>
            <span>업무관리</span>
            <ul class="depth">
                <li><a href="workBoard?first=y">게시판</a></li>
                <li><a href="mail">메일</a></li>
                <li><a href="fileMain?first=y">자료실</a></li>
            </ul>
        </li>
        <c:if test="${loginUser.provider != 1}">
        <li>
            <span>관리자</span>
            <ul class="depth">
                <li><a href="admin">사원 관리</a></li>
                <li><a href="notice?first=y">공지사항</a></li>
                <li><a href="appMain?first=y">전자 결재</a></li>
            </ul>
        </li>
        </c:if>

    </ul>

</div>

<script>
    document.querySelectorAll('.lnb li').forEach(li => {
        const submenu = li.querySelector('ul.depth');
        if (!submenu) return;

        li.addEventListener('mouseenter', () => {
            submenu.style.maxHeight = submenu.scrollHeight + 'px';
        });

        li.addEventListener('mouseleave', () => {
            submenu.style.maxHeight = '0';
        });
    });
</script>

