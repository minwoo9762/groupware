<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section>
    <%@include file="../lnb.jsp"%>
    <div class="container">
        <h2 class="title" style="font-size:40px;">게시판</h2>
        <div class="search">
            부서명
            <select>
                <option>선택</option>
                <option>인사</option>
                <option>영업</option>
                <option>1팀</option>
                <option>2팀</option>
            </select>
            <input type="text" />
            <input type="button" />
                검색
        </div>

        <div class="titleBox">
            <div>
              <div>No.</div>
              <div>사용자명</div>
              <div >제 목</div>
              <div>작성 일자</div>
              <div>비 고</div>
            </div>
       </div>

        <div class="contentBox">
            <c:forEach items="${boardList}" var="board" >
                <div class>
                    <div>${board.id}</div>
                    <div>${loginUser.name}</div>
                    <div>
                    <a href="boardView?id=${board.id}">
                    ${board.title}
                    </a>
                    </div>
                    <div>${board.indate}</div>
                    <div>댓 글${board.replycnt}</div>
                </div>
           </c:forEach>
        </div>

        <div class="writebutton">
            <input type="button" value="게시물 등록" onclick="location.href='boardWrite'" />
        </div>
    <div style="display: flex; justify-content: center; font-size: 105%">
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
                <a href="workBoard?page=${paging.endPage+1}">NEXT</a>&nbsp;
            </c:if>
        </div>
    </div>
</section>
</body>
</html>
