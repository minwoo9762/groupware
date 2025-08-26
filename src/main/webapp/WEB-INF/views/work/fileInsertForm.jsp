<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>

    <form class="containerForm" name="updateBoard" method="post" action="${pageContext.request.contextPath}/fileInsert" enctype="multipart/form-data">
        <input type="hidden" name="userid" value="${loginUser.id}" />
        <input type="hidden" name="name" value="${loginUser.name}" />
        <input type="hidden" name="part" value="${loginUser.part}" />

        <div class="container">
            <h2 class="head">자료글 작성</h2>
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
                    <div class="titleWriter">파일 업로드</div>
                    <div class="titleTitle">
                        <!-- 선택된 파일명 보여주는 부분 -->
                        <span id="fileNameDisplay">${dto.savedname != null ? dto.savedname : "선택된 파일 없음"}</span>

                        <input type="hidden" name="originalname" value="${dto.originalname}" />
                        <input type="hidden" name="savedname" value="${dto.savedname}" />

                        <!-- 실제 파일 input (숨김) -->
                        <input type="file" id="fileInput" name="file" style="display:none" onchange="showFileName()" />

                        <!-- 파일 선택 버튼 -->
                        <input type="button" value="파일 선택" onclick="document.getElementById('fileInput').click();" />
                    </div>
                </div>

                <div class="updateBtns">
                    <input type="submit" value="작성완료" />
                    <input type="button" value="돌아가기" onclick="location.href='fileMain'" />
                </div>
            </div>
        </div>
    </form>

    <script>
        function showFileName() {
            const fileInput = document.getElementById('fileInput');
            const fileNameDisplay = document.getElementById('fileNameDisplay');
            if (fileInput.files.length > 0) {
                fileNameDisplay.textContent = fileInput.files[0].name;
            } else {
                fileNameDisplay.textContent = "선택된 파일 없음";
            }
        }
    </script>

</div>

<%@ include file="../footer.jsp" %>