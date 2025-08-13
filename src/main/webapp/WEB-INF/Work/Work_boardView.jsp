<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../header.jsp"%>
<form >
    <div class="container">
        <div class="userTitle">
            <div class="name" ><label>작성자</label></div>
            <div class="title"><label>제목</label></div>
        </div>

        <div class="titleDown">
            <div class="name" >${board.name}</div>
            <div class="title">${board.title}</div>
        </div>

        <div class="category">분류</div>
        <div class="categortList"><input type="text" value="게시판" readonly /></div>

        <textarea name="content" value=${board.content}></textarea>

        <div class="btns" >
            <input type="submit" value="작성완료" />
            <input type="button" value="뒤로가기" onclick="return" />
        </div>
    </div>
</form>







<%@include file="../submebu.jsp" %>