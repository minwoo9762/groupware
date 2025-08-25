<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class=" layout" style="display: flex;" id="main">
    <%@include file="../lnb.jsp"%>

<div class="container">
    <h2 class="head">공지사항 상세보기</h2>
    <div class="mainBox">

        <div class="titleBar">
            <div class="titleWriter">작성자</div>
            <div class="titleTitle">제목</div>
        </div>

        <div class="bar">
            <div class="left">${notice.userid}</div>
            <div class="right">${notice.title}</div>
        </div>

        <div class="bodyBar">
            <div class="titleWriter">카테고리</div>
            <div class="titleTitle">내 용</div>
        </div>

        <div class="contentBar">
            <div class="contentLeft">
                <div class="second">공지사항</div>
                <div class="first">상세보기</div>
                <div class="second">이미지</div>
                <div class="imgField">
        <c:choose>
          <c:when test="${empty notice.savefilename}">
            <img src="/images/noname.jpg" /><br>
          </c:when>
          <c:otherwise>
            <img src="/images/${notice.savefilename}" />
          </c:otherwise>
        </c:choose>
      </div>
            </div>
            <div class="contentBox">${notice.content}</div>
        </div>

            <div class="updateBtns">
                <button type="button" onclick="updateNotice(${notice.nseq})">수정하기</button>
                <button type="button" onclick="location.href='notice'">돌아가기</button>
            </div>
    </div>
</div>
</div>


<%@ include file="../footer.jsp" %>