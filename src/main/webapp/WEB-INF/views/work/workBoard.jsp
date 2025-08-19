<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>
    <div class="main">
        <h2 class="title" style="font-size:40px;">게시판</h2>
        <div class="searchWrap">
            부서명
            <select>
                <option>선택</option>
                <option>인사</option>
                <option>영업</option>
                <option>1팀</option>
                <option>2팀</option>
            </select>
            &nbsp;&nbsp;
                <input type="text" name="key" placeholder="검색어 입력" value="${key}">
                <input type="button" name="btn_search" value="검색" onclick="go_search('workBoard')" />

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
            <c:forEach items="${boardList}" var="board" >
                <div class="tr">
                    <div class="td" style="flex: 1">${board.id}</div>
                    <div class="td" style="flex: 2">${board.name}</div>
                    <div class="td" style="flex: 2">${partName}</div>
                    <div class="td" style="flex: 6" >
                    <a href="boardView?id=${board.id}">
                    ${board.title}
                    </a>
                    </div>
                    <div class="td" style="flex: 2">${board.indate}</div>
                    <div class="td" style="flex: 2">댓 글${board.replycnt}</div>
                </div>
           </c:forEach>
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
</section>
</body>
</html>