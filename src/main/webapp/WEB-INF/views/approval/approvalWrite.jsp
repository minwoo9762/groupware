<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../header.jsp"%>
<section class="section admin">
    <%@include file="../lnb.jsp"%>

    <form class="containerForm" name="updateBoard" method="post" action="insertApp" >
        <input type="hidden" name="userid" value="${loginUser.id}" />
        <input type="hidden" name="username" value="${loginUser.name}" />
        <input type="hidden" name="part" value="${loginUser.part}" />
    <div class="container">
        <h2 class="head">전자결재 신청</h2>
        <div class="mainBox">
                <div class="titleBar">
                  <div class="titleWriter">작성자</div>
                    <div class="titleTitle">제 목</div>
                </div>

                <div class="bar">
                    <div class="left">${loginUser.name}</div>
                    <div class="right"><input type="text" class="inputText" name="title" placeholder="제목을 입력하세요" /></div>
                </div>

                <div class="bodyBar">
                    <div class="titleWriter" >카테고리</div>
                    <div class="titleTitle" >내 용</div>
                </div>

                <div class="contentBar" style="height:350px;">
                    <div class="contentLeft">
                        <div class="first">
                            <select name="category">
                                <option value="">선택</option>
                                <option value="0">휴가</option>
                                <option value="1">영수증</option>
                                <option value="2">법인차량</option>
                            </select>
                        </div>
                        <div class="second"></div>
             </div>

                    <div class="contentBox"  ><textarea name="content" placeholder="내용을 입력하세요"></textarea> </div>
                </div>

                <div class="updateBtns">
                    <input type="submit" value="작성완료" />
                    <input type="button" value="돌아가기" onclick="location.href='appMain'" />
                </div>
        </div>
    </div>
    </form>

</section>
</body>
</html>