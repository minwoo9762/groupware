<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class=" layout" style="display: flex;" id="main">
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
                    <div class="left">${loginUser.name}
                    <c:forEach items="${partList}" var="part">
                        <c:if test="${loginUser.part == part.id}">(${part.name})</c:if>
                    </c:forEach>
                    </div>
                    <div class="right"><input type="text" class="inputText" name="title" placeholder="제목을 입력하세요" /></div>
                </div>

                <div class="bodyBar">
                    <div class="titleWriter" >카테고리</div>
                    <div class="titleTitle" >결재내용</div>
                </div>

                <div class="contentBar" style="height: 300px;">
                    <div class="contentLeft">
                        <div class="second">결재분류</div>
                        <div class="first">
                            <select name="category" class="dropdown">
                                <option value="" disabled selected hidden="">결재분류</option>
                                <option value="0">휴가</option>
                                <option value="1">영수증</option>
                                <option value="2">법인차량</option>
                            </select>
                        </div>
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

</div>>
</body>
</html>