<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>
<section class="section myPage">
    <%@include file="../lnb.jsp"%>
    <form method="post" name="updatePwd" id="updatePwd">
        <input type="hidden" name="email" value="${loginUser.email}">
        <h2>Change Password</h2>
        <div class="field">
            <label>새 비밀번호</label>
            <input type="password" name="pwd">
        </div>
        <div class="field">
            <label>비밀번호 확인</label>
            <input type="password" name="confirmPwd">
        </div>
        <div class="field">
            <input type="button" value="비밀번호 변경" onclick="changePwd()">
        </div>
        <script type="text/javascript">
            function changePwd() {
                if(document.updatePwd.pwd.value==''){
                    alert('비밀번호를 입력하세요.');
                }
                else if(document.updatePwd.pwd.value != document.updatePwd.confirmPwd.value) {
                    alert('비밀번호 확인이 일치하지 않습니다.');
                }else {
                    document.updatePwd.action = "updatePwd";
                    document.updatePwd.submit();
                }
            }
        </script>
    </form>
</section>
</body>
</html>
