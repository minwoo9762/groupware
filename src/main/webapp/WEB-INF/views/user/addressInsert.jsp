<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../header.jsp"%>

<div class="layout" style="display: flex;" id="main">

  <%@include file="../lnb.jsp"%>

  <article>
    <form method="post" action="addressInsert">
        <input type="hidden" name="pwd" value="${dto.pwd}" />
        <input type="hidden" name="address1" value="${dto.address1}" />
        <input type="hidden" name="address2" value="${dto.address2}" />
        <input type="hidden" name="email" value="${dto.email}" />


      <div class="tb">

        <div class="header-row">
          <div class="coltitle">부서명</div>
          <div class="coltitle">직 책</div>
          <div class="coltitle">이 름</div>
          <div class="coltitle">연락처</div>
        </div>

          <div class="row">
            <div class="col">
            <select class="dropdown">
                <option name="part" value="0">미정</option>
                <option name="part" value="1">개발팀</option>
                <option name="part" value="2">기획팀</option>
                <option name="part" value="3">영업팀</option>
                <option name="part" value="4">운영팀</option>
                <option name="part" value="5">인사팀</option>
            </select>
            </div>

            <div class="col">
            <select class="dropdown">
                <option name="provider" value="0">미정</option>
                <option name="provider" value="1">대표(관리자)</option>
                <option name="provider" value="2">부장</option>
                <option name="provider" value="3">과장</option>
                <option name="provider" value="4">대리</option>
                <option name="provider" value="5">주임</option>
                <option name="provider" value="6">사원</option>
            </select>
            </div>

            <div class="col"><input type="text" class="inputText" name="name" placeholder="제목을 입력하세요" /></div>
            <div class="col"><input type="text" class="inputText" name="phone" placeholder="010-0000-0000" /></div>

          </div>

      </div>
    </form>
  </article>
</div>