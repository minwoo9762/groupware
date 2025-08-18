<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LOGIN</title>

</head>
<body>
    <form method="post" action="login" name="loginForm">
        <div class="loginForm">
            <h2>Login</h2>
            <div class="field">
                <label>E-Mail</label>
                <input type="text" name="email" value="${dto.email}">
            </div>
            <div class="field">
                <label>Password</label>
                <input type="password" name="pwd">
            </div>
        </div>
        <div class="btn">
            <input type="submit" value="로그인">
        </div>
        <div class="btn">
            <input type="button" value="회원가입" onclick="location.href='joinForm'">
            <input type="button" value="비밀번호 찾기" onclick="location.href='findPwd'">
        </div>
        <div>${message}</div>
    </form>
</body>
</html>
