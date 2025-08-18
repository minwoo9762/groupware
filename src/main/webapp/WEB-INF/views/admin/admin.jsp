
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@include file="../header.jsp"%>
    <section class="section admin">
        <%@include file="../lnb.jsp"%>
        <div class="main">
            <h2 class="title">Admin</h2>
            <div class="searchWrap">
                <select>
                    <option>사용자명</option>
                </select>
                <select>
                    <option>직급</option>
                </select>
                <select>
                    <option>부서</option>
                </select>
                <select>
                    <option>상태</option>
                </select>
                <input type="text" />
                <button type="button">
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
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>4</td>
                            <td>강희준</td>
                            <td>대표</td>
                            <td>개발팀</td>
                            <td>퇴사</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>강희준</td>
                            <td>부장</td>
                            <td>개발팀</td>
                            <td>퇴사</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>강희준</td>
                            <td>사원</td>
                            <td>개발팀</td>
                            <td>퇴사</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>강희준</td>
                            <td>대리</td>
                            <td>기획팀</td>
                            <td>퇴사</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</body>
</html>