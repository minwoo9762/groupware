<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>JOIN</title>
    <link rel="stylesheet" href="/css/login.css">
    <script src="script/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#duplication').click(function(){
                var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if(document.insertForm.email.value==''){
                    alert('이메일을 입력하세요.');
                    return;
                }else if(!emailRegex.test(document.insertForm.email.value)) {
                    alert('이메일을 정확히 입력하세요.');
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
                                "<img src='/images/" + data.profileimg + "' height='100'>"
                            );
                            $('#profileimg').val(data.profileimg);
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
            <div class="btn">
                <input type="text" name="email" value="${dto.email}">&nbsp;
                <input type="button" value="중복검사" id="duplication">
                <div id="duplicationMsg" style="flex: 2"></div>
                <input type="hidden" name="emailCheck" id="emailCheck" value="${emailCheck}">
            </div>
        </div>
        <div class="field">
            <label>비밀번호</label>
            <input type="password" name="pwd">
        </div>
        <div style="font-size: 80%; color: gray">
            비밀번호는 숫자와 특수문자를 포함한 8자 이상, 20자 이하의 영문으로 작성합니다.
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
            <label>우편번호</label>
            <div class="btn">
                <input type="text" id="my_postcode" name="zipNum" value="${dto.zipNum}" readonly>&nbsp;
                <input type="button" value="우편번호 찾기" onclick="findZipNum()">
            </div>
        </div>
        <div class="field">
            <label>주소</label><input type="text" id="my_address" name="address1" value="${dto.address1}" readonly>
        </div>
        <div class="field">
            <label>상세 주소</label>
            <input type="text" id="my_detailAddress" name="address2" value="${dto.address2}" style="flex: 4">&nbsp;
            <input type="text" id="my_extraAddress" name="address3" value="${dto.address3}" style="flex: 1">
        </div>
        <div class="field">
        </div>
        <!-- 다음 카카오 도로명 주소 검색을 위한 자바스크립트 코드 -->
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script type="text/javascript">
            function findZipNum() {
                new daum.Postcode( {
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수

                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                        if(data.userSelectedType === 'R'){
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                            // 조합된 참고항목을 해당 필드에 넣는다.
                            document.getElementById("my_extraAddress").value = extraAddr;

                        } else {
                            document.getElementById("my_extraAddress").value = '';
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('my_postcode').value = data.zonecode;
                        document.getElementById("my_address").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById("my_extraAddress").focus();
                    }
                }).open();
            }
        </script>
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
