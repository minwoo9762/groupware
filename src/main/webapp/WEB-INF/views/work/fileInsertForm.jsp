<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">
<%@include file="../lnb.jsp"%>

    <form class="containerForm" name="updateBoard" method="post" action="insertFile" >
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
                        <div class="titleWriter" >자료실</div>
                        <div class="titleTitle" >
                            <span id="fileNameDisplay">${dto.savedname}</span>

                        <input type="hidden" name="originalname" value="${dto.originalname}"/>
                        <input type="hidden" name="savedname" value="${dto.savedname}"/>

                            <input type="file" id="fileInput" name="file" style="display: none;" onchange="updateFileName()" />

                            <input type="button" value="파일 선택" onclick="selectFile()"/>
                        </div>
                    </div>

                    <div class="updateBtns">
                        <input type="submit" value="작성완료" />
                        <input type="button" value="돌아가기" onclick="location.href='fileMain'" />
                    </div>

                </div>
            </div>
        </form>
</div>

<%@ include file="../footer.jsp" %>