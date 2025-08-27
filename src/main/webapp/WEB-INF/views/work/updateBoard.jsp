<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>

    <article>
    <form class="containerForm" name="updateBoard" id="updateBoard" method="post" action="updateBoard" >
      <input type="hidden" name="id" value="${dto.id}" />

      <div class="container">
        <h2 class="head">게시글 수정</h2>
        <div class="mainBox">

            <div class="titleBar">
              <div class="titleWriter">작성자</div>
              <div class="titleTitle" >제 목</div>
            </div>

            <div class="bar">
              <div class="left" >
                  ${dto.name}
              <c:forEach items="${partList}" var="part">
                  <c:if test="${dto.part == part.id}">
                      (${part.name})
                  </c:if>
              </c:forEach>
              </div>
              <div class="right">
                  <input type="text" class="inputText" name="title" value="${dto.title}" placeholder="제목을 입력하세요"/></div>
            </div>

            <div class="bodyBar">
              <div class="titleWriter" >이미지</div>
              <div class="titleTitle" >내 용</div>
            </div>

            <div class="contentBar" style="height: 250px;">
                <div class="contentLeft">
                    <div class="imgField" style="display: flex; flex-direction: column; margin-top: auto;">
                    <c:choose>
                        <c:when test="${empty oldfilename}">
                            <img src="${pageContext.request.contextPath}/images/noname.jpg" alt="기본 이미지" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/${oldfilename}" alt="기존 업로드 이미지" />
                        </c:otherwise>
                    </c:choose>
                    <input type="hidden" name="oldfilename" value="${oldfilename}" />

                    <div class="insertImg" style="text-align: center;">
                <c:choose>
                    <c:when test="${empty dto.savefilename}">
                            <img src="" id="previewimg" style="display: none" alt="미리보기 이미지 없음" />
                        <input type="hidden" name="image" />
                        <input type="hidden" name="savefilename" />
                    </c:when>
                    <c:otherwise>
                    변경 할 이미지
                            <img src="${pageContext.request.contextPath}/images/${dto.savefilename}" id="previewimg" alt="업로드 이미지 미리보기" />
                        <input type="hidden" name="image" value="${dto.image}" />
                        <input type="hidden" name="savefilename" value="${dto.savefilename}" />
                    </c:otherwise>
                </c:choose>
                <input type="button" value="이미지 선택" onclick="selectImg()" />
                </div>
                </div>
                </div>

                <div class="contentBox">
                    <textarea name="content" placeholder="내용을 입력하세요">${dto.content}</textarea>
                </div>
            </div>

            <div class="updateBtns">
              <input type="submit" value="수정완료" />
              <input type="button" value="돌아가기" onclick="location.href='boardViewWithoutCnt?id=${dto.id}'" />
            </div>

        </div>
    </div>
    </form>
    </article>
  </div>

<%@ include file="../footer.jsp" %>

