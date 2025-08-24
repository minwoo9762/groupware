<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>
<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>

    <article>
    <form class="containerForm" name="updateBoard" id="writeBoard" method="post" action="writeBoard" >
        <input type="hidden" name="userid" value="${loginUser.id}" />
        <input type="hidden" name="name" value="${loginUser.name}" />
        <input type="hidden" name="part" value="${loginUser.part}" />
    <div class="container">
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

                <div class="contentBar">
                    <div class="contentLeft">
                        <div class="second">게시판</div>
                        <div class="first">게시물 등록</div>
                        <div class="second">이미지</div>
                        <div class="imgField">
                        <c:choose>
                    <c:when test="${empty dto.savefilename}">
                        <div>
                            <img src="" id="previewimg"/>
                        </div>
                        <input type="hidden" name="image" />
                        <input type="hidden" name="savefilename" />
                    </c:when>
                    <c:otherwise>
                        <div>
                            <img src="/images/${dto.savefilename}" id="previewimg"/>
                        </div>
                        <input type="hidden" name="image" value="${dto.image}"/>
                        <input type="hidden" name="savefilename" value="${dto.savefilename}"/>
                    </c:otherwise>
                </c:choose>

                <input type="button" value="이미지 선택" onclick="selectImg()"/>
                </div>
             </div>

                    <div class="contentBox"  ><textarea name="content" placeholder="내용을 입력하세요"></textarea> </div>
                </div>

                <div class="updateBtns">
                    <input type="submit" value="작성완료" />
                    <input type="button" value="돌아가기" onclick="location.href='workBoard'" />
                </div>
        </div>
    </div>
    </form>
    </article>
</div>

<%@ include file="../footer.jsp" %>