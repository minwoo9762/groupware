<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">

  <%@include file="../lnb.jsp"%>

  <article>
    <form method="get" name="frm">
      <div class="tb">
        <div class="find-box">
          <div class="col search-box">
            <input type="text" name="key" placeholder="검색 내용 입력" value="${key}">
            <input type="button" name="btn_search" value="검색" onclick="go_searchWork('address')" />
            <input type="button" value="주소록 추가" onclick="location.href='addressWrite'" />
          </div>
        </div>

        <div class="header-row">
          <div class="coltitle">부서명</div>
          <div class="coltitle">직 책</div>
          <div class="coltitle">이 름</div>
          <div class="coltitle">연락처</div>
        </div>

        <c:forEach items="userList" var="user">
          <div class="row">
            <div class="col">
              <c:choose>
                <c:when test="${user.part == 1}">개발팀</c:when>
                <c:when test="${user.part == 2}">기획팀</c:when>
                <c:when test="${user.part == 3}">영업팀</c:when>
                <c:when test="${user.part == 4}">운영팀 </c:when>
                <c:when test="${user.part == 5}">인사팀 </c:when>
                <c:otherwise>미정</c:otherwise>
              </c:choose>
            </div>

            <div class="col">
              <c:choose>
                <c:when test="${user.provider == 1}">대표(관리자)</c:when>
                <c:when test="${user.provider == 2}">부장</c:when>
                <c:when test="${user.provider == 3}">과장</c:when>
                <c:when test="${user.provider == 4}">대리</c:when>
                <c:when test="${user.provider == 5}">주임</c:when>
                <c:when test="${user.provider == 6}">사원</c:when>
                <c:otherwise>미정</c:otherwise>
              </c:choose>
            </div>

            <div class="col">${user.name}</div>
            <div class="col">${user.phone}</div>

          </div>
        </c:forEach>

        <div class="row">  <!-- 페이지의 시작 -->
	<div class="col" style="font-size:120%; font-weight:bold;">
	    <c:if test="${paging.prev}" >
	        <a href="address?page=${paging.beginPage-1}">PREV</a>&nbsp;
		</c:if>

		<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
		    <c:if test="${index!=paging.page}">
			    <a href="address?page=${index}">${index}</a>&nbsp;
			</c:if>
			<c:if test="${index==paging.page}">
				<span style="color:red">${index}&nbsp;</span>
			</c:if>
		</c:forEach>

			<c:if test="${paging.next}" >
				<a href="address?page=${paging.endPage+1}">NEXT</a>&nbsp;
			</c:if>
			</div>
            </div>

      </div>
    </form>
  </article>
</div>