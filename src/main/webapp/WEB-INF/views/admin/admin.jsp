<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp" %>
<section class="section admin">
    <%@include file="../lnb.jsp" %>
    <div class="main">
        <h2 class="title">Admin</h2>
        <div class="searchWrap">
            <input type="text" class="inputStyle" id="key"/>
            <button class="btn btnSearch" type="button" onClick="go_search(this)" />
                검색
            </button>
        </div>
        <div class="tableWrap">
            <table>
                <colgroup>
                    <col width="44px">
                    <col width="">
                    <col width="">
                    <col width="">
                    <col width="">
                </colgroup>
                <thead>
                <tr>
                    <th>No.</th>
                    <th>사용자명</th>
                    <th>직급</th>
                    <th>부서</th>
                    <th>상태</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${userList}" var="user" varStatus="i">
                    <tr>
                        <%--<td>${(userList.size() - i.count) + 1}</td>--%>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>
                            <select class="providerSelect btn">
                                <option value="0" ${user.provider == 0 ? 'selected' : ''}>선택</option>
                                <option value="1" ${user.provider == 1 ? 'selected' : ''}>사원</option>
                                <option value="2" ${user.provider == 2 ? 'selected' : ''}>주임</option>
                                <option value="3" ${user.provider == 3 ? 'selected' : ''}>대리</option>
                                <option value="4" ${user.provider == 4 ? 'selected' : ''}>과장</option>
                                <option value="5" ${user.provider == 5 ? 'selected' : ''}>부장</option>
                                <option value="6" ${user.provider == 99 ? 'selected' : ''}>대표(관리자)</option>
                            </select>
                        </td>
                        <td>
                            <select class="partSelect btn">
                                <option value="0" ${user.part == 0 ? 'selected' : ''}>선택</option>
                                <option value="1" ${user.part == 1 ? 'selected' : ''}>개발팀</option>
                                <option value="2" ${user.part == 2 ? 'selected' : ''}>기획팀</option>
                                <option value="3" ${user.part == 3 ? 'selected' : ''}>영업팀</option>
                                <option value="4" ${user.part == 4 ? 'selected' : ''}>운영팀</option>
                                <option value="5" ${user.part == 5 ? 'selected' : ''}>인사팀</option>
                                <option value="6" ${user.part == 6 ? 'selected' : ''}>미정</option>
                            </select>
                        </td>
                        <td>
                            <select class="stateSelect btn">
                                <option value="0" ${user.part == 0 ? 'selected' : ''}>선택</option>
                                <option value="1" ${user.part == 1 ? 'selected' : ''}>재직</option>
                                <option value="2" ${user.part == 2 ? 'selected' : ''}>퇴사</option>
                                <option value="3" ${user.part == 3 ? 'selected' : ''}>휴직</option>
                            </select>
                        </td>
                        <td>
                            <button class="btn change" data-id="${user.id}" onclick="userUpdate(this)">저장하기</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="row">  <!-- 페이지의 시작 -->
                <div class="coltitle" style="text-align: center; font-size:120%; font-weight:bold;">
                    <c:if test="${paging.prev}"><a href="admin?page=${paging.beginPage-1}">◁</a></c:if>&nbsp;

                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                        <c:if test="${index!=paging.page}">
                            <a href="admin?page=${index}">${index}&nbsp;</a>
                        </c:if>
                        <c:if test="${index==paging.page}">
                            <span style="color:red">${index}&nbsp;</span>
                        </c:if>
                    </c:forEach>

                    &nbsp;
                    <c:if test="${paging.next}"><a href="admin?page=${paging.endPage+1}">▷</a></c:if>
                </div>
            </div>
            <%--페이지의 끝--%>
        </div>
    </div>
</section>

<script src="/script/admin.js"></script>
</body>
</html>