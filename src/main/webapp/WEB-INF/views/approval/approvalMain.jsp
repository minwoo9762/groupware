<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>
    <form method="get" name="frm" class="main">
    <div class="main">
        <h2 class="head" style="font-size:40px;">전자결재</h2>
        <div class="searchWrap">
            부서명
            <select>
                <option >선택</option>
                <option value="1">인사</option>
                <option>영업</option>
                <option>1팀</option>
                <option>2팀</option>
            </select>
            &nbsp;&nbsp;
                <input type="text" name="key" placeholder="검색어 입력" value="${key}">
                <input type="button" name="btn_search" value="검색" onclick="go_search('appMain')" />

        </div>
        <div class="tableWrap">
            <div class="table">
                <div class="thead">
                    <div class="tr">
                        <div class="th" style="flex: 1">부서명</div>
                        <div class="th"  style="flex: 2">사용자명</div>
                        <div class="th" style="flex: 2">카테고리</div>
                        <div class="th"  style="flex: 6">제 목</div>
                        <div class="th"  style="flex: 2">작성 일자</div>
                        <div class="th"  style="flex: 2">상 태</div>
                    </div>
                </div>
            </div>
            <c:forEach items="${appList}" var="app" >
                <div class="tr">
                    <div class="td" style="flex: 1">${partName}</div>
                    <div class="td" style="flex: 2">${app.username}</div>
                    <div class="td" style="flex: 2">${categoryName}</div>
                    <div class="td" style="flex: 6" >
                    <a href="appView?id=${app.id}">
                    ${app.title}
                    </a>
                    </div>
                    <div class="td" style="flex: 2">${app.indate}</div>
                    <div class="td" style="flex: 2">${statusName}</div>
                </div>
           </c:forEach>
                </div>
        <div class="writebutton">
            <input type="button" value="결재 신청" onclick="location.href='appWrite'" />
        </div>
    <div class="row">  <!-- 페이지의 시작 -->
			<div class="col" style="font-size:120%; font-weight:bold;">
				<c:if test="${paging.prev}" >
					<a href="appMain?page=${paging.beginPage-1}">PREV</a>&nbsp;
				</c:if>


				<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
					<c:if test="${index!=paging.page}">
						<a href="appMain?page=${index}">${index}</a>&nbsp;
					</c:if>
					<c:if test="${index==paging.page}">
						<span style="color:red">${index}&nbsp;</span>
					</c:if>
				</c:forEach>


				<c:if test="${paging.next}" >
					<a href="appMain?page=${paging.endPage+1}">NEXT</a>&nbsp;
				</c:if>
			</div>
    </div>
    </div>
    </form>
</section>
</body>
</html>