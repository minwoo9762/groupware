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
                <label>주소</label>
                <input type="text" name="address1" value="${dto.address1}">
                <input type="text" name="address2" value="${dto.address2}">
            </div>
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
