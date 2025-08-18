<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
  <%@include file="../lnb.jsp"%>
<div class="main">
        <h2 class="title" style="font-size:40px;">전자 결제</h2>
        <div class="searchWrap">
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
        <div class="tableWrap">
            <div class="table">
                <div class="thead">
                    <div class="tr">
                        <div class="th" style="flex: 1">No.</div>
                        <div class="th"  style="flex: 2">사용자명</div>
                        <div class="th"  style="flex: 8">제 목</div>
                        <div class="th"  style="flex: 2">작성 일자</div>
                        <div class="th"  style="flex: 2"></div>
                    </div>
                </div>
            </div>
            <c:forEach items="${approvalList}" var="approval" >
                <div class="tr">
                    <div class="td" style="flex: 1">${approval.id}</div>
                    <div class="td" style="flex: 2">${approval.name}</div>
                    <div class="td" style="flex: 8" >${approval.title}</div>
                    <div class="td" style="flex: 2">${approval.indate}</div>
                </div>
           </c:forEach>
                </div>
        <div class="btn">
            <input type="button" value="삭제" onclick="location.href='deleteApproval'" />
            <input type="button" value="뒤로가기" onclick="location.href='approvalMain'" />
        </div>
    <div style="display: flex; justify-content: center; font-size: 105%">
            <c:if test="${paging.prev}" >
                <a href="main?page=${paging.beginPage-1}">PREV</a>&nbsp;
            </c:if>
            <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                <c:if test="${index!=paging.page}">
                    <a href="main?page=${index}">${index}</a>&nbsp;
                </c:if>
                <c:if test="${index==paging.page}">
                    <span style="color:red">${index}&nbsp;</span>
                </c:if>
            </c:forEach>
            <c:if test="${paging.next}" >
                <a href="main?page=${paging.endPage+1}">NEXT</a>&nbsp;
            </c:if>
        </div>
    </div>

</section>

</body>
</html>
