<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">

<%@include file="../lnb.jsp"%>

<article>
<form method="get" name="frm">
    <div class="tb">
     <div class="find-box">
            <select name="part" class="dropdown">
                <option value="" disabled selected hidden>부서명</option>
                <option value="1">개발</option>
                <option value="2">기획</option>
                <option value="3">영업</option>
                <option value="4">운영</option>
                <option value="5">인사</option>
            </select>
    <div class="col search-box">
    <input type="text" name="key" placeholder="검색 내용 입력" value="${key}">
    <input type="button" name="btn_search" value="검색" onclick="go_searchWork('fileMain')" />
    <input type="button" value="자료등록" onclick="location.href='fileInsertForm'" />
    </div>
    </div>

    <div class="header-row">
        <div class="coltitle">부서명</div>
        <div class="coltitle">작성자</div>
        <div class="coltitle">제 목</div>
        <div class="coltitle">작성 일자</div>
        <div class="coltitle">파 일</div>
        <div class="coltitle">비 고</div>
    </div>

<c:forEach var="file" items="${fileList}">
    <div class="row">
        <div class="col">
            <c:choose>
                <c:when test="${file.part == 1}">개발팀</c:when>
                <c:when test="${file.part == 2}">기획팀</c:when>
                <c:when test="${file.part == 3}">영업팀</c:when>
                <c:when test="${file.part == 4}">운영팀 </c:when>
                <c:when test="${file.part == 5}">인사팀 </c:when>
                <c:otherwise>알 수 없음</c:otherwise>
            </c:choose>
        </div>
        <div class="col">${file.name}</div>
        <div class="col">${file.title}</div>
        <div class="col">${file.uploadtime}</div>
        <div class="col">
        <a href="">
        ${file.savedname}
        </a>
        </div>
        <div class="col">
            <div class="updateBtns">
                <input type="button" value="삭제" onClick="deleteFile('${file.id}')" />
            </div>
        </div>
    </div>
</c:forEach>

<div class="row">  <!-- 페이지의 시작 -->
	<div class="col" style="font-size:120%; font-weight:bold;">
	    <c:if test="${paging.prev}" >
	        <a href="fileMian?page=${paging.beginPage-1}">PREV</a>&nbsp;
		</c:if>

		<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
		    <c:if test="${index!=paging.page}">
			    <a href="fileMian?page=${index}">${index}</a>&nbsp;
			</c:if>
			<c:if test="${index==paging.page}">
				<span style="color:red">${index}&nbsp;</span>
			</c:if>
		</c:forEach>

			<c:if test="${paging.next}" >
				<a href="fileMian?page=${paging.endPage+1}">NEXT</a>&nbsp;
			</c:if>
			</div>
            </div>
    </div>
</form>
</article>
</div>