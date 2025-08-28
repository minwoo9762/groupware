<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Find Password</title>
    <link rel="stylesheet" href="/css/login.css">
    <script src="script/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
        function updatePwd() {
            // 비밀번호 판정 정규식 : 영문, 숫자, 일부 특수문자를 포함한 8~20자 이내의 문자
            var pwdRegex = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()-+=]).{8,20}$/;
            if(document.updatePwd.pwd.value===''){
                alert('비밀번호를 입력하세요.');
            }else if(!pwdRegex.test(document.updatePwd.pwd.value)) {
                alert('올바른 비밀번호를 입력하세요.');
            } else if(document.updatePwd.pwd.value !== document.updatePwd.confirmPwd.value) {
                alert('비밀번호 확인이 일치하지 않습니다.');
            }else {
                document.updatePwd.submit();
            }
        }
    </script>
</head>
<body>

<form method="post" name="updatePwd" action="updatePwd">
    <div class="loginForm" id="changePwd">
        <h2>New Password</h2>
        <div class="field">
            <label>새 비밀번호</label>
            <input type="password" name="pwd">
        </div>
        <div style="font-size: 80%; color: gray">
            비밀번호는 숫자와 특수문자를 포함한 8자 이상, 20자 이하의 영문으로 작성합니다.
        </div>
        <div class="field">
            <label>비밀번호 확인</label>
            <input type="password" name="confirmPwd">
        </div>
        <div class="btn">
            <input type="button" value="비밀번호 변경" onclick="updatePwd()">
        </div>
    </div>
</form>

</body>
</html>
