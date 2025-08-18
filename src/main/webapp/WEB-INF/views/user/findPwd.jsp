<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Find Password</title>
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
                        alert(data.findPwdMsg);
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
                        $('#confirmMsg').html("&nbsp;&nbsp;<span style='color:blue'>인증에 성공했습니다.</span>")
                        if(data.state == 'confirmed')
                            $('#codeCheck').val('confirmed');
                        $('#changePwd').show();
                    },
                    error: function() {
                        alert(data.codeMsg);
                    }
                });
            });
        });
    </script>
    <script type="text/javascript">
        function updatePwd() {
            if(document.findPwd.pwd.value==''){
                alert('비밀번호를 입력하세요.');
                return;
            }
            else if(document.findPwd.pwd.value != document.findPwd.confirmPwd.value) {
                alert('비밀번호 확인이 일치하지 않습니다.');
                return;
            }else if(document.findPwd.codeCheck.value != 'confirmed') {
                alert('이메일 인증을 완료하지 않았습니다.');
                return;
            }else {
                document.findPwd.action = "updatePwd";
                document.findPwd.submit();
            }
        }
    </script>
</head>
<body>

<form method="post" name="findPwd" id="findPwd">
    <h2>Find Password</h2>
    <div class="field">
        <label>이름</label><input type="text" name="name">
    </div>
    <div class="field">
        <label>이메일 인증</label>
        <div>
            <input type="text" name="email">
            <input type="button" value="인증메일 보내기" id="sendMailForPwd">
            <input type="hidden" name="sendCheck" id="sendCheck">
        </div>
    </div>
    <div class="field">
        <label>인증번호 입력</label>
        <div>
            <input type="text" name="code">
            <input type="button" value="인증하기" id="confirmCode">
            <div id="confirmMsg"></div>
            <input type="hidden" name="codeCheck" id="codeCheck">
        </div>
    </div>
    <div id="changePwd" style="display: none">
        <div class="field">
            <label>새 비밀번호</label>
            <input type="password" name="pwd">
        </div>
        <div class="field">
            <label>비밀번호 확인</label>
            <input type="password" name="confirmPwd">
        </div>
        <div class="field">
            <input type="button" value="비밀번호 변경" onclick="updatePwd()">
        </div>
    </div>
</form>
</body>
</html>
