<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="lnb">
    <ul>
        <li><span id="home" onclick="location.href='home'" style="cursor: pointer;">HOME</span></li>
        <li>
            <span>인사관리</span>
            <ul class="depth">

                <li><a href="attendance?aseq=${loginUser.id}" data-parent="인사관리">근태 조회</a></li>
                <li><a href="appMain?first=n" data-parent="인사관리">전자 결재</a></li>
                <li><a href="paycheck?pseq=${loginUser.id}&first=y" data-parent="인사관리">급여 조회</a></li>

            </ul>
        </li>
        <li>
            <span>업무관리</span>
            <ul class="depth">
                <li><a href="workBoard?first=y" data-parent="업무관리">게시판</a></li>
                <li><a href="mail" data-parent="업무관리">메일</a></li>
                <li><a href="fileMain?first=y" data-parent="업무관리">자료실</a></li>
            </ul>
        </li>
        <c:if test="${loginUser.provider == 1}">
        <li>
            <span>관리자</span>
            <ul class="depth">
                <li><a href="admin" data-parent="관리자" >사원 관리</a></li>
                <li><a href="notice?first=y" data-parent="관리자" >공지사항</a></li>
                <li><a href="appMain?first=y" data-parent="관리자">전자 결재</a></li>
                <li><a href="allInfoCtr?tabid=1" data-parent="관리자" >정보 수정</a></li>
            </ul>
        </li>
        </c:if>

    </ul>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const subLinks = document.querySelectorAll('.lnb ul.depth li a');
        const currentFullPath = window.location.pathname + window.location.search;

        // 현재 URL과 data-parent 모두 정확히 일치하는 링크를 찾기
        let matched = null;

        subLinks.forEach(link => {
            const u = new URL(link.href);
            const linkFullPath = u.pathname + u.search;
            const expectedParent = link.dataset.parent?.trim();

            if (linkFullPath === currentFullPath && expectedParent) {
                if (!matched) matched = { link, expectedParent };
            }
        });

        if (matched) {
            const { link, expectedParent } = matched;
            link.classList.add('active');

            // 해당 상위 메뉴만 active 처리
            document.querySelectorAll('.lnb > ul > li').forEach(li => {
                const spanText = li.querySelector('span')?.innerText?.trim();
                li.classList.toggle('active', spanText === expectedParent);
            });
        }
    });

</script>
