<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>
    <form method="get" name="frm" class="main">
    <div class="main">
        <h2 class="head" style="font-size:40px;">게시판</h2>
        <div class="searchWrap">
            부서명
            <select id="department" onchange="searchPosts()">
                <option value="">선택</option>
                <option value="1">개발</option>
                <option value="2">기획</option>
                <option value="3">영업</option>
                <option value="4">운영</option>
                <option value="5">인사</option>
            </select>
            &nbsp;&nbsp;
                <input type="text" name="key" placeholder="검색어 입력" value="${key}">
                <input type="button" name="btn_search" value="검색" onclick="go_searchWork('workBoard')" />

        </div>
        <div class="tableWrap">
            <div class="table">
                <div class="thead">
                    <div class="tr">
                        <div class="th" style="flex: 1">No.</div>
                        <div class="th"  style="flex: 2">사용자명</div>
                        <div class="th" style="flex: 2">부서명</div>
                        <div class="th"  style="flex: 6">제 목</div>
                        <div class="th"  style="flex: 2">작성 일자</div>
                        <div class="th"  style="flex: 2">비 고</div>
                    </div>
                </div>
            </div>
            <c:choose>
            <c:when test="${boardList.size()==0}">
            목록이 없습니다
            </c:when>
            <c:otherwise>
            <c:forEach items="${boardList}" var="board" >
                <div class="tr">
                    <div class="td" style="flex: 1">${board.id}</div>
                    <div class="td" style="flex: 2">${board.name}</div>
                    <div class="td" style="flex: 2">
                    <c:choose>
                        <c:when test="${board.part == 1}">개발팀</c:when>
                        <c:when test="${board.part == 2}">기획팀</c:when>
                        <c:when test="${board.part == 3}">영업팀</c:when>
                        <c:when test="${board.part == 4}">운영팀 </c:when>
                        <c:when test="${board.part == 5}">인사팀 </c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
                    </div>
                    <div class="td" style="flex: 6" >
                    <a href="boardView?id=${board.id}">
                    ${board.title}
                    </a>
                    </div>
                    <div class="td" style="flex: 2">${board.indate}</div>
                    <div class="td" style="flex: 2">댓 글${board.replycnt}</div>
                </div>
           </c:forEach>
           </c:otherwise>
           </c:choose>

                </div>
        <div class="writebutton">
            <input type="button" value="게시물 등록" onclick="location.href='boardWrite'" />
        </div>
    <div class="row">  <!-- 페이지의 시작 -->
			<div class="col" style="font-size:120%; font-weight:bold;">
				<c:if test="${paging.prev}" >
					<a href="workBoard?page=${paging.beginPage-1}">PREV</a>&nbsp;
				</c:if>


				<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
					<c:if test="${index!=paging.page}">
						<a href="workBoard?page=${index}">${index}</a>&nbsp;
					</c:if>
					<c:if test="${index==paging.page}">
						<span style="color:red">${index}&nbsp;</span>
					</c:if>
				</c:forEach>


				<c:if test="${paging.next}" >
					<a href="workBoar?page=${paging.endPage+1}">NEXT</a>&nbsp;
				</c:if>
			</div>
    </div>
    </div>
    </form>
</section>
</body>
</html>