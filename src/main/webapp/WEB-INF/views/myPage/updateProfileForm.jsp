<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>
<section class="section myPage">
    <%@include file="../lnb.jsp"%>
    <form action="updateProfile" method="post">
        <div>
            <h2>Update Profile</h2>
            <div class="profile">
                <img src="../images/noname.jpg" width="200" height="200">
            </div>
            <div class="field">
                <label>E-Mail</label>
                <input type="text" name="email" value="${dto.email}" readonly>
            </div>
            <div class="field">
                <label>이름</label>
                <input type="text" name="name" value="${dto.name}">
            </div>
            <div class="field">
                <label>전화번호</label>
                <input type="text" name="phone" value="${dto.phone}">
            </div>
            <div class="field">
                <label>부서</label>
                <input type="text" name="partName" value="${partName}" readonly>
                <input type="hidden" name="part" value="${dto.part}">
            </div>
            <div class="field">
                <label>우편번호</label>
                <div>
                    <input type="text" id="my_postcode" name="zip_num" value="${dto.zipNum}" readonly>
                    <input type="button" value="우편번호 찾기" onclick="findZipNum()">
                </div>
            </div>
            <div class="field">
                <label>주소</label><input type="text" id="my_address" name="address1" value="${dto.address1}" readonly>
            </div>
            <div class="field">
                <input type="text" id="my_detailAddress" name="address2" value="${dto.address2}">
            </div>
            <div class="field">
                <label>상세 주소</label><input type="text" id="my_extraAddress" name="address3" value="${dto.address3}">
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
                <label>권한</label>
                <input type="text" name="providerName" value="${providerName}" readonly>
                <input type="hidden" name="provider" value="${dto.provider}">
            </div>
            <div class="btn">
                <input type="submit" value="수정하기">
                <input type="button" value="돌아가기" onclick="location.href='myPage'">
            </div>
        </div>
        <div>${message}</div>
    </form>
</section>
</body>
</html>
