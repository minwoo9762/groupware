<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>

    <form method="post" name="email" action="writeEmail">
        <div class="EmailAdr">
            <input type="text" name="address" placeholder="이메일 주소를 입력하세요" />
        </div>

        <div class="EmailContent">
            <textarea rows="8" name="contest" placeholder="내용을 입력하세요"></textarea>
        </div>

        <div class="btn">
            <input type="submit" value="발송" />
            <input type="button" value="뒤로가기" onclick="location.href='/workEmail'" />
        </div>
    </form>
</section>>

</body>
</html>
