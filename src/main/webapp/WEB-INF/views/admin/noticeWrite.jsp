<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>

    <article>
    <form class="containerForm" name="noticeUpdate" method="post" action="noticeWriteInsert" >
        <input type="hidden" name="userid" value="${loginUser.name}" />
        <input type="hidden" name="id" value="${loginUser.id}" />

    <div class="container">
        <h2 class="head">공지글 작성</h2>
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
                <div class="titleWriter" >이미지</div>
                <div class="titleTitle" >내 용</div>
            </div>

            <div class="contentBar">
                    <div class="contentLeft" >
                        <div class="imgField" style="display: flex; flex-direction: column; margin-top: auto;">
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

                <input type="button" value="이미지 선택" onclick="noticeImg()"/>
                </div>
             </div>
                <div class="contentBox"  ><textarea name="content" placeholder="내용을 입력하세요"></textarea>
                </div>

            </div>

            <div class="updateBtns">
                <input type="submit" value="작성완료" />
                <input type="button" value="돌아가기" onclick="location.href='notice'" />
            </div>
        </div>
    </div>
    </form>
    </article>
</div>

<%@ include file="../footer.jsp" %>