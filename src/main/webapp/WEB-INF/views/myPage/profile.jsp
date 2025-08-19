<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>
<section class="section myPage">
    <%@include file="../lnb.jsp"%>
    <div>
        <h2>Profile</h2>
        <div class="profile">
            <img src="../images/noname.jpg" width="200" height="200">
        </div>
        <div class="field">
            <label>이름</label><div>${loginUser.name}</div>
        </div>
        <div class="field">
            <label>E-Mail</label><div>${loginUser.email}</div>
        </div>
        <div class="field">
            <label>전화번호</label><div>${loginUser.phone}</div>
        </div>
        <div class="field">
            <label>부서</label><div>${partName}</div>
        </div>
        <div class="field">
            <label>주소</label><div>${loginUser.address1} ${loginUser.address2} ${loginUser.address3}</div>
        </div>
        <div class="field">
            <label>권한</label><div>${providerName}</div>
        </div>
        <div class="btn">
            <input type="button" value="프로필 수정" onclick="location.href='updateProfileForm'">
            <input type="button" value="비밀번호 변경" onclick="location.href='changePwd'">
        </div>
    </div>
</section>

</body>
</html>
