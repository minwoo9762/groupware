<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Find Password</title>
    <link rel="stylesheet" href="/css/login.css">
    <script src="script/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#sendMailForPwd').click(function() {
                if(document.findPwd.name.value == '') {
                    alert('이름을 입력하세요.');
                    return;
                }else if(document.findPwd.email.value == ''){
                    alert('이메일을 입력하세요.');
                    return;
                }else {
                    var selectForm = $('#findPwd')[0];
                    var formData = new FormData(selectForm);
                }

                $.ajax({
                    url: "<%=request.getContextPath() %>/sendMailForPwd",
                    type: "POST",
                    async: false,
                    data: formData,
                    timeout:10000,
                    contentType: false,
                    processData: false,
                    success: function(data) {
                        alert(data.findPwdMsg);
                        if(data.state == 'sended')
                            $('#sendCheck').val('sended');
                    },
                    error: function() {
                        alert('에러 발생');
                    }
                });
            });

            $('#confirmCode').click(function() {
                if(document.findPwd.code.value == '') {
                    alert('인증번호를 입력하세요.');
                    return;
                }else {
                    var selectForm = $('#findPwd')[0];
                    var formData = new FormData(selectForm);
                }

                $.ajax({
                    url: "<%=request.getContextPath() %>/confirmCode",
                    type: "POST",
                    async: false,
                    data: formData,
                    timeout:10000,
                    contentType: false,
                    processData: false,
                    success: function(data) {
                        if(data.state == 'confirmed') {
                            $('#confirmMsg').html("&nbsp;&nbsp;<span style='color:blue'>인증에 성공했습니다.</span>")
                            $('#codeCheck').val('confirmed');
                            $('#next_btn').css('background', 'blue');
                            $('#next_btn').prop('disabled', false);
                        }else {
                            alert(data.codeMsg);
                        }
                    },
                    error: function() {
                        alert('에러 발생');
                    }
                });
            });
        });
    </script>
    <script type="text/javascript">

    </script>
</head>
<body>

<form method="post" name="findPwd" id="findPwd">
    <div class="loginForm">
        <h2>Find Password</h2>
        <div class="field">
            <label>이름</label><input type="text" name="name">
        </div>
        <div class="field">
            <label>이메일 인증</label>
            <div class="btn">
                <input type="text" name="email">
                <input type="button" value="인증메일 보내기" id="sendMailForPwd">
                <input type="hidden" name="sendCheck" id="sendCheck">
            </div>
        </div>
        <div class="field">
            <label>인증번호 입력</label>
            <div class="btn">
                <input type="text" name="code">
                <input type="button" value="인증하기" id="confirmCode">
                <div id="confirmMsg"></div>
                <input type="hidden" name="codeCheck" id="codeCheck">
            </div>
        </div>
        <div class="btn">
            <input type="button" value="돌아가기" onclick="location.href='/'">
            <input type="button" id="next_btn" style="background: gray"
                   value="다음으로" onclick="location.href='/changePwd'" disabled>
        </div>
    </div>
</form>

</body>
</html>
