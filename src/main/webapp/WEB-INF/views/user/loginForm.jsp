<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LOGIN</title>
    <link rel="stylesheet" href="/css/login.css">
</head>
<body>
    <div class="container">
        <form method="post" action="login" name="loginForm">
            <div class="loginForm">
                <h2>Login</h2>
                <div class="field">
                    <div >
                        <div class="field">
                            <label>E-Mail</label>
                            <input type="text" name="email" value="${dto.email}">
                        </div>
                        <div class="field">
                            <label>Password</label>
                            <input type="password" name="pwd">
                        </div>
                    </div>
                    <div class="message">${message}</div>
                    <div class="btn">
                            <input type="submit" value="로그인">
                    </div>
                </div>
                <div class="sub-buttons">
                    <input type="button" value="비밀번호 찾기" onclick="location.href='findPwd'"> |
                    <input type="button" value="회원가입" onclick="location.href='joinForm'">
                </div>

            </div>
        </form>
    </div>
</body>
</html>
