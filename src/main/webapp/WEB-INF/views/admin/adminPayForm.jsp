<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp" %>
<section class="section admin">
    <%@include file="../lnb.jsp" %>
    <div class="main">

            <h2 class="title">급여조정</h2>
            <div class="tableWrap">
                <table>
                    <colgroup>
                        <col width="150px">
                        <col width="">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>사원명</th>
                            <td style="text-align: left">${name}</td>
                        </tr>
                        <tr>
                            <th>현재 급여</th>
                            <td style="text-align: left">원</td>
                        </tr>
                        <tr>
                            <th>변경 급여</th>
                            <td style="text-align: left">
                                <input id="updatePay" name="updatePay" class="inputStyle" type="number" max="99999999" oninput="this.value = this.value.slice(0, 8)" placeholder="1000000" />원</td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td style="text-align: left"><input type="text" id="title" class="inputStyle" name="title" value="2025년 8월분 급여명세서" required /></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td style="text-align: left">
                               <textarea id="content" name="content" required>안녕하세요.
2025년 6월 급여명세서를 보내드립니다.
귀하의 노고에 감사드립니다.
                               </textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="btnWrap topright">
                    <button class="btn" onclick="adminInsertPay(${id});">보내기</button>
                    <button class="btn">취소</button>
                </div>
            </div>

    </div>
</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="/script/admin.js"></script>
</body>
</html>