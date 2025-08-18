<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JOIN</title>
    <script src="script/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#duplication').click(function(){
                if(document.insertForm.email.value==''){
                    alert('이메일을 입력하세요.');
                    return;
                }
                var formSelector = $('#insertForm')[0];
                var formData = new FormData(formSelector);
                $.ajax(
                    {
                        url: '<%=request.getContextPath()%>/emailCheck',
                        type: 'POST',
                        async: false,
                        data: formData,
                        timeout: 10000,
                        contentType: false,
                        processData: false,
                        success: function(data) {

                            if(data.result == 1) {
                                $('#duplicationMsg').html("&nbsp;&nbsp;<span style='color:blue'>사용 가능한 아이디입니다.</span>")
                                $('#emailCheck').val(data.email);
                            }else{
                                $('#duplicationMsg').html("&nbsp;&nbsp;<span style='color:red'>이미 사용 중인 아이디입니다.</span>")
                                $('#emailCheck').val('');
                            }
                        },
                        error: function() {
                            alert('중복 조회 중 에러가 발생했습니다.')
                        }
                    }
                );
            });

            $('#pfimg').change(function() {
                var formSelector = $('#selectImg')[0];
                var formData = new FormData(formSelector);
                $.ajax(
                    {
                        url: "<%=request.getContextPath()%>/fileup",
                        type: "POST",
                        enctype: "multipart/form-data",
                        data: formData,
                        timeout: 10000,
                        contentType: false,
                        processData: false,
                        success: function(data) {
                            $('#profileimgPrev').html(
                                "<img src='" + data.url + "' height='100'>"
                            );
                            $('#profileimg').val(data.url);
                        },
                        error : function() {
                            alert('파일 업로드에 실패했습니다.');
                        }
                    }
                );
            });
        });
    </script>
</head>
<body>
<form method="post" action="join" name="insertForm" id="insertForm">
    <div class="loginForm">
        <h2>Join</h2>
        <div class="field">
            <label>E-Mail</label>
            <div>
                <input type="text" name="email" value="${dto.email}">
                <input type="button" value="중복검사" id="duplication">
                <div id="duplicationMsg" style="flex: 2"></div>
                <input type="hidden" name="emailCheck" id="emailCheck" value="${emailCheck}">
            </div>
        </div>
        <div class="field">
            <label>비밀번호</label>
            <input type="password" name="pwd">
        </div>
        <div class="field">
            <label>비밀번호 확인</label>
            <input type="password" name="pwdCheck">
        </div>
        <div class="field">
            <label>이름</label>
            <input type="text" name="name" value="${dto.name}">
        </div>
        <div class="field">
            <label>부서</label>
            <select name="part">
                <option value="0">선택하세요</option>
                <option value="1">1부서</option>
                <option value="2">2부서</option>
                <option value="3">3부서</option>
            </select>
        </div>
        <div class="field">
            <label>전화번호</label>
            <input type="text" name="phone" value="${dto.phone}">
        </div>
        <div class="field">
            <label>주소</label>
            <input type="text" name="address1"><br>
            <input type="text" name="address2">
        </div>
        <div class="field">
            <label>프로필 미리보기</label>
            <c:choose>
                <c:when test="${empty dto.profileimg}">
                    <div id="profileimgPrev"></div>
                </c:when>
                <c:otherwise>
                    <div id="profileimgPrev"><img src="${dto.profileimg}" height="100"></div>
                </c:otherwise>
            </c:choose>
        </div>
        <input type="hidden" name="profileimg" id="profileimg" value="${dto.profileimg}">
        <div class="btn">
            <input type="submit" value="가입">
            <input type="button" value="돌아가기" onclick="location.href='/'">
        </div>
        <div>${message}</div>
    </div>
</form>
<form id="selectImg" method="post" enctype="multipart/form-data">
    <div class="loginform" style="margin: 0">
        <div class="field">
            <label>프로필 이미지</label>
            <input type="file" name="pfimg" id="pfimg" value="이미지 선택">
        </div>
    </div>
</form>
</body>
</html>
