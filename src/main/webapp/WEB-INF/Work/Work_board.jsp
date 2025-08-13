<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../header.jsp"%>


<div class="title">
<h2>게시판</h2>
</div>

<div class="contentBox">
    <div class="search">
        <div class="part"><input type="text" name="part" vlaue="${Work.part}" /></div>
        <input type="text" name="search" value="${Work.title}" />
        <div class="byns" ><button>검색</button></div>
    </div>

    <div class="contentTitle">
        <div class="haed"><label>제 목</label></div>
        <div class="writer"><label>작성자</label></div>
        <div class="writerdate"><label>작성일</label></div>
        <div class="reply"><label>댓 글</label></div>
    </div>
        <div class="haed">${board.title}</div>
        <div class="writer">${board.name}</div>
        <div class="writerdate">${board.indate}</div>
        <div class="reply">${board.reply}</div>
        <div class="btns"><button>글쓰기</button></div>
    <div class="contentBox">

    </div>
</div>

<%@include file="../submebu.jsp" %>
